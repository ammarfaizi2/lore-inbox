Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbUAPQtc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUAPQtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:49:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48003 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265633AbUAPQtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:49:31 -0500
Date: Fri, 16 Jan 2004 11:51:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: timing code in 2.6.1
Message-ID: <Pine.LNX.4.53.0401161150390.28039@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some drivers are being re-written for 2.6++. The following
construct seems to work for "waiting for an event" in
the kernel modules.

        // No locks are being held
        tim = jiffies + EVENT_TIMEOUT;
        while(!event() && time_before(jiffies, tim))
            schedule_timeout(0);

Is there anything wrong?
Do I have to execute "set_current_state(TASK_INTERRUPTIBLE)" before?
Do I have to execute "set_current_state(TASK_RUNNING)" after?

I don't want to have to change this again so I really need to
know. For instance, if I execute "set_current_state(TASK_INTERRUPTIBLE)"
in version 2.4.24, it didn't hurt anything. In 2.6.1, there are
conditions where schedule_timeout(0) doesn't return if another
task is spinning "while(1) ; ". This is NotGood(tm).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


