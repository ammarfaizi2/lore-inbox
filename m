Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263465AbTC2VVO>; Sat, 29 Mar 2003 16:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263466AbTC2VVO>; Sat, 29 Mar 2003 16:21:14 -0500
Received: from mailc.telia.com ([194.22.190.4]:13012 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S263465AbTC2VVN>;
	Sat, 29 Mar 2003 16:21:13 -0500
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Message-ID: <3E8610EA.8080309@telia.com>
Date: Sat, 29 Mar 2003 22:32:26 +0100
From: Peter Lundkvist <p.lundkvist@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030311 Debian/1.2.1-10
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bad interactive behaviour in 2.5.65-66 (sched.c)
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have seen long delays when starting e.g. xterm from my
window manager (sawfish) either by keyboard-shortcut or by
menu command (by mouse) starting from 2.5.65. Sometimes it
starts immediately, sometimes after up to 2 seconds (idle
system). If I start a new xterm from xterm it always start
immediately. 2.5.64 always behaved OK.

My first try to solve this problem  was to use some
scheduler parameters from 2.6.64:
    #define MAX_TIMESLICE         (300 * HZ / 1000)
    #define CHILD_PENALTY         95
    #define MAX_SLEEP_AVG         (2*HZ)
    #define STARVATION_LIMIT      (2*HZ)

but got the same behaviour.

2nd try was to use sched.c, sched.h from 2.5.64 in a
2.5.66 build + one line patch in fork.c:
-       p->last_run = jiffies;
+       p->sleep_timestamp = jiffies;

Now the system behaves as it should!

My system is a P-III 700 (Inspiron 4000),
and Debian (X is running at nice = -10).

Best regards,
Peter Lundkvist

