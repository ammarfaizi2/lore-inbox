Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266998AbUBRAwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUBRAwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:52:06 -0500
Received: from palrel13.hp.com ([156.153.255.238]:22449 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266998AbUBRAvc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:51:32 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16434.46860.429861.157242@napali.hpl.hp.com>
Date: Tue, 17 Feb 2004 16:51:24 -0800
To: torvalds@osdl.org, Michel D?nzer <michel@daenzer.net>,
       Anton Blanchard <anton@samba.org>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms
In-Reply-To: <20040217234848.GB22534@krispykreme>
References: <16434.35199.597235.894615@napali.hpl.hp.com>
	<1077054385.2714.72.camel@thor.asgaard.local>
	<16434.36137.623311.751484@napali.hpl.hp.com>
	<1077055209.2712.80.camel@thor.asgaard.local>
	<16434.37025.840577.826949@napali.hpl.hp.com>
	<1077058106.2713.88.camel@thor.asgaard.local>
	<16434.41884.249541.156083@napali.hpl.hp.com>
	<20040217234848.GB22534@krispykreme>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Feb 2004 10:48:49 +1100, Anton Blanchard <anton@samba.org> said:

  Anton> A small thing, could the comment be constrained to 80
  Anton> columns? :)

I don't really see the point of that, given that pretty much all
existing Linux source code is formatted for 100 columns.  I don't feel
strongly about it, however, so I changed it.

>>>>> On Tue, 17 Feb 2004 15:53:05 -0800 (PST), Linus Torvalds <torvalds@osdl.org> said:

  Linus> How about this alternate edited one that gets indentation
  Linus> right and is more explicit about what's going on? Does this
  Linus> work for you?

Fine by me.

>>>>> On Wed, 18 Feb 2004 00:44:16 +0100, Michel Dänzer <michel@daenzer.net> said:

  Michel> looks good to me, except for a detail:

  >> + * Michael Dänzer, the ioctl() is only used on embedded
  >> platforms, so not

  Michel> ^^^^^^^ That's not quite my first name. :)

Sorry about that, fixed below (or so I hope).

	--david

===== drivers/char/drm/radeon_state.c 1.23 vs edited =====
--- 1.23/drivers/char/drm/radeon_state.c	Tue Feb  3 21:29:26 2004
+++ edited/drivers/char/drm/radeon_state.c	Tue Feb 17 16:49:15 2004
@@ -2185,10 +2185,21 @@
 	case RADEON_PARAM_STATUS_HANDLE:
 		value = dev_priv->ring_rptr_offset;
 		break;
+#if BITS_PER_LONG == 32
+	/*
+	 * This ioctl() doesn't work on 64-bit platforms because hw_lock is a
+	 * pointer which can't fit into an int-sized variable.  According to
+	 * Michel Dänzer, the ioctl() is only used on embedded platforms, so
+	 * not supporting it shouldn't be a problem.  If the same functionality
+	 * is needed on 64-bit platforms, a new ioctl() would have to be added,
+	 * so backwards-compatibility for the embedded platforms can be
+	 * maintained.  --davidm 4-Feb-2004.
+	 */
 	case RADEON_PARAM_SAREA_HANDLE:
 		/* The lock is the first dword in the sarea. */
-		value = (int)dev->lock.hw_lock; 
-		break;	
+		value = (long)dev->lock.hw_lock;
+		break;
+#endif
 	case RADEON_PARAM_GART_TEX_HANDLE:
 		value = dev_priv->gart_textures_offset;
 		break;
