Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbTBCXmO>; Mon, 3 Feb 2003 18:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTBCXmO>; Mon, 3 Feb 2003 18:42:14 -0500
Received: from web80304.mail.yahoo.com ([66.218.79.20]:11346 "HELO
	web80304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266989AbTBCXmN>; Mon, 3 Feb 2003 18:42:13 -0500
Message-ID: <20030203235140.10443.qmail@web80304.mail.yahoo.com>
Date: Mon, 3 Feb 2003 15:51:40 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Possible bug in arch/i386/kernel/process.c for reloading of debug registers (DRx)?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was scanning through the source and noticed the lines below.
Should the code below, be reloading at least the local bits of
DR7 if the current DR7 value != 0?  From a quick glance, it
looks like only if the next task's DR7 value is non-zero,
that DR7 is reloaded.  I'm wondering if this would leave
a new task to receive "local" debug events for the previous
task if prev->DR7!=0 && next->DR7==0.

-Kevin


linux-2.5.59: arch/i386/kernel/process.c: line 462+:

  /*
   * Now maybe reload the debug registers
   */
  if (unlikely(next->debugreg[7])) {
    loaddebug(next, 0);
    loaddebug(next, 1);
    loaddebug(next, 2);
    loaddebug(next, 3);
    /* no 4 and 5 */
    loaddebug(next, 6);
    loaddebug(next, 7);
  }

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
