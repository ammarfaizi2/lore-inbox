Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTJJQuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTJJQuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:50:46 -0400
Received: from smtp2.us.dell.com ([143.166.85.133]:23214 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP id S263057AbTJJQuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:50:25 -0400
Date: Fri, 10 Oct 2003 11:50:10 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4] EDD 4-byte MBR disk signature for the boot disk
In-Reply-To: <20031010145137.GC28795@mail.shareable.org>
Message-ID: <Pine.LNX.4.44.0310101139270.12160-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I put a hard disk from another system into my computer, and it has
> the "BOOT" signature, Linux will see two disks with the signature.  Barf!
> Same if I boot from two different disks at different times, and more
> so if one of them fails to boot properly so that it's not even
> possible for the booted kernel to erase the signature on its boot
> disk.

Yes, indeed.  For this to work, the signature on the boot disk need be 
different than the signature on any other attached disk.  4 bytes is 
not enough to put a real UUID into.
 
Where we've put this into practice, we can carefully control the state of 
the disks before Linux starts, so it hasn't been a problem.

This trick (and EDD in general) is most interesting when installing a new 
OS onto a clean (known-state) system.  After that, file system labels, 
partition labels, etc. can provide the uniqueness you're looking for.
 
> It would be better to have the boot loader pick a likely-unique number
> such as the CMOS time in seconds since whenever and store that, and
> pass it as boot parameter to the kernel.  A few bits could be reserved
> to indicate that it was from our boot loaders;

That's a pretty good idea.  I do something like this on IA-64 with 
efibootmgr.  Either the boot manager could generate and write a signature 
to the disk, and pass it via a boot parameter, or as I had envisioned, any 
other tool that speaks int13 could do it too, before the boot loader.  
That's how it's used today - some DOS app writes a constant signature to 
the boot disk, and zeros to the other disks.  Then a Linux userspace tool 
can grab the signature, and compare it against the known constant 
signature.  Passing it as a kernel parameter would remove the need to have 
two tools know the same constant signature.

> it would be good if we had a list of existing per-system-unique
> signatures to avoid.  Do you know of such a list?

I know "DELL" has been used in the past, but regardless, whatever 
signature you use really needs to be unique across all the disks in the 
system, so it isn't important exactly what value is used, as long as only 
the boot disk has it, and your code knows what to look for.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

