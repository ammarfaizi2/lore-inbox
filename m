Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWFHSPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWFHSPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWFHSPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:15:10 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:24752 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964889AbWFHSPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:15:08 -0400
Date: Thu, 8 Jun 2006 14:09:10 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: 2.6.16.18 kernel freezes while pppd is exiting
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200606081412_MC3-1-C1EF-69A3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very infrequently I get kernel freezes while pppd is exiting.
Today I finally got traces from the serial console.

[1410445.728958] Pid: 887, comm:             sendmail
[1410445.743307] EIP: 0060:[<c03b29f8>] CPU: 1
[1410445.755837] EIP is at lock_kernel+0x18/0x30
[1410445.768882]  EFLAGS: 00000286    Not tainted  (2.6.16.18-d4 #6)
[1410445.787126] EAX: d791fa70 EBX: d78dbf2c ECX: 00000000 EDX: d78da000
[1410445.806408] ESI: fffffffe EDI: 00000000 EBP: c139bf14 DS: 007b ES: 007b
[1410445.826787] CR0: 8005003b CR2: 0064ef90 CR3: 174e5000 CR4: 000002d0
[1410445.846068]  [<c0192cfb>] proc_lookup+0x1b/0xd0
[1410445.860260]  [<c018fe7b>] proc_root_lookup+0x2b/0x70
[1410445.875748]  [<c016fbb5>] real_lookup+0xc5/0xf0
[1410445.889939]  [<c016feed>] do_lookup+0x9d/0xb0
[1410445.903607]  [<c01705bc>] __link_path_walk+0x6bc/0xc80
[1410445.919619]  [<c0170bc9>] link_path_walk+0x49/0xd0
[1410445.934588]  [<c03b101d>] schedule+0x38d/0x760
[1410445.948518]  [<c0170fa8>] do_path_lookup+0x138/0x2b0
[1410445.964007]  [<c01629ca>] get_empty_filp+0x6a/0xf0
[1410445.978978]  [<c017118a>] __path_lookup_intent_open+0x4a/0x90
[1410445.996805]  [<c0171205>] path_lookup_open+0x35/0x40
[1410446.012297]  [<c0171a67>] open_namei+0x87/0x680
[1410446.026486]  [<c0160d20>] do_filp_open+0x40/0x60
[1410446.040937]  [<c01610b1>] do_sys_open+0x51/0x90
[1410446.055125]  [<c0161117>] sys_open+0x27/0x30
[1410446.068536]  [<c0102f09>] syscall_call+0x7/0xb

[1410462.415500] Pid: 22020, comm:                 pppd
[1410462.430365] EIP: 0060:[<c015eaae>] CPU: 0
[1410462.442913] EIP is at kfree+0x4e/0x70
[1410462.454413]  EFLAGS: 00000286    Not tainted  (2.6.16.18-d4 #6)
[1410462.472652] EAX: 0000001d EBX: c137a160 ECX: 00000000 EDX: c137f600
[1410462.491936] ESI: c4823800 EDI: 00000286 EBP: 00000001 DS: 007b ES: 007b
[1410462.512314] CR0: 8005003b CR2: 0069f6a0 CR3: 032c5000 CR4: 000002d0
[1410462.531597]  [<c0244d90>] tty_buffer_free_all+0x60/0x80
[1410462.547890]  [<c0246e9d>] release_mem+0x18d/0x1a0
[1410462.562598]  [<c024b130>] n_tty_close+0x0/0x40
[1410462.576529]  [<c02474b1>] release_dev+0x601/0x760
[1410462.591238]  [<c01385f5>] enqueue_hrtimer+0x75/0xc0
[1410462.606469]  [<c013839b>] lock_hrtimer_base+0x2b/0x60
[1410462.622218]  [<c01387b2>] hrtimer_try_to_cancel+0x42/0x70
[1410462.639009]  [<c01387f8>] hrtimer_cancel+0x18/0x20
[1410462.653976]  [<c03b208a>] schedule_hrtimer+0x4a/0xa0
[1410462.669467]  [<c0138abf>] hrtimer_nanosleep+0x6f/0x130
[1410462.685477]  [<c022c032>] copy_to_user+0x42/0x60
[1410462.699926]  [<c0174797>] do_ioctl+0x77/0xa0
[1410462.713337]  [<c0247af4>] tty_release+0x14/0x20
[1410462.727525]  [<c0162b2d>] __fput+0xbd/0xd0
[1410462.740417]  [<c01611cd>] filp_close+0x4d/0x80
[1410462.754349]  [<c016126d>] sys_close+0x6d/0x90
[1410462.768018]  [<c0102f09>] syscall_call+0x7/0xb

pppd seems to be looping here while holding the BKL:

static void tty_buffer_free_all(struct tty_struct *tty)
{
        struct tty_buffer *thead;
        while((thead = tty->buf.head) != NULL) {
                tty->buf.head = thead->next;
                kfree(thead);
        }
        while((thead = tty->buf.free) != NULL) {
                tty->buf.free = thead->next;
====>           kfree(thead);
        }
        tty->buf.tail = NULL;
}

I did alt-sysrq-p over and over and all I got was basically these two
traces -- CPU 1 in lock_kernel() and CPU 0 in kfree().

-- 
Chuck

