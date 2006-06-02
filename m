Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWFBF4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWFBF4p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWFBF4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:56:45 -0400
Received: from colo.lackof.org ([198.49.126.79]:65468 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751158AbWFBF4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:56:45 -0400
Date: Thu, 1 Jun 2006 23:56:42 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
Message-ID: <20060602055642.GC1501@colo.lackof.org>
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447FA920.9060509@jp.fujitsu.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 11:57:36AM +0900, Kenji Kaneshige wrote:
...
> As Rajesh pointed out, there are many drivers which initialize the
> device with the wrong order. They should be fixed.

Then you also agree with the patch to pci.txt?

> I would like to
> confirm the correct order to initialize the device again. Is the
> following correct order?
> 
>    (1) pci_request_regions()
>    (2) pci_enable_device()
>    (3) request_irq()
>    (4) free_irq()
>    (5) pci_disable_device()
>    (6) pci_release_regions()

Yes, that's what I would prefer and would like to see reccomended.
Would you like to see that order listed (like you have above)
in the pci.txt file?

A less precise list is in the first section of Documentation/pci.txt.

[ TODO: Can someone define which kernel versions implement "new style"? ]

There's more to this list unfortunately:
	DMA mask settings, MSI support, power state

And probably a few more that I'm not thinking of right now.

Restructing the document to list the steps, indicate which
are optional, and describe each step in order is more than
I can deal with right now.  Section 3 and 5 cover most of
the material but aren't as clear as Kenji's list.

thanks,
grant
