Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbRBGOfY>; Wed, 7 Feb 2001 09:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129070AbRBGOfO>; Wed, 7 Feb 2001 09:35:14 -0500
Received: from Cantor.suse.de ([213.95.15.193]:28680 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129067AbRBGOe5>;
	Wed, 7 Feb 2001 09:34:57 -0500
To: michael_e_brown@dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] block ioctl to read/write last sector
In-Reply-To: <Pine.LNX.4.30.0102061520480.26194-200000@blap.linuxdev.us.dell.com>
From: Andi Kleen <freitag@alancoxonachip.com>
Date: 07 Feb 2001 15:34:50 +0100
In-Reply-To: Michael E Brown's message of "6 Feb 2001 22:38:28 +0100"
Message-ID: <ouplmrimuid.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael E Brown <michael_e_brown@dell.com> writes:

> Problem Summary:
>   There is no function exported to userspace to read or write the last
> 512-byte sector of an odd-size disk.
> 
>   The block device uses 1K blocksize, and will prevent userspace from
> seeing the odd-block at the end of the disk, if the disk is odd-size.
> 
>   IA-64 architecture defines a new partitioning scheme where there is a
> backup of the partition table header in the last sector of the disk. While
> we can read and write to this sector in the kernel partition code, we have
> no way for userspace to update this partition block.
> 
> Solution:
>   As an interim solution, I propose the following IOCTLs for the block
> device layer: BLKGETLASTSECT and BLKSETLASTSECT.  These ioctls will take a
> userspace pointer to a char[512] and read/write the last sector. Below is
> a patch to do this.

But what happens when you e.g. run a software blocksize of 4096 and the device
has >1 inaccessible 512 byte sector at the end?
I think it would be better to pass in a offset in 512 byte units to a special
ioctl (and do error checking in the driver for impossible requests)

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
