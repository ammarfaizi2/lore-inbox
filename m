Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbULGLLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbULGLLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbULGLLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:11:12 -0500
Received: from ee.oulu.fi ([130.231.61.23]:41885 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261163AbULGLLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:11:08 -0500
Date: Tue, 7 Dec 2004 13:11:05 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc3 b44 resume problem
Message-ID: <20041207111105.GA28092@ee.oulu.fi>
References: <200412071025.32825.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200412071025.32825.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 10:25:31AM +0100, Robin Rosenberg wrote:
> Hi,
> 
> I can't get my wired network running after resume from suspend to ram:
> 
> Dec  7 18:48:36 xine kernel: ifconfig: page allocation failure. order:8, 
> mode:0x21
> After stopping the network, and netplugd and rmmodding b44 and mii I still get
> this when trying to start my network (when b44 is activate
Hi

For a quick "fix", you can set B44_DMA_MASK to 0xffffffff. But this 
is not really a fix (and will make your machine crash and burn if you have
more than a gig of memory and use something other than a 3:1 memory layout,
but it is essentially the pre-2.6.10 situation so if the driver worked
for you before it will do so again)

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=118165, 

"See last paragraph of comment #66. The problem is that the driver
needs about 750k of memory that has to be located under 1GB physically
to not trigger the hardware bug that causes crashes and other fun. The
driver tries to allocate that kind of memory
(pci_set_consistent_dma_mask(pdev, 0x3fffffff) ). There should be
plenty, right?

Unfortunately the way it's implemented right now in the generic x86
pci code is that if you ask for some memory with a dma mask of < 4GB,
it falls back to giving you memory from the first 16MB. Now that's a
pretty limited resource :-(. There seems to be 3 drivers that need
similar workarounds (wanxl, aacraid and b44)."
