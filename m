Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTJ3UI1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 15:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTJ3UI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 15:08:27 -0500
Received: from www1.cdi.cz ([194.213.194.49]:64652 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S262797AbTJ3UIQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 15:08:16 -0500
Date: Thu, 30 Oct 2003 20:50:16 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: Daniel Blueman <daniel.blueman@gmx.net>
cc: <netdev@oss.sgi.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test9] QoS HTB crash...
In-Reply-To: <26412.1067530225@www3.gmx.net>
Message-ID: <Pine.LNX.4.33.0310302047440.11221-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-CDI: passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the report. I know that there is an issue regarding
HTB in 2.6.x. Please send me net/sched/sch_htb.o,
net/sched/sch_htb.c (just to be sure) and be sure that you
build the kernel with debugging symbols (see debugging section
of menuconfig/xconfig).

thanks,
-------------------------------
    Martin Devera aka devik
Linux kernel QoS/HTB maintainer
  http://luxik.cdi.cz/~devik/

On Thu, 30 Oct 2003, Daniel Blueman wrote:

> With the LARTC 'wondershaper' HTB script [1] for good latency over ADSL, I
> get an oops [3] when sending traffic via ppp0 (and when bringing the interface
> down).
>
> Kernel is 2.6.0-test9 and 'debug 3333333' appended to the 'tc' command, to
> show HTB debug information [2] (not shown in [1]).
>
> Please CC me when replying, and I can provide further details, debugging,
> testing etc...this problem has been around for a while it seems.
>
> --- [1] (relevant lines from http://lartc.org/wondershaper/)
>
> tc qdisc add dev ppp0 root handle 1: htb default 20
> tc class add dev ppp0 parent 1: classid 1:1 htb rate 210kbit burst 6k
> tc class add dev ppp0 parent 1:1 classid 1:10 htb rate 210kbit burst 6k prio
> 1
> tc class add dev ppp0 parent 1:1 classid 1:20 htb rate 189kbit burst 6k prio
> 2
> tc class add dev ppp0 parent 1:1 classid 1:30 htb rate 168kbit burst 6k prio
> 2
>
> --- [2] (HTB debug messages)
>
> HTB init, kernel part version 3.13
> htb_init sch=dc28e7f8 handle=10000 r2q=10
> htb_dump sch=dc28e7f8, handle=10000
> htb*g j=179519 lj=0
> htb*r7 m=0
> htb*r6 m=0
> htb*r5 m=0
> htb*r4 m=0
> htb*r3 m=0
> htb*r2 m=0
> htb*r1 m=0
> htb*r0 m=0
> htb_get clid=10010 q=dc28e86c cl=00000000 ref=0
> htb_get clid=10010 q=dc28e86c cl=00000000 ref=0
> htb_get clid=10020 q=dc28e86c cl=00000000 ref=0
> htb_get clid=10020 q=dc28e86c cl=00000000 ref=0
> htb_get clid=10030 q=dc28e86c cl=00000000 ref=0
> htb_get clid=10030 q=dc28e86c cl=00000000 ref=0
> htb_tcf q=dc28e86c clid=0 fref=0 fl=00000000
> htb_bind q=dc28e86c clid=10010 cl=00000000 fref=0
> htb_tcf q=dc28e86c clid=0 fref=1 fl=df4ecd7c
> htb_bind q=dc28e86c clid=10010 cl=00000000 fref=1
> htb_tcf q=dc28e86c clid=0 fref=2 fl=df4ecd7c
> htb_bind q=dc28e86c clid=10010 cl=00000000 fref=2
> htb_tcf q=dc28e86c clid=0 fref=3 fl=df4ecd7c
> htb_bind q=dc28e86c clid=10020 cl=00000000 fref=3
> htb_reset sch=dc28e7f8, handle=10000
>
> --- [3] (ksymoops-processed oops report)
>
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c02cbbad>]    Not tainted
>
> >>EIP; c02cbbad <htb_enqueue+ab/126>   <=====
>
> >>ebx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
> >>ecx; dc28e86c <_end+1be20f60/3fb906f4>
> >>esi; d9cf3f50 <_end+19886644/3fb906f4>
> >>edi; dc28e7f8 <_end+1be20eec/3fb906f4>
> >>ebp; dbef5ab8 <_end+1ba881ac/3fb906f4>
> >>esp; dbef5a9c <_end+1ba88190/3fb906f4>
>
> Trace; c02b3570 <dev_queue_xmit+593/73a>
> Trace; c02e9c98 <ip_finish_output2+0/1c4>
> Trace; c02e9d97 <ip_finish_output2+ff/1c4>
> Trace; c02c0259 <nf_hook_slow+ef/13a>
> Trace; c02e9c98 <ip_finish_output2+0/1c4>
> Trace; c02e76d7 <ip_finish_output+21d/222>
> Trace; c02e9c98 <ip_finish_output2+0/1c4>
> Trace; c02bff12 <nf_iterate+6b/9f>
> Trace; c02e9c80 <dst_output+15/2d>
> Trace; c02c0259 <nf_hook_slow+ef/13a>
> Trace; c02e9c6b <dst_output+0/2d>
> Trace; c02e9620 <ip_push_pending_frames+3ac/408>
> Trace; c02e9c6b <dst_output+0/2d>
> Trace; c030da69 <udp_push_pending_frames+134/23c>
> Trace; c030e1b4 <udp_sendmsg+60d/f3d>
> Trace; c031900a <inet_sendmsg+4b/56>
> Trace; c02aa4cc <sock_sendmsg+92/af>
> Trace; c02aa582 <sock_recvmsg+99/b4>
> Trace; c02a9f68 <move_addr_to_kernel+7e/a7>
> Trace; c02b01a0 <verify_iovec+80/fa>
> Trace; c02ac13d <sys_sendmsg+256/2f4>
> Trace; c0141e28 <filemap_nopage+21c/2f9>
> Trace; c0155610 <do_no_page+29b/631>
> Trace; c0155c54 <handle_mm_fault+132/30c>
> Trace; c018becd <inode_update_time+8e/b9>
> Trace; c0119419 <do_page_fault+34b/56a>
> Trace; c02ac67e <sys_socketcall+261/29a>
> Trace; c0164327 <sys_write+5b/5d>
> Trace; c010a3eb <syscall_call+7/b>
>
> Code;  c02cbbad <htb_enqueue+ab/126>
> 00000000 <_EIP>:
> Code;  c02cbbad <htb_enqueue+ab/126>   <=====
>    0:   8b 43 04                  mov    0x4(%ebx),%eax   <=====
> Code;  c02cbbb0 <htb_enqueue+ae/126>
>    3:   89 44 24 04               mov    %eax,0x4(%esp,1)
> Code;  c02cbbb4 <htb_enqueue+b2/126>
>    7:   c7 04 24 2b 30 38 c0      movl   $0xc038302b,(%esp,1)
> Code;  c02cbbbb <htb_enqueue+b9/126>
>    e:   e8 e3 6e e5 ff            call   ffe56ef6 <_EIP+0xffe56ef6>
> Code;  c02cbbc0 <htb_enqueue+be/126>
>   13:   31 00                     xor    %eax,(%eax)
>
>  <0>Kernel panic: Fatal exception in interrupt
>
> --
> Daniel J Blueman
>
> NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
> Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService
>
> Jetzt kostenlos anmelden unter http://www.gmx.net
>
> +++ GMX - die erste Adresse für Mail, Message, More! +++
>
>
>

