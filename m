Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSKKF50>; Mon, 11 Nov 2002 00:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSKKF50>; Mon, 11 Nov 2002 00:57:26 -0500
Received: from [66.59.111.190] ([66.59.111.190]:60905 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S265567AbSKKF5Y>; Mon, 11 Nov 2002 00:57:24 -0500
Date: Mon, 11 Nov 2002 01:03:56 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: William Stearns <wstearns@pobox.com>
Subject: 2.4.20-pre11 crash: kernel NULL pointer dereference in proc_pid_stat.
Message-ID: <Pine.LNX.4.44.0211110053390.3517-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
 	I had a server hang on me yesterday (could no longer ping it;  
hosting company had to reboot it).  It's a dual Athlon running 25
User-Mode Linux systems on host kernel 2.4.20-pre11.  The host system runs
very little, but it does run ps every 5 minutes to put up a system summary
page.  System details are at:

http://www.stearns.org/slartibartfast/cpuinfo
http://www.stearns.org/slartibartfast/dma
http://www.stearns.org/slartibartfast/dmesg.2.4.20-pre11
http://www.stearns.org/slartibartfast/fstab
http://www.stearns.org/slartibartfast/interrupts
http://www.stearns.org/slartibartfast/iomem
http://www.stearns.org/slartibartfast/ioports
http://www.stearns.org/slartibartfast/lspci-vvv
http://www.stearns.org/slartibartfast/meminfo
http://www.stearns.org/slartibartfast/

	(30 second summary; Dual AMD Athlon(tm) MP 1900+'s, 2G registered 
ECC ram, 360G raid array on a 3ware raid card (raid 5 across 4 120G ide's, 
dual 3C980-TX onboard nics, noapic, rack mounted.)

	I've deleted a slew of identical reports that follow these; the
code traces are identical in all except for a single one which does
not have the "Trace; c0143876 <dentry_open+a6/190>" line.

	Please let me know if there's more I can provide - thanks so much!
	Cheers,
	- Bill


ksymoops 2.4.4 on i686 2.4.20-pre11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre11/ (default)
     -m /boot/System.map-2.4.20-pre11 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Nov  9 15:45:02 zaphod kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002f
Nov  9 15:45:02 zaphod kernel: c0168b60
Nov  9 15:45:02 zaphod kernel: *pde = 00000000
Nov  9 15:45:02 zaphod kernel: Oops: 0000
Nov  9 15:45:02 zaphod kernel: CPU:    0
Nov  9 15:45:02 zaphod kernel: EIP:    0010:[<c0168b60>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  9 15:45:02 zaphod kernel: EFLAGS: 00010206
Nov  9 15:45:02 zaphod kernel: eax: 00001000   ebx: e1b04674   ecx: 00001000   edx: 00000027
Nov  9 15:45:02 zaphod kernel: esi: cdb62000   edi: cdb62000   ebp: ec6bff50   esp: ec6bff18
Nov  9 15:45:02 zaphod kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 15:45:02 zaphod kernel: Process ps (pid: 11500, stackpage=ec6bf000)
Nov  9 15:45:02 zaphod kernel: Stack: 5236e818 0000880d 000042ca 00000000 00000000 00000000 06f57000 c036e818 
Nov  9 15:45:02 zaphod kernel:        c036e988 000001f0 c0143876 e0957d9c 000001ff cdb62000 ec6bff78 c0166560 
Nov  9 15:45:02 zaphod kernel:        cdb62000 df1f7000 d80c5000 400279a0 df1f7000 00000000 e3c61b44 ffffffea 
Nov  9 15:45:02 zaphod kernel: Call Trace:    [<c0143876>] [<c0166560>] [<c01442b6>] [<c0143b33>] [<c01093bb>]
Nov  9 15:45:02 zaphod kernel: Code: 8b 42 08 2b 42 04 01 45 e0 8b 52 0c 85 d2 75 f0 8b 86 ec 1f 

>>EIP; c0168b60 <proc_pid_stat+100/2c0>   <=====
Trace; c0143876 <dentry_open+a6/190>
Trace; c0166560 <proc_info_read+50/110>
Trace; c01442b6 <sys_read+96/190>
Trace; c0143b33 <sys_open+53/b0>
Trace; c01093bb <system_call+33/38>
Code;  c0168b60 <proc_pid_stat+100/2c0>
00000000 <_EIP>:
Code;  c0168b60 <proc_pid_stat+100/2c0>   <=====
   0:   8b 42 08                  mov    0x8(%edx),%eax   <=====
Code;  c0168b63 <proc_pid_stat+103/2c0>
   3:   2b 42 04                  sub    0x4(%edx),%eax
Code;  c0168b66 <proc_pid_stat+106/2c0>
   6:   01 45 e0                  add    %eax,0xffffffe0(%ebp)
Code;  c0168b69 <proc_pid_stat+109/2c0>
   9:   8b 52 0c                  mov    0xc(%edx),%edx
Code;  c0168b6c <proc_pid_stat+10c/2c0>
   c:   85 d2                     test   %edx,%edx
Code;  c0168b6e <proc_pid_stat+10e/2c0>
   e:   75 f0                     jne    0 <_EIP>
Code;  c0168b70 <proc_pid_stat+110/2c0>
  10:   8b 86 ec 1f 00 00         mov    0x1fec(%esi),%eax

Nov  9 15:45:03 zaphod kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002f
Nov  9 15:45:03 zaphod kernel: c0168b60
Nov  9 15:45:03 zaphod kernel: *pde = 00000000
Nov  9 15:45:03 zaphod kernel: Oops: 0000
Nov  9 15:45:03 zaphod kernel: CPU:    0
Nov  9 15:45:03 zaphod kernel: EIP:    0010:[<c0168b60>]    Not tainted
Nov  9 15:45:03 zaphod kernel: EFLAGS: 00010206
Nov  9 15:45:03 zaphod kernel: eax: 00001000   ebx: e1b04674   ecx: 00001000   edx: 00000027
Nov  9 15:45:03 zaphod kernel: esi: cdb62000   edi: cdb62000   ebp: cb03bf50   esp: cb03bf18
Nov  9 15:45:03 zaphod kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 15:45:03 zaphod kernel: Process ps (pid: 11507, stackpage=cb03b000)
Nov  9 15:45:03 zaphod kernel: Stack: 5236e818 0000880d 000042ca 00000000 00000000 00000000 06f57000 c036e818 
Nov  9 15:45:03 zaphod kernel:        c036e988 000001f0 c0143876 e0957d9c 000001ff cdb62000 cb03bf78 c0166560 
Nov  9 15:45:03 zaphod kernel:        cdb62000 e1447000 d80c5000 400279a0 e1447000 00000000 f2ccf984 ffffffea 
Nov  9 15:45:03 zaphod kernel: Call Trace:    [<c0143876>] [<c0166560>] [<c01442b6>] [<c0143b33>] [<c01093bb>]
Nov  9 15:45:03 zaphod kernel: Code: 8b 42 08 2b 42 04 01 45 e0 8b 52 0c 85 d2 75 f0 8b 86 ec 1f 

>>EIP; c0168b60 <proc_pid_stat+100/2c0>   <=====
Trace; c0143876 <dentry_open+a6/190>
Trace; c0166560 <proc_info_read+50/110>
Trace; c01442b6 <sys_read+96/190>
Trace; c0143b33 <sys_open+53/b0>
Trace; c01093bb <system_call+33/38>
Code;  c0168b60 <proc_pid_stat+100/2c0>
00000000 <_EIP>:
Code;  c0168b60 <proc_pid_stat+100/2c0>   <=====
   0:   8b 42 08                  mov    0x8(%edx),%eax   <=====
Code;  c0168b63 <proc_pid_stat+103/2c0>
   3:   2b 42 04                  sub    0x4(%edx),%eax
Code;  c0168b66 <proc_pid_stat+106/2c0>
   6:   01 45 e0                  add    %eax,0xffffffe0(%ebp)
Code;  c0168b69 <proc_pid_stat+109/2c0>
   9:   8b 52 0c                  mov    0xc(%edx),%edx
Code;  c0168b6c <proc_pid_stat+10c/2c0>
   c:   85 d2                     test   %edx,%edx
Code;  c0168b6e <proc_pid_stat+10e/2c0>
   e:   75 f0                     jne    0 <_EIP>
Code;  c0168b70 <proc_pid_stat+110/2c0>
  10:   8b 86 ec 1f 00 00         mov    0x1fec(%esi),%eax

---------------------------------------------------------------------------
Boucher's Observation:
        He who blows his own horn always plays the music several octaves
higher than originally written.
(Courtesy of "Brett W. McCoy" <bmccoy@chapelperilous.net>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                        http://www.stearns.org
--------------------------------------------------------------------------



