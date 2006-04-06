Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWDFKWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWDFKWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWDFKW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:22:29 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:18618 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932083AbWDFKWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:22:24 -0400
Date: Thu, 6 Apr 2006 12:21:59 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [BUG] No PS/2 mouse in 2.6.16 - bisect result
Message-ID: <Pine.LNX.4.58.0604061145230.2262@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As decribed in the thread
http://groups.google.com/groups?selm=5V6m7-81J-11@gated-at.bofh.it ,
my mouse does not work in 2.6.16.

Copying the drivers/input/mouse directory from 2.6.15 helped, but 
bisecting gave the below result. Reverting this patch did help,
so it must be some kind of conflict with an input patch, but I can't find 
a way to make git tell me all commits between foo and bar affecting baz.
I don't intend to do it manually.

---------------------------

8ba7b0a14b2ec19583bedbcdbea7f1c5008fc922 is first bad commit
diff-tree 8ba7b0a14b2ec19583bedbcdbea7f1c5008fc922 (from 
91c0bce29e4050a59ee5fdc1192b60bbf8693a6d)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Mon Mar 6 17:38:49 2006 -0800

    Add early-boot-safety check to cond_resched()

    Just to be safe, we should not trigger a conditional reschedule during
    the early boot sequence.  We've historically done some questionable
    early on, and the safety warnings in __might_sleep() are generally
    turned off during that period, so there might be problems lurking.

    This affects CONFIG_PREEMPT_VOLUNTARY, which takes over might_sleep() 
to
    cause a voluntary conditional reschedule.

    Acked-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 397bb2be72349a868d25f8668ee4a7dd86e53c3e 
459acaeb07f5d1b1f993a38b084af4c71d76e354 M        kernel

--------------------------

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set

--------------------------

-- 
Never be afraid to try something new. Remember, amateurs built the
ark; professionals built the Titanic. -- Anonymous
