Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUEXGmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUEXGmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUEXGmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:42:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3051 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263028AbUEXGmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:42:21 -0400
Date: Mon, 24 May 2004 10:43:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Billy Biggs <vektor@dumbterm.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040524084334.GB24967@elte.hu>
References: <20040523154859.GC22399@dumbterm.net> <200405240254.20171.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405240254.20171.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> >      33 ms : time per NTSC frame
> 
> snip
> 
> The followup email from someone describing good performance may help
> us understand what's going on. Your example of poor performance is one
> when the cpu performance is marginal to get exactly 30 fps processed
> and on the screen. The cpu overhead in 2.6 is slightly higher than 2.4
> so a borderline case may be just pushed over. 

most of the cpu overhead comes from HZ=1000. Especial with SCHED_FIFO
there should be minimal (if any) impact from the scheduler changes -
SCHED_FIFO tasks get all CPU time, no ifs and whens.

could people who experience tvtime performance problems apply the patch
below to change HZ back to 100? Does it have any impact?

	Ingo

--- linux/include/asm-i386/param.h.orig	
+++ linux/include/asm-i386/param.h	
@@ -2,7 +2,7 @@
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		100		/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
 #endif
