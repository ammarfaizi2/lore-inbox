Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTELAyB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTELAyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:54:01 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:23451 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261775AbTELAx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:53:59 -0400
Date: Sun, 11 May 2003 21:03:12 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
To: Bernhard Kaindl <bernhard.kaindl@gmx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305112106_MC3-1-3868-D6B1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another note: suid is ignored when you are tracing the task which runs
> exec() for a setuid program.

  You're right -- an ordinary user cannot trace minicom's setgroupid
children with -ff (but root now can, where with rc1 that failed too.)

  And this is no longer an strace/ptrace problem at all.

  Minicom hangs on exit (ctrl-a, q, enter) even when strace is not
running (can't believe I just now thought to try that.)

minicom       S C01183A1  4472  1197    834                     (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<c0122f24>] [<c0134a31>] [<c021195b>] [<c0220d79>] [<c020d997>]
  [<c011690d>] [<c020e01a>] [<c013c52e>] [<c013b1d5>] [<c013b23b>] [<c0108b73>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  minicom
>>EIP; c01183a1 <schedule+351/3b0>   <===== ignore this bogus address
Trace; c0122f24 <schedule_timeout+14/a0>
Trace; c0134a31 <__alloc_pages+41/170>
Trace; c021195b <tty_wait_until_sent+9b/e0>
Trace; c0220d79 <rs_close+129/1f0>
Trace; c020d997 <release_dev+247/500>
Trace; c011690d <do_page_fault+11d/43b>
Trace; c020e01a <tty_release+2a/60>
Trace; c013c52e <fput+4e/100>
Trace; c013b1d5 <filp_close+95/a0>
Trace; c013b23b <sys_close+5b/70>
Trace; c0108b73 <system_call+33/38>

It's hung up somewhere inside schedule().


