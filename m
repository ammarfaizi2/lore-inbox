Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132715AbQKWIMF>; Thu, 23 Nov 2000 03:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132717AbQKWILz>; Thu, 23 Nov 2000 03:11:55 -0500
Received: from adsl-63-205-85-133.dsl.snfc21.pacbell.net ([63.205.85.133]:28932
        "EHLO schmee.sfgoth.com") by vger.kernel.org with ESMTP
        id <S132715AbQKWILv>; Thu, 23 Nov 2000 03:11:51 -0500
Date: Wed, 22 Nov 2000 23:41:41 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include conventions /usr/include/linux/sys ?
Message-ID: <20001122234141.D69611@sfgoth.com>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHOEKLCJAA.law@sgi.com> <8vhhnv$j0d$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <8vhhnv$j0d$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Nov 22, 2000 at 02:35:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> I suggested include/kernel and include/arch with include/linux and
> include/asm being reserved for the kernel interfaces (ioctl and their
> structures mostly.)

That sounds good.  One other refinement I would like to see is that
architecture specific but always present header files don't get used
directly in architecture-independant .c flies.  Some common examples of
this are <asm/io.h> and <asm/uaccess.h>  The problem is that often there
is some code that is identical between some or all of the archs.  Then
one of two things happen:
  * The code gets duplicated in many *.h files with all the bad things that
    comde duplication causes - especially since they're all under seperate
    maintainership
  * We have a big ugly conversion like what happened with 'asm/spinlock.h' ->
    'linux/spinlock.h'

If we only have arch-independant *.c files only include things out of
<kernel/*> (which may, of course, include things in <arch/*>) we can
avoid these conversions in the future and promote code reuse between the
architectures.

Also we should probably consider implementing a reasonalbe hierarchy to
the proposed <kernel/*.h> directory - for instance <kernel/bus/pci.h>.

-Mitch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
