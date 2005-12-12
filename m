Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVLLUWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVLLUWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLLUWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:22:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61420 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750802AbVLLUWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:22:11 -0500
Message-ID: <00a401c5ff59$7958c480$6f00a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Dinakar Guniguntala" <dino@in.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Paul Jackson" <pj@sgi.com>
References: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com> <20051210122548.GB25065@elte.hu>
Subject: Re: [patch -mm] scheduler cache hot autodetect, isolcpus fix
Date: Mon, 12 Dec 2005 12:20:05 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at 2.6.15-rc5-mm2 and there is still a problem:  the
migration_cost[] array is disappearing after boot, which leads to completely
bogus migration_cost[] values when dynamic sched domains are declared.

The fix:

Index: linux/kernel/sched.c
==========================================================
--- linux.orig/kernel/sched.c   2005-12-12 10:30:24.000000000 -0800
+++ linux/kernel/sched.c        2005-12-12 11:25:27.000000000 -0800
@@ -5279,7 +5279,7 @@
  */
 #define MAX_DOMAIN_DISTANCE 32

-static __initdata unsigned long long migration_cost[MAX_DOMAIN_DISTANCE] =
+static unsigned long long migration_cost[MAX_DOMAIN_DISTANCE] =
                { [ 0 ... MAX_DOMAIN_DISTANCE-1 ] = -1LL };

 /*

