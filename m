Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTFBH0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTFBH0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:26:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32228 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261998AbTFBH0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:26:38 -0400
Date: Mon, 2 Jun 2003 09:39:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
In-Reply-To: <1054489407.1722.50.camel@iso-8590-lx.zeusinc.com>
Message-ID: <Pine.LNX.4.44.0306020937250.2970-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Jun 2003, Tom Sightler wrote:

> Yes, this is correct.  It's showed as pluginserver in the 'ps ax' output
> but I've since noticed that it is simply a symlink to wine.  Of the two
> wine processes, wine and wineserver, it was the wine frontend process
> that was getting all of the CPU, showing 100% utilization.  Renicing the
> wine process made the problem go away.
> 
> Running the exact same config on a 2.4.20 kernel uses only a few % of
> the CPU.

could you apply the attached patch to 2.5.70 and check whether wine still
uses up 100% CPU time? This might be an artifact introduced by the
different HZ values of 2.4 and 2.5.

	Ingo

--- include/asm-i386/param.h.orig
+++ include/asm-i386/param.h
@@ -2,7 +2,7 @@
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		100		/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif

