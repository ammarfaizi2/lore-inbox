Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131385AbRAAHQC>; Mon, 1 Jan 2001 02:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131340AbRAAHPw>; Mon, 1 Jan 2001 02:15:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:4115 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131572AbRAAHPi>;
	Mon, 1 Jan 2001 02:15:38 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: faith@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-prerelease/drivers/char/drm/Makefile libdrm symbol versioning fix 
In-Reply-To: Your message of "Sun, 31 Dec 2000 21:52:16 -0800."
             <20001231215216.A17686@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2001 17:45:05 +1100
Message-ID: <6380.978331505@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000 21:52:16 -0800, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	There is a thread in linux-kernel about how somewhere in
>linux-2.4.0-test13-preX, the Makefile for drivers/char/drm started
>building libdrm.a and not versioning the symbols.  I believe the
>following patch fixes the problem, but I have not tried it for the
>nonmodular case.
>
>	The change is that libdrm.o is built instead of libdrm.a.  This
>object is linked into the kernel if at least one driver that needs it
>is also linked into the kernel.  Otherwise, it is built as a helper
>module which is automatically loaded by modprobe when a module that
>needs it is loaded.

Having drmlib.o as a helper module will defeat the requirements listed
in drivers/char/drm/Makefile (below).  You end up with one copy of the
library being used by all modules.  See my patch earlier today on l-k
that builds two versions of drmlib.a, for kernel and module.  That
patch preserves the drm requirements.

# libs-objs are included in every module so that radical changes to the
# architecture of the DRM support library can be made at a later time.
#
# The downside is that each module is larger, and a system that uses
# more than one module (i.e., a dual-head system) will use more memory
# (but a system that uses exactly one module will use the same amount of
# memory).
#
# The upside is that if the DRM support library ever becomes insufficient
# for new families of cards, a new library can be implemented for those new
# cards without impacting the drivers for the old cards.  This is significant,
# because testing architectural changes to old cards may be impossible, and
# may delay the implementation of a better architecture.  We've traded slight
# memory waste (in the dual-head case) for greatly improved long-term
# maintainability.

BTW, I disagree with this approach but I guess it is up to the drm
maintainers.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
