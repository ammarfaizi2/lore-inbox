Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUC3Qph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUC3Qpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:45:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49027 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263745AbUC3QpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:45:17 -0500
Date: Tue, 30 Mar 2004 11:47:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: sched_yield() version 2.4.24
Message-ID: <Pine.LNX.4.53.0403301138260.6967@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anybody know why a task that does:

		for(;;)
		   sched_yield();

Shows 100% CPU utiliization when there are other tasks that
are actually getting the CPU?  It seems that a caller to
sched_yield() does not show that it is sleeping for any
portion of the time it gives up the CPU. On the other hand,
if usleep(0) is substituted, the task is shown to be sleeping.

This shows that the accounting for sched_yield() is mucked
up. It works fine, it gives up the CPU to other tasks. However,
`top` shows it as a CPU hog, which it isn't.

Simple code to check it out:

extern void sched_yield(void);
extern int usleep(int);
int main()
{
#if BAD
    for(;;)
        sched_yield();
#endif
    for(;;)
        usleep(0);
}

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


