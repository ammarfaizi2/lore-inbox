Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUIHU2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUIHU2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUIHU2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:28:16 -0400
Received: from h1.handhelds.org ([192.58.209.91]:1752 "EHLO handhelds.org")
	by vger.kernel.org with ESMTP id S268769AbUIHU14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:27:56 -0400
Message-ID: <413F6B49.8040907@joshuawise.com>
Date: Wed, 08 Sep 2004 16:27:53 -0400
From: Joshua Wise <joshua@joshuawise.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040731)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.8.1-mm4: ptrace: "bad: scheduling while atomic!" followed
 by interrupt-disabling kernel panic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Recently I took the plunge and upgraded my desktop system (an ia32 
Athlon) from 2.4.x to 2.6.8.1-mm4. However, when I attempt to do a 
ptrace on a binary, my kernel spews a few loads of bad: scheduling while 
atomic!, and dies.

Initially, I watched at a console like so:

bluefire ~ # strace ls
execve("/bin/ls", ["ls"], [/* 42 vars */]) = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
Kernel panic - not syncing: Aiee, killing interrupt handler!

Not seeing the Oops or BUG that triggered it, I decided to try again, 
first doing a sysrq-[loglevel]8 to increase verbosity. Only having a pad 
of paper to note debugging output, I have clipped seemingly irrelevant 
bits, as notated by [...]. If you need more detail, please email me. 
Also, this kernel was not compiled with addr2line symbols. If you need 
line numbers, I can recompile it like that for you.

bluefire ~ # strace ls
bad: scheduling while atomic
  [<c01070ee>] dump_stack+0x1e/0x20
  [<c0385500>] schedule+0x4f0/0x50
  [<c0129531>] ptrace_notify_info+0x91/0xf0
  [<c01291b8>] get_signal_to_deliver[...]
  [...]
execve([...]) = 0
bad: scheduling while atomic!
  [...] dump_stack[...]
  [...] schedule[...]
  [...] ptrace_notify_info[...]
  [...]
--- SIGSEGV [...] ---
bad: scheduling while atomic!
  [...] dump_stack[...]
  [...] schedule[...]
  [...] sys_sched_yield[...]
  [...] coredump_wait[...]
  [...] do_coredump[...]
  [...] get_signal_to_deliver[...]
  [...]
Kernel panic - not syncing: Aiee, killing interrupt handler!

Does anyone have any insight?

Thanks,
joshua
