Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWEZKED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWEZKED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWEZKED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:04:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:23473 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751329AbWEZKEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:04:01 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: Recent x86-64 patch causes many devices to disappear
Date: Fri, 26 May 2006 12:03:54 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       gregkh@suse.de, trenn@suse.de,
       "joachim deguara" <joachim.deguara@amd.com>
References: <4476D020.8070605@garzik.org>
In-Reply-To: <4476D020.8070605@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261203.55108.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 11:53, Jeff Garzik wrote:
> 
> The following patch made A TON of devices disappear on my HP XW9300 
> system.  I complained the day it was committed, but alas...
> 
> > commit 5491d0f3e206beb95eeb506510d62a1dab462df1
> > Author: Andi Kleen <ak@suse.de>
> > Date:   Mon May 15 18:19:41 2006 +0200
> > 
> >     [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
> > 
> >     This is needed to see all devices.
> 
> 
> Finally, I was able to get to testing it, and provide proof that a 
> shitload of devices do indeed disappear:
> 
> 	http://gtf.org/garzik/dammit/
> 
> Files:
> *.rc4		- rc4, plus some libata changes, PCI domains disabled
> *.rc5		- rc5-git1, PCI domains disabled
> *.rc5-pcidom	- rc5-git1, PCI domains enabled
> 
> As the patch doesn't work, and the description is proven patently false, 
> maybe we can now consider reverting it and making a better patch?  My 
> Marvell SATA and MPT Fusion devices are no longer available, as a diff 
> between lspci.rc5 and lspci.rc5-pcidom demonstrates.

Do you have PCI segmentation disabled in your BIOS? 

iirc what the original submitters claimed is that it didn't boot
without that and this option. Maybe they didn't tell me the whole
story.

The problem is that most people cannot figure out how 
to disable this in the BIOS so we needed a way to make it boot
out of the box.

Booting without PCI-X is better than booting with it.

Maybe we should only do this if PCI segmentation is disabled? 

Folks, I would like to have a full confirmation what actually
doesn't work without pci=noacpi.

Thanks.

-Andi

