Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbTBLNfP>; Wed, 12 Feb 2003 08:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbTBLNfP>; Wed, 12 Feb 2003 08:35:15 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51857 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267144AbTBLNfN>;
	Wed, 12 Feb 2003 08:35:13 -0500
Message-ID: <3E4A4FD8.6070203@magnaspeed.net>
Date: Wed, 12 Feb 2003 07:44:56 -0600
From: Todd Inglett <tinglett@magnaspeed.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sched_init prematurely enables interrupts
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this bit is prematurely enabling interrupts in sched_init:

======== kernel/sched.c 1.1..1.156 ========
D 1.156 03/02/09 21:32:34-08:00 torvalds@home.transmeta.com 179 178 
32/24/2466
P kernel/sched.c
C Make "try_to_wake_up()" care about the state of the process woken up.
C
C This simplifies "default_wake_function()", and makes it possible for
C signal handling to wake up only stopped tasks without races.
C
C It also makes it impossible to wake up already running processes, which
C means that the early boot sequence has to use the (much more correct)
C "wake_up_forked_process()" to put the initial task on the runqueues.

The problem is that wake_up_forked_process() does an rq_unlock(rq) which 
is a spin_unlock_irq.

-todd

