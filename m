Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269800AbUJAOgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269800AbUJAOgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 10:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269538AbUJAOgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 10:36:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:37569 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269800AbUJAOej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 10:34:39 -0400
Date: Fri, 1 Oct 2004 07:34:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: CaT <cat@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
In-Reply-To: <20041001103032.GA1049@zip.com.au>
Message-ID: <Pine.LNX.4.58.0410010731560.2403@ppc970.osdl.org>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org>
 <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
 <20041001103032.GA1049@zip.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Oct 2004, CaT wrote:
>
> You meant this, right?
> 
> if (!pr || insert_resource(pr, r) < 0)
> 	printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));

Yup.

> If so then the patch + the above did not work. :/

Damn. 

> BTW. I just realised (and I apologise for not doing so earlier) that I'm
> not using ACPI on this box.

For you, the bigger patch shouldn't have made any difference. But it's 
needed for some other people who have BIOS'es that mark PCI regions as 
being reserved for the motherboard, and they get resource conflicts 
otherwise (resource conflicts that largely go away with 
"insert_resource()", but if we want to change that to "request_resource()" 
then that other patch is needed).

Can you send me your ioports from 2.6.9-rc3 _with_ the 
"request_resource()" change..

		Linus
