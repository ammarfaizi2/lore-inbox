Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWBWAVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWBWAVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWBWAVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:21:47 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:33546 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1751073AbWBWAVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:21:46 -0500
Date: Thu, 23 Feb 2006 00:21:09 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] Add missing ifdef for VIA RNG code
Message-ID: <20060223002109.GA5085@sirena.org.uk>
Mail-Followup-To: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cookie: Your aim is high and to the right.
User-Agent: Mutt/1.5.11+cvs20060126
X-Spam-Score: -2.5 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Almost all the code for the VIA RNG is guarded with
	__i386__ #ifdefs, the only exception being the enumeration of RNG types
	which is used to index into the rng_vector ops array. This patch adds
	an ifdef around that for consistency and since the guard makes a
	difference when adding new RNG types on non-i386 hardware. [...] 
	Content analysis details:   (-2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all the code for the VIA RNG is guarded with __i386__ #ifdefs,
the only exception being the enumeration of RNG types which is used to
index into the rng_vector ops array.  This patch adds an ifdef around
that for consistency and since the guard makes a difference when adding
new RNG types on non-i386 hardware.

Signed-Off-By: Mark Brown <broonie@sirena.org.uk>

Index: hwrng/drivers/char/hw_random.c
===================================================================
--- hwrng.orig/drivers/char/hw_random.c	2006-02-10 07:22:48.000000000 +0000
+++ hwrng/drivers/char/hw_random.c	2006-02-22 22:59:05.000000000 +0000
@@ -121,7 +121,9 @@ enum {
 	rng_hw_none,
 	rng_hw_intel,
 	rng_hw_amd,
+#ifdef __i386__
 	rng_hw_via,
+#endif
 };
 
 static struct rng_operations rng_vendor_ops[] = {
