Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUBQXyC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUBQXyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:54:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:17865 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266628AbUBQXx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:53:56 -0500
Date: Tue, 17 Feb 2004 15:53:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: davidm@hpl.hp.com
cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms
In-Reply-To: <16434.41884.249541.156083@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0402171552140.2154@home.osdl.org>
References: <16434.35199.597235.894615@napali.hpl.hp.com>
 <1077054385.2714.72.camel@thor.asgaard.local> <16434.36137.623311.751484@napali.hpl.hp.com>
 <1077055209.2712.80.camel@thor.asgaard.local> <16434.37025.840577.826949@napali.hpl.hp.com>
 <1077058106.2713.88.camel@thor.asgaard.local> <16434.41884.249541.156083@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, David Mosberger wrote:
> 
> Here is a proposed patch for fixing the compile-warning that shows up
> when compiling radeon_state.c on a 64-bit platform (Itanium, in my
> case).

How about this alternate edited one that gets indentation right
and is more explicit about what's going on? Does this work for you?

		Linus

---
===== drivers/char/drm/radeon_state.c 1.23 vs edited =====
--- 1.23/drivers/char/drm/radeon_state.c	Tue Feb  3 21:29:26 2004
+++ edited/drivers/char/drm/radeon_state.c	Tue Feb 17 15:51:53 2004
@@ -2185,10 +2185,21 @@
 	case RADEON_PARAM_STATUS_HANDLE:
 		value = dev_priv->ring_rptr_offset;
 		break;
+#if BITS_PER_LONG == 32
+	/*
+	 * This ioctl() doesn't work on 64-bit platforms because hw_lock is a
+	 * pointer which can't fit into an int-sized variable.  According to
+	 * Michel Dänzer, the ioctl() is only used on embedded platforms, so not
+	 * supporting it shouldn't be a problem.  If the same functionality is
+	 * needed on 64-bit platforms, a new ioctl() would have to be added, so
+	 * backwards-compatibility for the embedded platforms can be maintained.
+	 *      --davidm 4-Feb-2004.
+	 */
 	case RADEON_PARAM_SAREA_HANDLE:
 		/* The lock is the first dword in the sarea. */
 		value = (int)dev->lock.hw_lock; 
 		break;	
+#endif
 	case RADEON_PARAM_GART_TEX_HANDLE:
 		value = dev_priv->gart_textures_offset;
 		break;
