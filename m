Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267351AbUHWSip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267351AbUHWSip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUHWSiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:38:10 -0400
Received: from proxy.quengel.org ([213.146.113.159]:4736 "EHLO
	gerlin1.quengel.org") by vger.kernel.org with ESMTP id S266585AbUHWS2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:28:22 -0400
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: 2.6.8.1-mm4 [ls]trace freeze
From: Ralf Gerbig <rge@quengel.org>
Date: Mon, 23 Aug 2004 20:28:19 +0200
Message-ID: <87d61h90ak.fsf-news@hsp-law.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moins,

SuSe 9.1, nforce2, AMD Athlon(tm) XP 2800+, 

2.8.6.1-mm4 with this additional patch:


--- drivers/block/scsi_ioctl.c.orig     2004-08-22 13:38:15.000000000 +0200
+++ drivers/block/scsi_ioctl.c  2004-08-22 20:06:11.000000000 +0200
@@ -192,8 +192,8 @@
                return -EINVAL;
        if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
                return -EFAULT;
-       if (verify_command(file, cmd))
-               return -EPERM;
+/*     if (verify_command(file, cmd))
+               return -EPERM; */                       /* RG */
 
        /*
         * we'll do that later

ltrace -p <pid of mozilla> results in:

bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0124365>] __dequeue_signal+0xf5/0x160
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c0125cce>] get_signal_to_deliver+0x8e/0x390
 [<c0103ddf>] do_signal+0x8f/0x160
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c016490a>] poll_freewait+0x3a/0x50
 [<c0165528>] sys_poll+0x158/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c0103ee7>] do_notify_resume+0x37/0x3c
 [<c01040c6>] work_notifysig+0x13/0x15
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0103ddf>] do_signal+0x8f/0x160
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0138b0f>] __get_free_pages+0x1f/0x40
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02dde55>] schedule_timeout+0xa5/0xb0
 [<c015e382>] pipe_poll+0x32/0x90
 [<c01652d2>] do_pollfd+0x52/0x90
 [<c01653ac>] do_poll+0x9c/0xc0
 [<c016557b>] sys_poll+0x1ab/0x230
 [<c0164920>] __pollwait+0x0/0xc0
 [<c010407b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c016c65b>] inode_update_time+0xbb/0xc0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0117d17>] __wake_up_common+0x37/0x60
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0117d17>] __wake_up_common+0x37/0x60
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0117d17>] __wake_up_common+0x37/0x60
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c016c65b>] inode_update_time+0xbb/0xc0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c01040ed>] syscall_trace_entry+0x11/0x24
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c012610b>] ptrace_notify+0x5b/0x80
 [<c0109070>] do_syscall_trace+0x40/0x70
 [<c0104112>] syscall_exit_work+0x12/0x18
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c011768b>] try_to_wake_up+0x9b/0xb0
 [<c01259dc>] finish_stop+0x3c/0x80
 [<c0125df4>] get_signal_to_deliver+0x1b4/0x390
 [<c0103ddf>] do_signal+0x8f/0x160
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c01c24e2>] copy_to_user+0x32/0x50
 [<c012702e>] sys_rt_sigaction+0x9e/0xb0
 [<c0103ee7>] do_notify_resume+0x37/0x3c
 [<c01040c6>] work_notifysig+0x13/0x15
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
Warning: kfree_skb on hard IRQ d53ebea4
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0151cb8>] sys_read+0x68/0x70
 [<c01040a2>] work_resched+0x5/0x16
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c02d9879>] unix_stream_recvmsg+0x1c9/0x410
 [<c01185da>] sys_sched_yield+0x1a/0x20
 [<c015d99b>] coredump_wait+0x2b/0x90
 [<c015daca>] do_coredump+0xca/0x1e5
 [<c01c1cdc>] memcpy+0x3c/0x50
 [<c01c1d46>] memmove+0x36/0x50
 [<c020ee89>] scrup+0x89/0x110
 [<c0124365>] __dequeue_signal+0xf5/0x160
 [<c01243f3>] dequeue_signal+0x23/0x90
 [<c0125ee7>] get_signal_to_deliver+0x2a7/0x390
 [<c0103ddf>] do_signal+0x8f/0x160
 [<c011b389>] call_console_drivers+0x79/0x110
 [<c011b787>] release_console_sem+0xd7/0xe0
 [<c01c24e2>] copy_to_user+0x32/0x50
 [<c012702e>] sys_rt_sigaction+0x9e/0xb0
 [<c0103ee7>] do_notify_resume+0x37/0x3c
 [<c01040c6>] work_notifysig+0x13/0x15
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c01175c9>] activate_task+0xb9/0xe0
 [<c02dd9c8>] wait_for_completion+0x78/0x100
 [<c0117cd0>] default_wake_function+0x0/0x10
 [<c0117cd0>] default_wake_function+0x0/0x10
 [<c015d937>] zap_threads+0x77/0xb0
 [<c015d9ec>] coredump_wait+0x7c/0x90
 [<c015daca>] do_coredump+0xca/0x1e5
 [<c01c1cdc>] memcpy+0x3c/0x50
 [<c01c1d46>] memmove+0x36/0x50
 [<c020ee89>] scrup+0x89/0x110
 [<c0124365>] __dequeue_signal+0xf5/0x160
 [<c01243f3>] dequeue_signal+0x23/0x90
 [<c0125ee7>] get_signal_to_deliver+0x2a7/0x390
 [<c0103ddf>] do_signal+0x8f/0x160
 [<c011b389>] call_console_drivers+0x79/0x110
 [<c011b787>] release_console_sem+0xd7/0xe0
 [<c01c24e2>] copy_to_user+0x32/0x50
 [<c012702e>] sys_rt_sigaction+0x9e/0xb0
 [<c0103ee7>] do_notify_resume+0x37/0x3c
 [<c01040c6>] work_notifysig+0x13/0x15
Kernel panic - not syncing: Aiee, killing interrupt handler!

after next boot:

strace -p <pid of dhcpd>
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0124365>] __dequeue_signal+0xf5/0x160
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c0125cce>] get_signal_to_deliver+0x8e/0x390
 [<c0103ddf>] do_signal+0x8f/0x160
 [<c02dd689>] schedule+0x269/0x4e0
 [<c01175c9>] activate_task+0xb9/0xe0
 [<c02dd92a>] preempt_schedule+0x2a/0x50
 [<c01c01b5>] rwsem_wake+0x145/0x190
 [<c02dd689>] schedule+0x269/0x4e0
 [<c012e8a0>] do_futex+0x80/0xb0
 [<c0103240>] sys_rt_sigsuspend+0xa0/0xc0
 [<c0104029>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c012e8a0>] do_futex+0x80/0xb0
 [<c0103235>] sys_rt_sigsuspend+0x95/0xc0
 [<c0104029>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0124365>] __dequeue_signal+0xf5/0x160
 [<c012604c>] ptrace_notify_info+0x7c/0xe0
 [<c0125cce>] get_signal_to_deliver+0x8e/0x390
 [<c0103ddf>] do_signal+0x8f/0x160
 [<c011b787>] release_console_sem+0xd7/0xe0
 [<c0108a78>] sys_ptrace+0xf8/0x6b0
 [<c0103240>] sys_rt_sigsuspend+0xa0/0xc0
 [<c0104029>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c02dd813>] schedule+0x3f3/0x4e0
 [<c0103235>] sys_rt_sigsuspend+0x95/0xc0
 [<c0104029>] sysenter_past_esp+0x52/0x71

^C strace, dhcpd hogs the cpu -

kill dhcpd

--freeze--

hope it helps,
 
Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
