Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290229AbSBORLv>; Fri, 15 Feb 2002 12:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290236AbSBORLl>; Fri, 15 Feb 2002 12:11:41 -0500
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:58630 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S290229AbSBORLc>; Fri, 15 Feb 2002 12:11:32 -0500
Date: Fri, 15 Feb 2002 17:11:24 +0000
From: Anton Altaparmakov <aia21@mole.bio.cam.ac.uk>
To: Jos Hulzink <josh@stack.nl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5-pre1: mounting NTFS partitions -t VFAT
In-Reply-To: <20020215112031.S68580-100000@toad.stack.nl>
Message-ID: <Pine.SGI.4.33.0202151704500.893186-100000@mole.bio.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Jos Hulzink wrote:
> Due to a recent change of filesystems, I found the following: 2.5.5-pre1
> mounts my NTFS (win2k) partition as VFAT partition, if told to do so. The
> kernel returns errors, but the mount is there. One write to the partition
> was enough to destroy the entire NTFS partition.
>
> Due to filesystem damage, I didn't test the behaviour of the VFAT driver
> on other filesystems yet.
>
> Kernel 2.4.17 also returns errors, but there the mount fails.
>
> Will try to debug the problem myself this afternoon. Sounds like the VFAT
> procedure ignores some errors.

At a guess (V)FAT is not checking the OEM identifier in the bootsector
which for NTFS is defined as "NTFS " (i.e. NTFS followed by four ASCII
spaces, 0x20 char code. The OEMid is at offset 3 (bytes) into the
bootsector.

If you just add a check to (v)fat boot sector sanity verification (it
does have one right? if not it REALLY ought to have one...) and make sure
the OEMid is not the ntfs one the fat driver will never touch the ntfs
partition. Even better if it would check for the correct FAT oem id but I
think there may be several different ones so it may be easier to just make
sure it is not NTFS.

Best regards,

Anton

