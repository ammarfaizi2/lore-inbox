Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266534AbRGLUCN>; Thu, 12 Jul 2001 16:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266539AbRGLUCD>; Thu, 12 Jul 2001 16:02:03 -0400
Received: from ohiper1-83.apex.net ([209.250.47.98]:2822 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S266534AbRGLUBz>; Thu, 12 Jul 2001 16:01:55 -0400
Date: Thu, 12 Jul 2001 14:58:11 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Ned Bass <ned@linuxcare.com>
Cc: linux-kernel@vger.kernel.org, egger@suse.de
Subject: Re: Oops triggered by ftp connection attempt through Linux firewall
Message-ID: <20010712145811.A8082@hapablap.dyn.dhs.org>
In-Reply-To: <20010712101219.D5476@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010712101219.D5476@linuxcare.com>; from ned@linuxcare.com on Thu, Jul 12, 2001 at 10:12:19AM -0700
X-Uptime: 2:41pm  up  4:36,  1 user,  load average: 1.34, 1.19, 1.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 10:12:19AM -0700, Ned Bass wrote:
> A kernel Oops error occurs on a Linux 2.4.6 system that provides IP
> masquerading for a local area network. The crash is triggered when a
> connection is attempted to port 21 on ftp.freesoftware.com from any
> host on the local network which uses the Linux system as its default
> gateway.  Attempting to connect to port 21 on the Linux system itself
> results in a no route to host error message.  The severity of the crash
> prevents interactive access to the system, and a hard reboot is required.
> The error has been 100% reproducible using the scenario described above.
> After the Oops, the filesystems can be synced using Alt-Printscreen-S,
> however attempting to remount readonly using Alt-Printscreen-U caused
> additional kernel panics.

I have been seeing the same, or a very similar bug, on another NAT
machine.  This one is of almost the same setup, using Netfilter, FTP,
and PPPoE.  The oops resulting from this bug it attached.

Interesting, my system is also using the in-kernel pppoe driver.
Perhaps there is a bug and/or interaction in the pppoe driver with
netfilter?

> ksymoops 2.4.1 on i586 2.4.6.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.6/ (default)
>      -m /boot/System.map-2.4.6 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> ksymoops: No such file or directory
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Unable to handle kernel paging request at virtual address 000078e5
> c02393c2
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c02392c2>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: c7c738e0   ebx: 000078e5     ecx: 00000000       edx: 000078e5
> esi: c7dfe4e0   edi: c7c73680     ebp: 00000000       esp: c030bdd8
> ds: 0018        es: 0018       ss: 0018
> Process swapper (pid: 0, stackpage=c030b000)
> Stack: fffffe00 c023936b c7dfe4e0 fffffe00 c7dfe4e0 c0239923 c7dfe4e0 c7dfe4e0
>         c12dd800 c62ef120 c12dd800 ffffffe6 c023c807 c7dfe4e0 00000020 c4d4a320
>         c7dfe4e0 c62ef120 c023fb0f c7dfe4e0 c7dfe4e0 00000000 00000004 c02487ac
> Call Trace: [<c023936b>] [<c0239923>] [<c023c807>] [<c023fb0f>] <c02487ac>] [<c024883d>] [<c0240a96>]
>         [<c0245e9c>] [<c0248792>] [<c02487ac>] [<c0245eea>] [<c0240a96>] [<c02405dc>] [<c0245e44>] [<c0245e9c>]
>         [<c0245118>] [<c0245299>] [<c0245118>] [<c0240a96>] [<c0244f76>] [<c0245118>] [<c023ce2d>] [<c0113e3f>]
>         [<c0107e6d>] [<c0105130>] [<c0106b70>] [<c0105130>] [<c0105153>] [<c01051b7>] [<c0105000>]
> Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09
> 
> >>EIP; c02392c2 <skb_drop_fraglist+1a/40>   <=====
> Trace; c023936b <skb_release_data+5f/74>
> Trace; c0239923 <skb_linearize+cf/130>
> Trace; c023c807 <dev_queue_xmit+27/244>
> Trace; c023fb0f <neigh_resolve_output+137/1a8>
> Trace; c02487ac <ip_finish_output2+0/c8>
> Trace; c024883d <ip_finish_output2+91/c8>
> Trace; c0240a96 <nf_hook_slow+ee/144>
> Trace; c0245e9c <ip_forward_finish+0/54>
> Trace; c0248792 <ip_finish_output+f2/f8>
> Trace; c02487ac <ip_finish_output2+0/c8>
> Trace; c0245eea <ip_forward_finish+4e/54>
> Trace; c0240a96 <nf_hook_slow+ee/144>
> Trace; c02405dc <nf_unregister_sockopt+1c/60>
> Trace; c0245e44 <ip_forward+1a4/1fc>
> Trace; c0245e9c <ip_forward_finish+0/54>
> Trace; c0245118 <ip_rcv_finish+0/1b8>
> Trace; c0245299 <ip_rcv_finish+181/1b8>
> Trace; c0245118 <ip_rcv_finish+0/1b8>
> Trace; c0240a96 <nf_hook_slow+ee/144>
> Trace; c0244f76 <ip_rcv+336/36c>
> Trace; c0245118 <ip_rcv_finish+0/1b8>
> Trace; c023ce2d <net_rx_action+135/210>
> Trace; c0113e3f <do_softirq+3f/68>
> Trace; c0107e6d <do_IRQ+9d/b0>
> Trace; c0105130 <default_idle+0/28>
> Trace; c0106b70 <ret_from_intr+0/7>
> Trace; c0105130 <default_idle+0/28>
> Trace; c0105153 <default_idle+23/28>
> Trace; c01051b7 <cpu_idle+3f/54>
> Trace; c0105000 <_stext+0/0>
> Code;  c02392c2 <skb_drop_fraglist+1a/40>
> 00000000 <_EIP>:
> Code;  c02392c2 <skb_drop_fraglist+1a/40>   <=====
>    0:   8b 1b                     mov    (%ebx),%ebx   <=====
> Code;  c02392c4 <skb_drop_fraglist+1c/40>
>    2:   8b 42 70                  mov    0x70(%edx),%eax
> Code;  c02392c7 <skb_drop_fraglist+1f/40>
>    5:   83 f8 01                  cmp    $0x1,%eax
> Code;  c02392ca <skb_drop_fraglist+22/40>
>    8:   74 0a                     je     14 <_EIP+0x14> c02392d6 <skb_drop_fraglist+2e/40>
> Code;  c02392cc <skb_drop_fraglist+24/40>
>    a:   ff 4a 70                  decl   0x70(%edx)
> Code;  c02392cf <skb_drop_fraglist+27/40>
>    d:   0f 94 c0                  sete   %al
> Code;  c02392d2 <skb_drop_fraglist+2a/40>
>   10:   84 c0                     test   %al,%al
> Code;  c02392d4 <skb_drop_fraglist+2c/40>
>   12:   74 09                     je     1d <_EIP+0x1d> c02392df <skb_drop_fraglist+37/40>
> 
> Kernel panic: Aiee, killing interrup handler!
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
