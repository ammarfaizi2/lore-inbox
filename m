Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276140AbRI1P6I>; Fri, 28 Sep 2001 11:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276141AbRI1P5s>; Fri, 28 Sep 2001 11:57:48 -0400
Received: from [195.223.140.107] ([195.223.140.107]:47860 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276140AbRI1P5q>;
	Fri, 28 Sep 2001 11:57:46 -0400
Date: Fri, 28 Sep 2001 17:58:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [patch] softirq-2.4.10-B2
Message-ID: <20010928175824.H24922@athlon.random>
In-Reply-To: <20010928013106.W14277@athlon.random> <Pine.LNX.4.33.0109280716040.1569-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109280716040.1569-200000@localhost.localdomain>; from mingo@elte.hu on Fri, Sep 28, 2001 at 09:18:17AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 09:18:17AM +0200, Ingo Molnar wrote:
> i've attached the softirq-2.4.10-B2 that has your TASK_RUNNING suggestion,
> Oleg's fixes and this change included.

please include this safety checke too:

--- ./kernel/softirq.c.~1~	Fri Sep 28 17:42:07 2001
+++ ./kernel/softirq.c	Fri Sep 28 17:46:32 2001
@@ -381,6 +381,8 @@
 
 	current->nice = 19;
 	schedule();
+	if (smp_processor_id() != cpu)
+		BUG();
 	ksoftirqd_task(cpu) = current;
 
 	for (;;) {

Andrea
