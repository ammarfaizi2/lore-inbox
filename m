Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUBDRVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUBDRVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:21:32 -0500
Received: from waste.org ([209.173.204.2]:38871 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263775AbUBDRV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:21:27 -0500
Date: Wed, 4 Feb 2004 11:21:16 -0600
From: Matt Mackall <mpm@selenic.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib routines
Message-ID: <20040204172116.GF31138@waste.org>
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com> <20040203175006.GA19751@chaapala-lnx2.cisco.com> <20040203185111.GA31138@waste.org> <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com> <20040203172508.B26222@lists.us.dell.com> <20040203233737.GD31138@waste.org> <yquj4qu6g6ui.fsf@chaapala-lnx2.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yquj4qu6g6ui.fsf@chaapala-lnx2.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 10:14:13AM -0600, Clay Haapala wrote:
> On Tue, 3 Feb 2004, Matt Mackall said:
> > On Tue, Feb 03, 2004 at 05:25:08PM -0600, Matt Domsch wrote:
> >> > >> +MODULE_LICENSE("GPL and additional rights");
> >> > > 
> >> > > "additional rights?"
> >> > > 
> >> > Take it up with Matt_Domsch@dell.com -- it's his code that I
> >> > cribbed, so that's the license line I used.
> >> 
> >> The crc32 code came from linux@horizon.com with the following
> >> copyright abandonment disclaimer, which is still in lib/crc32.c:
> >> 
> >> /*
> >>  * This code is in the public domain; copyright abandoned.
> >>  * Liability for non-performance of this code is limited to the
> >>  * amount you paid for it.  Since it is distributed for free, your
> >>  * refund will be very very small.  If it breaks, you get to keep
> >>  * both pieces.  */
> >> 
> >> Thus GPL plus additional rights is appropriate.
> > 
> > Ok, makes sense for CRC32 stuff which can be easily lifted from the
> > kernel or 50 other places, but not for stuff that's depends on
> > cryptoapi.
> 
> Matt is correct about crypto/crc32c.c -- that should be simply "GPL".
> 
> As for the derived-from-public-domain-CRC32 stuff, should one even
> claim "GPL" on it?  That would be, in effect, licensing public-domain
> code and placing restrictions on it, something only a copyright holder
> should be able to do, and not the intent of the author, in this case.

Hard to guess what the author's intent was as he left no license, but
perhaps you're right. However, public domain works are routinely
relicensed by publishers when they make a trivially derived work, see
any reprint of Shakespeare or Bach. 

As has been pointed out, _not_ putting some sort of license on it
potentially opens people who ship it up to liability. Arguably, by
compiling it into the kernel, you're accepting the GPL liability terms
for that use. But that doesn't stop someone from taking crc32.c,
incorporating it into something else, having it blow up disastrously,
and then suing whoever sold them the kernel tarball. Sounds
outlandish, but crazier things have happened.

As "dual GPL/public domain license" is an oxymoron, the best thing to
do is probably to slap a dual GPL/2-clause BSD license on it to
disclaim liability while minimally limiting all other rights. Matt,
since you're the last one to touch this, I'll let you make the call,
but here's what I would suggest (still needs an actual copyright
notice):

 tiny-mpm/lib/crc32.c |   39 +++++++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff -puN lib/crc32.c~crc-license lib/crc32.c
--- tiny/lib/crc32.c~crc-license	2004-02-04 10:54:57.000000000 -0600
+++ tiny-mpm/lib/crc32.c	2004-02-04 10:58:23.000000000 -0600
@@ -1,4 +1,4 @@
-/* 
+/*
  * Oct 15, 2000 Matt Domsch <Matt_Domsch@dell.com>
  * Nicer crc32 functions/docs submitted by linux@horizon.com.  Thanks!
  *
@@ -12,7 +12,33 @@
  *   drivers/net/smc9194.c uses seed ~0, doesn't xor with ~0.
  *   fs/jffs2 uses seed 0, doesn't xor with ~0.
  *   fs/partitions/efi.c uses seed ~0, xor's with ~0.
- * 
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, and the entire permission notice in its entirety,
+ *    including the disclaimer of warranties.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * ALTERNATIVELY, this product may be distributed under the terms of
+ * the GNU General Public License, in which case the provisions of the GPL are
+ * required INSTEAD OF the above restrictions.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
  */
 
 #include <linux/crc32.h>
@@ -40,16 +66,9 @@
 #define attribute(x)
 #endif
 
-/*
- * This code is in the public domain; copyright abandoned.
- * Liability for non-performance of this code is limited to the amount
- * you paid for it.  Since it is distributed for free, your refund will
- * be very very small.  If it breaks, you get to keep both pieces.
- */
-
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@dell.com>");
 MODULE_DESCRIPTION("Ethernet CRC32 calculations");
-MODULE_LICENSE("GPL and additional rights");
+MODULE_LICENSE("Dual BSD/GPL");
 
 #if CRC_LE_BITS == 1
 /*

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
