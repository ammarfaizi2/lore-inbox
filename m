Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289289AbSAJFQ4>; Thu, 10 Jan 2002 00:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289336AbSAJFQg>; Thu, 10 Jan 2002 00:16:36 -0500
Received: from zeus.kernel.org ([204.152.189.113]:11191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289289AbSAJFQb>;
	Thu, 10 Jan 2002 00:16:31 -0500
Date: Wed, 9 Jan 2002 20:59:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Benjamin S Carrell <ben@xmission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bigggg Maxtor drives (fwd)
In-Reply-To: <3C3D0718.2060602@xmission.com>
Message-ID: <Pine.LNX.4.10.10201092011420.5104-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry but the amount of capacity we are talking about is vastly different.

hdg: Maxtor 4G160J8, ATA DISK drive
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=317632/255/63, UDMA(133)


> >hde: Maxtor 4G160J8, ATA DISK drive
> >hde: 268435455 sectors (137439 MB) w/2048KiB Cache,
> >CHS=266305/16/63, UDMA(33) hde: hde1

Only the patches I have created will allow Linux to address the drives
correctly, since this is a new protocol for loading the taskfile
registers with 48-bit mode.  The other drive is being addressed in 28-bit
mode, and can NEVER access the remaining difference under this protocol.

320,173,056 - 268,435,455 = 5,173,7601 sectors

5,173,7601 * 512 = 26,489,651,712 

Roughly 26.4GB of drive capacity lost, the kernel without patches
will never address more that 137GB, and the loss of usable capacity will
continue to grow until the problem in the kernel is addressed.

All it will take is to have the 2.2/2.4/2.5 kernel maintainers to agree to
the corrective patches.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Wed, 9 Jan 2002, Benjamin S Carrell wrote:

> I would think that you lose that space to formatting (would it not get 
> the size of the drive from the bios?), but I stand open for correction.
> 
> -Ben Carrell
> ben@xmission.com
> 
> Andre Hedrick wrote:
> 
> >another update request --
> >
> >
> >---------- Forwarded message ----------
> >Date: Mon, 31 Dec 2001 12:16:12 -0800
> >From: ablew@internetcds.com
> >To: andre@linux-ide.org
> >Subject: Bigggg Maxtor drives
> >
> >Hi there.  As I understand it you're the linux IDE guy,
> >so if you don't mind answering a question for me, I'd
> >appriciate it.
> >
> >I recently bought a Maxtor 4G160J8.  This hard drive is
> >Maxtor's biggest harddrive as of yet, coming in at
> >160GB.  Linux sees this drive as a mere 134 or so gigs
> >as shown by the below:
> >
> >hde: Maxtor 4G160J8, ATA DISK drive
> >hde: 268435455 sectors (137439 MB) w/2048KiB Cache,
> >CHS=266305/16/63, UDMA(33) hde: hde1
> >
> >Do I need to pass the kernel any arguments though grub
> >to see the full size, or is this just a kernel level
> >limitation?
> >
> >Any help is appriciated.
> >
> >Thanks,
> >-Aaron
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> 
> 

