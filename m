Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVBRPfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVBRPfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVBRPfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:35:45 -0500
Received: from smtp.nuvox.net ([64.89.70.9]:10902 "EHLO
	smtp05.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S261208AbVBRPfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:35:36 -0500
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() &&
	irqs_disabled()
From: Dan Dennedy <dan@dennedy.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <1108180477.30605.7.camel@localhost.localdomain>
References: <41FD498C.9000708@comcast.net>
	 <20050130131723.781991d3.akpm@osdl.org> <41FD6478.9040404@comcast.net>
	 <20050130150224.33299170.akpm@osdl.org> <41FD8796.2020509@comcast.net>
	 <1108136133.4149.3.camel@kino.dennedy.org>
	 <20050211184307.GQ16141@conscoop.ottawa.on.ca>
	 <1108180477.30605.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 10:32:52 -0500
Message-Id: <1108740772.4588.3.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested the patches (including for allocation), and it is working
great, but should I only commit for now the deallocation patch? Hmm..
which is worse the debug or the 200K waste?

On Fri, 2005-02-11 at 22:54 -0500, Parag Warudkar wrote:
> Jody,
> This happens every time you connect a device which ends up doing
> ISO_LISTEN_CHANNEL. We fixed the device disconnect case in -mm recently.
> 
> I had sent you and Andrew an alternative patch which fixes this
> dma_pool_create case as well as the dma_pool_destroy case, albeit with a
> disadvantage - The patch does pre-allocation of the IR Legacy DMA in
> _pci_probe and deallocates it in _pci_remove. However I am not truly
> happy with it since it possibly wastes 200K of memory for people who
> don't have devices which need it.
> 
> As I said earlier, I think the way to fix this is via schedule_work
> similar to the disconnect case, but it involves good amount of code
> change. I am working on it - any better ideas most welcome.
> 
> Dan - Can you try the attached patch - on top current -mm1? (It's pretty
> no brainer that it will fix both cases but two testing heads are better
> than one.. :)
> 


