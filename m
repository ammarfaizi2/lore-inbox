Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbTBCUcz>; Mon, 3 Feb 2003 15:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTBCUcz>; Mon, 3 Feb 2003 15:32:55 -0500
Received: from main.gmane.org ([80.91.224.249]:34271 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S266020AbTBCUcy>;
	Mon, 3 Feb 2003 15:32:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Kernel 2.4.20 panic in scheduler
Date: Mon, 03 Feb 2003 14:33:15 -0600
Organization: Complete.Org
Message-ID: <87k7gh85pw.fsf@christoph.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (powerpc-unknown-linux-gnu)
Cancel-Lock: sha1:RRf3Nqf6o1f+R9NANRJS84cRDPk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Today I experienced a kernel panic running kernel 2.4.20 (plus the ctx
vserver patch; otherwise vanilla) with a bcm5700 module added in.  It's
running on a dual Xeon Dell PowerEdge 2650.  Those CPUs both feature
hyperthreading, which is enabled, so Linux sees four virtual CPUs.

This is from my handwritten notes from the screen.

Text on screen (from hurriedly-handwritten notes):

Scheduling in interrupt
kernel BUG at sched.c:570!
Invalid operand: 0000
CPU: 0
EIP: 0010:[<c011a201>]

...

Stack: c02b910a 000001c5 00000286 00000000 2088a8e
       .... some intermediate lines skipped ....
       ffffffff c02fbf00 c02fbf00

Call trace: c02a510c c02a4f99 c012c12a c02882ef c027ad7d
       .... some intermediate lines skipped ....
            c012b419 c01208c8 c01218dc c01093ef

Running each of these addresses through ksymoops yields the following:

Adhoc 00000000 Before first symbol
Adhoc 000001c5 Before first symbol
Adhoc 00000286 Before first symbol
Adhoc 02088a8e Before first symbol
Adhoc c01093ef <system_call+33/38>
Adhoc c011a201 <schedule+501/530>
Adhoc c01208c8 <release_task+e8/110>
Adhoc c01218dc <sys_wait4+39c/410>
Adhoc c01218de <sys_wait4+39e/410>
Adhoc c012b419 <sys_release_ip_info+29/60>
Adhoc c012c12a <.text.lock.sys+ea/190>
Adhoc c026910a <tcp_sendpage+11a/160>
Adhoc c027ad7d <tcp_v4_do_rcv+10d/1c0>
Adhoc c02882ef <inet_sock_destruct+ff/1c0>
Adhoc c02a4f99 <rwsem_down_write_failed+29/40>
Adhoc c02a510c <rwsem_down_failed_common+5c/7e>
Adhoc c02b910a <timer_bug_msg+912a/37b20>
Adhoc c02fbc00 <fs_table+40/220>
Adhoc c02fbf00 <uts_sem+8/28>
Adhoc ffffffff <END_OF_CODE+76b8dc8/????>

