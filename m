Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276364AbRI1Wz4>; Fri, 28 Sep 2001 18:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276365AbRI1Wzp>; Fri, 28 Sep 2001 18:55:45 -0400
Received: from earth.ayrnetworks.com ([64.166.72.139]:20494 "EHLO
	earth.ayrnetworks.com") by vger.kernel.org with ESMTP
	id <S276364AbRI1Wzd>; Fri, 28 Sep 2001 18:55:33 -0400
Date: Fri, 28 Sep 2001 15:54:03 -0700 (PDT)
From: Brad Bozarth <prettygood@cs.stanford.edu>
X-X-Sender: <bradb@earth.ayrnetworks.com>
Reply-To: <prettygood@cs.stanford.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Big-endian reading/writing cramfs (vs 2.4.10)
In-Reply-To: <20010928163313.C930@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0109281539220.11173-100000@earth.ayrnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 28, 2001  14:58 -0700, Brad wrote:
> > +#define CRAM_SWAB_16(x)	( ( (0x0000FF00 & (x)) >> 8   ) | \
> > +			  ( (0x000000FF & (x)) << 8 ) )
>
> Why not just use the well-defined le16_to_cpu() and le32_to_cpu() macros?

I did, originally... And it worked in inode.c, but I couldn't get mkcramfs
to compile using those macros.  It's outside of __KERNEL__ so I tried
using __cpu_to_le32.  The following error occurred:

/tmp/ccoK4KS0.o: In function `write_superblock':
mkcramfs.c(.text+0xefc): undefined reference to `__fswab32'
collect2: ld returned 1 exit status

__fswab32 is defined in include/linux/byteorder/swab.h as:

extern __inline__ __const__ __u32 __fswab32(__u32 x)
{
	return __arch__swab32(x);
}

Can you shed some light on the error?  I used my own macros to get around
this issue and it worked, but the defined ones would be cleaner...

Thanks,
Brad Bozarth


