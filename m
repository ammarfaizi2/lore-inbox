Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288521AbSANSOw>; Mon, 14 Jan 2002 13:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSANSOm>; Mon, 14 Jan 2002 13:14:42 -0500
Received: from ns.caldera.de ([212.34.180.1]:47503 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S288521AbSANSO3>;
	Mon, 14 Jan 2002 13:14:29 -0500
Date: Mon, 14 Jan 2002 19:13:42 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-lvm@sistina.com
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [RFLART] kdev_t in ioctls
Message-ID: <20020114191342.A3731@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>, linux-lvm@sistina.com,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201140957040.15128-100000@penguin.transmeta.com> <20020114190834.A3473@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114190834.A3473@caldera.de>; from hch@caldera.de on Mon, Jan 14, 2002 at 07:08:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 07:08:34PM +0100, Christoph Hellwig wrote:
> > The good news is that the bit-for-bit representation of old kdev_t and
> > "dev_t" are obviously 100% the same, so we should just make the damn thing
> > be dev_t, and user land will never notice anything.
> 
> Glibc disagrees with you (bits/types.h):
> 
> typedef __u_quad_t __dev_t;             /* Type of device numbers.  */
> 
> We'd have to use __kernel_dev_t instead which again pulls kernel
> headers in..

Argg.  That's also non-funny:

[hch@sb linux]$ grep __kernel_dev_t; include/asm-*/posix_types.h
include/asm-alpha/posix_types.h:typedef unsigned int	__kernel_dev_t;
include/asm-arm/posix_types.h:typedef unsigned short	__kernel_dev_t;
include/asm-cris/posix_types.h:typedef unsigned short	__kernel_dev_t;
include/asm-i386/posix_types.h:typedef unsigned short	__kernel_dev_t;
include/asm-ia64/posix_types.h:typedef unsigned int	__kernel_dev_t;
include/asm-m68k/posix_types.h:typedef unsigned short	__kernel_dev_t;
include/asm-mips64/posix_types.h:typedef unsigned int	__kernel_dev_t;
include/asm-mips/posix_types.h:typedef unsigned int	__kernel_dev_t;
include/asm-parisc/posix_types.h:typedef unsigned int	__kernel_dev_t;
include/asm-ppc/posix_types.h:typedef unsigned int	__kernel_dev_t;
include/asm-s390/posix_types.h:typedef unsigned short	__kernel_dev_t;
include/asm-s390x/posix_types.h:typedef unsigned int	__kernel_dev_t;
include/asm-sh/posix_types.h:typedef unsigned short	__kernel_dev_t;
include/asm-sparc64/posix_types.h:typedef unsigned int	__kernel_dev_t;
include/asm-sparc/posix_types.h:typedef unsigned short	__kernel_dev_t;

