Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTJINVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTJINVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:21:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19425 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262111AbTJINVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:21:42 -0400
Date: Thu, 9 Oct 2003 14:21:41 +0100
From: Matthew Wilcox <willy@debian.org>
To: Erik Mouw <erik@harddisk-recovery.nl>
Cc: Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Xose Vazquez Perez <xose@wanadoo.es>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: two sym53c8xx.o modules
Message-ID: <20031009132141.GF27861@parcelfarce.linux.theplanet.co.uk>
References: <3F84AF3C.9050408@wanadoo.es> <Pine.LNX.4.44.0310090826290.2569-100000@logos.cnet> <20031009122428.GF11525@bitwizard.nl> <20031009123857.GC27861@parcelfarce.linux.theplanet.co.uk> <20031009131152.GG11525@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009131152.GG11525@bitwizard.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 03:11:52PM +0200, Erik Mouw wrote:
> On Thu, Oct 09, 2003 at 01:38:57PM +0100, Matthew Wilcox wrote:
> > Is it really important to change this at this stage of 2.4?  For
> > reference, sym1 has already gone away in 2.6, so it'll be incovenient
> > for users no matter what you change.  Let's stick with the devil we know.
> 
> Yes it is. The _2 driver supports newer hardware (or better: can do
> faster speeds on newer hardware), while the old driver doesn't. The old
> driver, however, is more reliable in case of hardware errors. It's very
> nice to be able to change drivers on the fly without having to figure
> out the full path to the correct module.

No, that's not the point.  For people who are already using either driver,
there's no need to change anything between 2.4 and 2.6.  It's only the
foolish people who compile both as modules that have a problem.

If you change the sym2 driver to have a different module name, now people
have to change when they switch between 2.4 and 2.6.  That's bad.

We've had this problem all through 2.4 and it's never been an issue
until now.  I really think this is one problem which shouldn't be fixed.

> Hmm, just tested the _2 driver and now I remember why I hardly use it
> with flakey drives:
> 
>   root@dagobert:~ # scsiinfo -eXR /dev/sda 0 0 0 0 0 0 0 0 0 0 0 0 0 1
>   <4>sym0:4:0:extraneous data discarded.
>   <4>sym0:4:0:extraneous data discarded.
>   <4>sym0:4:0:extraneous data discarded.
>   <4>sym0:4:0:extraneous data discarded.
>   <4>sym0:4:0:extraneous data discarded.
>   Unable to store Read-Write Error Recovery Page 01h
>   18 00 00 00 18 00 00 00 70 00 05 00 00 00 00 18 
>   00 00 00 00 26 00 00 80 02 00 01 0a 00 00 00 00 
>   00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 
> 
> I haven't figured out what it could be yet, scsiinfo works perfectly
> well with the old sym58xxx driver (and the aic7xxx driver, FWIW).

It works perfectly fine with the drives I have access to under 2.6 ...

> Anyway, here's a patch to rename sym53c8xx_2/sym53c8xx.o to
> sym53c8xx_2/sym53c8xx_2.o. It's against 2.4.22, but should apply to all
> 2.4 kernels.

Please don't apply this patch.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
