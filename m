Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSHXHoR>; Sat, 24 Aug 2002 03:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSHXHoR>; Sat, 24 Aug 2002 03:44:17 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:64939 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S315406AbSHXHoP>;
	Sat, 24 Aug 2002 03:44:15 -0400
Date: Sat, 24 Aug 2002 09:48:40 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Oopses in the 2.5.31 kernel
Message-ID: <20020824074840.GA6641@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I have had problems with the 2.5.31 _vanilla_ kernel: When I trying log
in in the next day, then take very long time (about 5s), while console
wake up...

I has seen some oopses in the log, too:

Aug 24 06:24:30 hazard kernel: bad: schedule() with irqs disabled!
Aug 24 06:24:30 hazard kernel: c847dd5c c0252f40 cfee3580 c847dd84
c01132a8 00000002 c02f79b8 fffffff9
Aug 24 06:24:30 hazard kernel: c847dd80 00000046 c847dd94 c01132bf
cfee3580 00000000 c02f79a0 c011b070
Aug 24 06:24:30 hazard kernel: c847c000 c1325800 cf76f200 00000000
00000246 c01f3480 c847c000 cf76f200
Aug 24 06:24:30 hazard kernel: Call Trace: [<c01132a8>] [<c01132bf>]
[<c011b070>] [<c01f3480>] [<c02031f2>]
Aug 24 06:24:30 hazard kernel: [<c02035fe>] [<c021209e>] [<c021214d>]
[<c01efd17>] [<c0212443>] [<c0208cf5>]
Aug 24 06:24:30 hazard kernel: [<c022a33f>] [<c0223b96>] [<c01ecb7b>]
[<c01ecd90>] [<c0137b6d>] [<c0137c52>]
Aug 24 06:24:30 hazard kernel: [<c0106dd3>]


ksymoops 2.4.6 on i686 2.5.31.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.31/ (default)
     -m /boot/System.map-2.5.31 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
c847dd5c c0252f40 cfee3580 c847dd84 c01132a8 00000002 c02f79b0 fffffff8
c847dd80 00000046 c847dd94 c01132bf cfee3580 00000000 c02f79a0 c011b070
c847c000 c1325800 cf784320 00000000 00000246 c01f3480 c847c000 cf784320
Call Trace: [<c01132a8>] [<c01132bf>] [<c011b070>] [<c01f3480>] [<c02031f2>]
 [<c02035fe>] [<c021209e>] [<c021214d>] [<c010593b>] [<c0212443>] [<c0208cf5>]
 [<c022a33f>] [<c0223b96>] [<c01ecb7b>] [<c01ecd90>] [<c0137b6d>] [<c0137c52>]
 [<c0106dd3>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01132a8 <try_to_wake_up+100/10c>
Trace; c01132bf <wake_up_process+b/10>
Trace; c011b070 <do_softirq+a0/ac>
Trace; c01f3480 <dev_queue_xmit+104/2f0>
Trace; c02031f2 <ip_output+ee/158>
Trace; c02035fe <ip_queue_xmit+3a2/4ec>
Trace; c021209e <tcp_transmit_skb+43a/59c>
Trace; c021214d <tcp_transmit_skb+4e9/59c>
Trace; c010593b <__switch_to+33/f4>
Trace; c0212443 <tcp_push_one+73/fc>
Trace; c0208cf5 <tcp_sendmsg+a4d/10f4>
Trace; c022a33f <unix_stream_recvmsg+273/3c0>
Trace; c0223b96 <inet_sendmsg+3e/44>
Trace; c01ecb7b <sock_sendmsg+6f/90>
Trace; c01ecd90 <sock_write+a8/b4>
Trace; c0137b6d <vfs_write+b1/130>
Trace; c0137c52 <sys_write+2a/3c>
Trace; c0106dd3 <syscall_call+7/b>


3 warnings issued.  Results may not be reliable.

And last problem: I cannot load modules into the kernel anymore. I've
got this message:

# modprobe snd-intel8x0
insmod: kernel: QM_SYMBOLS: Bad address
insmod: insmod /lib/modules/2.5.31/kernel/sound/core/snd-rawmidi.o
failed
insmod: insmod snd-intel8x0 failed

My .config is in the attachment.

Sincerely,
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
