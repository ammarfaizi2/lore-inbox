Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTK3RkE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbTK3RkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:40:03 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:14824 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S264978AbTK3Rj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:39:57 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: question about preempt_disable()
Date: Sun, 30 Nov 2003 18:39:48 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.11.30.17.39.47.71027@smurf.noris.de>
References: <000d01c3b6dd$30ab34a0$8a04a943@bananacabana>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1070213988 17254 192.109.102.39 (30 Nov 2003 17:39:48 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 30 Nov 2003 17:39:48 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chris Peterson wrote:

> My question is: if the code is already SMP-safe and holding the necessary
> spinlocks, why is the preempt count necessary? Why must preemption be
> disabled and re-enabled as spinlocks are acquired and released?

You need to prevent deadlocks. Imagine process A grabbing a spinlock, then
getting preempted. Process B now sits there and waits on the spinlock.
Forward progress may or may not happen when the scheduler preempts B and
restarts A, some indeterminate time later.

Scheduling when waiting for a spinlock doesn't make sense because usually
the spinlock is held for just a few cycles (that's why it's a spin lock
and not a semaphore / wait queue / whatever), and rescheduling would take
more time than just waiting.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You will have many recoverable tape errors.

