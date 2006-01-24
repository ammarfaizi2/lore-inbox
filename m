Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWAXAZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWAXAZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWAXAZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:25:07 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44799 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030226AbWAXAZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:25:06 -0500
Subject: Re: 2.6.15-rt12 bugs
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 19:24:57 -0500
Message-Id: <1138062297.6695.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 14:21 +0100, Michal Piotrowski wrote:
> Hi,
> 
> I have noticed some bugs in latest 2.6.15-rt12, here are some of them:
> http://www.stardust.webpages.pl/files/rt/2.6.15-rt12/rt-dmesg

The only bug I see in this is:

BUG: kstopmachine:338 task might have lost a preemption check!
 [<c0103b1b>] dump_stack+0x1b/0x1f (20)
 [<c0118736>] preempt_enable_no_resched+0x4a/0x50 (20)
 [<c014224d>] restart_machine+0x1a/0x1d (12)
 [<c0142274>] do_stop+0x24/0x65 (20)
 [<c012d6de>] kthread+0x7b/0xa9 (36)
 [<c01010c5>] kernel_thread_helper+0x5/0xb (135438364)


Which I'll go and take a look at.  I need to turn on
CONFIG_DEBUG_PREEMPT on my SMP machine.


> Here is my config:
> http://www.stardust.webpages.pl/files/rt/2.6.15-rt12/rt-config

You might want to turn off:

CONFIG_DEBUG_STACKOVERFLOW

This dumps out the biggest stack usage.  Those dumps are caused by this,
and are not bugs.  It just shows you what's using the most stack, that's
all.  I find it quite annoying, and just turn it off.

-- Steve

