Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUHJBI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUHJBI5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUHJBI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:08:57 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4047 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267382AbUHJBI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:08:56 -0400
Subject: Re: 2.4.x vs 2.6.x: denormal handling and audio performance
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
In-Reply-To: <1092099606.22613.12.camel@mindpipe>
References: <1092079195.16794.257.camel@cmn37.stanford.edu>
	 <1092099606.22613.12.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1092100150.22613.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 21:09:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 21:00, Lee Revell wrote:
> On Mon, 2004-08-09 at 15:19, Fernando Pablo Lopez-Lezcano wrote:
> > Hi all, I've been trying to track weird behavior I'm experiencing when
> > trying to use 2.6.x for "pro audio" applications
>
> In case anyone thinks this is an application bug, here are some links
> pertaining to the P4 denormals-are-zero issue


If the denormals-are-zero bit is the issue then I believe this patch
should fix the problem.

Lee

--- arch/i386/kernel/i387_orig.c	2004-08-09 21:06:00.000000000 -0400
+++ arch/i386/kernel/i387.c	2004-08-09 21:06:05.000000000 -0400
@@ -34,7 +34,7 @@
 		memset(&current->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
 		asm volatile("fxsave %0" : : "m" (current->thread.i387.fxsave)); 
 		mask = current->thread.i387.fxsave.mxcsr_mask;
-		if (mask == 0) mask = 0x0000ffbf;
+		if (mask == 0) mask = 0x0000ffff;
 	} 
 	mxcsr_feature_mask &= mask;
 	stts();



