Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVAKO36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVAKO36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVAKO36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:29:58 -0500
Received: from ozlabs.org ([203.10.76.45]:48865 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262770AbVAKO3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:29:55 -0500
Date: Wed, 12 Jan 2005 01:27:11 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: reduce paca[] where possible
Message-ID: <20050111142711.GA1000@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On UP builds we include lots of spare pacas. Lets get rid of them and
save some space. Also catch the small SMP case.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/pacaData.c~reduce_paca arch/ppc64/kernel/pacaData.c
--- foobar2/arch/ppc64/kernel/pacaData.c~reduce_paca	2005-01-12 00:34:29.225334524 +1100
+++ foobar2-anton/arch/ppc64/kernel/pacaData.c	2005-01-12 00:34:29.244480855 +1100
@@ -78,13 +78,16 @@ struct paca_struct paca[] = {
 #else
 	PACAINITDATA( 0, 1, NULL, STAB0_PHYS_ADDR, STAB0_VIRT_ADDR),
 #endif
+#if NR_CPUS > 1
 	PACAINITDATA( 1, 0, NULL, 0, 0),
 	PACAINITDATA( 2, 0, NULL, 0, 0),
 	PACAINITDATA( 3, 0, NULL, 0, 0),
+#if NR_CPUS > 4
 	PACAINITDATA( 4, 0, NULL, 0, 0),
 	PACAINITDATA( 5, 0, NULL, 0, 0),
 	PACAINITDATA( 6, 0, NULL, 0, 0),
 	PACAINITDATA( 7, 0, NULL, 0, 0),
+#if NR_CPUS > 8
 	PACAINITDATA( 8, 0, NULL, 0, 0),
 	PACAINITDATA( 9, 0, NULL, 0, 0),
 	PACAINITDATA(10, 0, NULL, 0, 0),
@@ -209,4 +212,7 @@ struct paca_struct paca[] = {
 	PACAINITDATA(127, 0, NULL, 0, 0),
 #endif
 #endif
+#endif
+#endif
+#endif
 };
_
