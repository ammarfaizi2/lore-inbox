Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269738AbUJMQLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269738AbUJMQLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 12:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269742AbUJMQLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 12:11:40 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:8481 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269745AbUJMQLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 12:11:20 -0400
Message-ID: <265e388f0410130911fe6df0d@mail.gmail.com>
Date: Wed, 13 Oct 2004 11:11:19 -0500
From: Vx Glenn <VxGlenn@gmail.com>
Reply-To: Vx Glenn <VxGlenn@gmail.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: select, jiffies, and SIGALRM
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am seeing an issue relating to the jiffies counter wrapping around
at 0x7FFFFFFF.

This is a legacy application, and when it runs on 32-bit Unix-Like
OS's, the application silently dies without leaving core after 248
days.

I was able to manipulate the jiffies counter and run the application.
I was able to reproduce the problem. I captured an strace log, and I
see that SIGALRM (alarm clock) is raised after select times out
(because of no data).

I can add a signal handler to intercept the SIGALRM. But my question
is, why should the signal be raised?

---[ strace.log ]---
select(1024, [3 4 5 6], NULL, NULL, {0, 320000}) = 0 (Timeout)
getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={0, 684895}}) = 0
adjtimex({modes=32769, offset=0, freq=0, maxerror=16384000,
esterror=16384000, status=64, constant=2, precision=1,
tolerance=33554432, time={1097551596, 43475}}) = 5
getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={0, 684895}}) = 0
select(1024, [3 4 5 6], NULL, NULL, {1, 0}) = ? ERESTARTNOHAND (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
Process 4881 detached
---[ eof strace.log ]---


Anyone have any ideas?


-- 
You're not your Job; 
You're not the contents of your wallet.
You're the all singing all dancing crap of the world
