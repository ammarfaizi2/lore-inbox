Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUBZMRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 07:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUBZMRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 07:17:18 -0500
Received: from web11804.mail.yahoo.com ([216.136.172.158]:27212 "HELO
	web11804.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262592AbUBZMRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 07:17:14 -0500
Message-ID: <20040226121713.21924.qmail@web11804.mail.yahoo.com>
Date: Thu, 26 Feb 2004 13:17:13 +0100 (CET)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: BOOT_CS
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  What I did is simply load and uncompress Linux to a legally allocated
> >  HIMEM block (so that is a 100 % compatible DOS software, you can use
> >  a network disk or a disk cache for that) and check everything is right
> >  before disabling interruption, switch back to real mode with
> >  4 Gb segments of non paged memory, copy the block at the right place, 
> >  and start Linux in protected mode.
> 
> [...]
> 
> There is a hook in the kernel immediately after enteing protected mode
> for *exactly* this reason -- it was added to support LOADLIN.  The
> whole point is that your boot loader obtains control at that point so
> you can put things back where they need to go (such as 0x100000 for
> the main part of the kernel, which you will *never* get from an
> HMA-enabled DOS.)  The algorithm for that is pretty straightforward;
> you can even deal with the case where you have scattered pages all
> over memory.

  This interface is nice when the VCPI is loaded and running, but if
 only EMM386 is loaded and VCPI not active you cannot use it.

 Extract of "manual.txt" of "lodlin16.tgz":
>>>>>>>>>>>>
 Therefore:
 - You must be in 86 real mode (no EMS driver, no WINDOWS, no Windows 95
Graphics mode ...). or
 - You must have the VCPI server enabled in your EMS driver (still not
running WINDOWS or Windows 95, however).
   Using EMM386 please avoid the NOVCPI-option, but NOEMS doesn't hurt.
-------------
 May be that your VCPI server does garbage collection before entering
 protected mode, so please BE PATIENT, especially on systems with many
 mega bytes ! 
<<<<<<<<<<<<<<

  If the user of this boot floppy has not allocated some VCPI memory,
 usual for a boot floppy, the VCPI server is not active - only the
 GEMMIS interface is useable.

 Note that the user does not usually know in which mode the VCPI
 server is - and on this floppy lying in this box there is still maybe
 a EMM386/compatible software who cannot do VCPI.

 Moreover starting the VCPI server for just using the interface to
 exit it to real mode is really slow, the 4K pages have to be
 copied all other the place (the logical pages address increase
 with physical two lowest bit decreasing, pages are numbered
 0x13 0x12 0x11 0x10 0x17 0x16 0x15 0x14 ...).
 At last you are not guarantied some of the kernel pages have not been
 pushed to the swapping device (VCPI can do that if low memory).

 The GEMMIS interface is always available when VCPI is not present
 because that is the one the operating system dated 95/98 uses.

 With the latter interface you just do the XMS allocation and relocate
 like my bootloader. Once this is done, you do not need more work to
 support the case when the VCPI is running: the XMS allocation is
 still there and contigous memory.

 begining to be seriously off topic,
 Etienne.





	

	
		
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout ! 
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Dialoguez en direct avec vos amis grâce à Yahoo! Messenger !Téléchargez Yahoo! Messenger sur http://fr.messenger.yahoo.com
