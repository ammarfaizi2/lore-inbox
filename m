Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTF1Xme (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265472AbTF1Xme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:42:34 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:50589 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265335AbTF1Xmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:42:33 -0400
Date: Sat, 28 Jun 2003 16:56:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: Olivier NICOLAS <olivn@trollprod.org>
Cc: green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.7x: processes in D state
Message-Id: <20030628165650.3e2353a5.akpm@digeo.com>
In-Reply-To: <3EFDA6C4.3090906@trollprod.org>
References: <3EF0CBCB.4010202@trollprod.org>
	<20030619060217.GA23774@namesys.com>
	<3EFDA6C4.3090906@trollprod.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2003 23:56:50.0575 (UTC) FILETIME=[F13489F0:01C33DD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier NICOLAS <olivn@trollprod.org> wrote:
>
> It still hapen in 2.5.73-bk5
> 
>  See Sys-Rq T output in attached file

This is the offending process:

pdflush       D 00000001 4294957500    10      1            11     9 (L-TLB)
dfdd5d28 00000046 c039d540 00000001 00000003 c02450f3 d4cc7a44 dfdd5d18 
       dfdd5d18 dfda16a0 dfdd5d1c c03d7380 dfdd7980 00000283 00000246 ce311a0c 
       c039d540 c03d7a00 dfdd5d64 dfdd5d34 c011ddb4 ce16a888 dfdd5d90 c0160ad9 
Call Trace:
 [<c02450f3>] generic_unplug_device+0x83/0xc0
 [<c011ddb4>] io_schedule+0x24/0x30
 [<c0160ad9>] __wait_on_buffer+0x99/0xd0
 [<c011f210>] autoremove_wake_function+0x0/0x50
 [<c011f210>] autoremove_wake_function+0x0/0x50
 [<c01e57dd>] flush_commit_list+0x34d/0x440
 [<c01e9f8c>] do_journal_end+0x71c/0xbe0
 [<c01e911d>] flush_old_commits+0x12d/0x1c0
 [<c01b5521>] __log_start_commit+0x31/0x40
 [<c01d6c48>] reiserfs_write_super+0xa8/0xf0
 [<c0166784>] sync_supers+0x164/0x180
 [<c01434d8>] wb_kupdate+0x48/0x190
 [<c011c2e4>] schedule+0x114/0x5e0
 [<c0143d32>] __pdflush+0x162/0x350
 [<c0143f20>] pdflush+0x0/0x20
 [<c0143f31>] pdflush+0x11/0x20
 [<c0143490>] wb_kupdate+0x0/0x190
 [<c01073b9>] kernel_thread_helper+0x5/0xc

It looks like some IO got submitted and then was simply lost.

I can see you're using SMP.  Preempt or not?

What disk controller hardware are you using? And which device drivers
for that hardware?
