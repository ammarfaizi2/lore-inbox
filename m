Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSBRBDg>; Sun, 17 Feb 2002 20:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293449AbSBRBD1>; Sun, 17 Feb 2002 20:03:27 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:13017 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293448AbSBRBDO>; Sun, 17 Feb 2002 20:03:14 -0500
Date: Sun, 17 Feb 2002 18:02:56 -0700
Message-Id: <200202180102.g1I12un22630@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Carsten Otte" <COTTE@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.417 devfs 64bit portablility issue
In-Reply-To: <OFA3A51DAC.14854039-ONC1256B5D.0045F62F@de.ibm.com>
In-Reply-To: <OFA3A51DAC.14854039-ONC1256B5D.0045F62F@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte writes:
> In linux-2.4.17/fs/devfs/util.c, I found the following code:
> struct major_list
> {
>     spinlock_t lock;
>     __u32 bits[8];
> };
> 
> static struct major_list block_major_list =
> {SPIN_LOCK_UNLOCKED,
>     {0xfffffb8f,  /*  Majors 0   to 31   */
[...]
>      0xffff0000}  /*  Majors 224 to 255  */
> };
> 
> Afterwards, the block_major_list.bits is processed using
> find_first_zero_bit & set_bit out of asm/bitops.h.
> Since bitops are only defined for the datatype long, this does
> only work on 32-bit architectures (on 64 bit data gets
> incorrectly alligned -not on 8byte boundary & the ordering of
> the data is incorrect).
> I attached a patch that should fix it for all architectures.

Sorry, but I find your approach grotesque. Apart from basic warts such
as not declaring code+data as __init, the approach of populating the
bitfield from yet another list doesn't appeal to me. I'd much rather
see an approach which preserved the initialisation using bitmasks.

> (See attached file: linux-2.4.17-devfs_fixup.diff)

BTW: please don't send attachments. Send patches inline instead.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
