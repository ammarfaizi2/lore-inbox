Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbTB0VAZ>; Thu, 27 Feb 2003 16:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTB0VAZ>; Thu, 27 Feb 2003 16:00:25 -0500
Received: from mail.ithnet.com ([217.64.64.8]:45830 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267008AbTB0VAX>;
	Thu, 27 Feb 2003 16:00:23 -0500
Date: Thu, 27 Feb 2003 22:10:17 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: OOPS in 2.4.21-pre5, ide-scsi
Message-Id: <20030227221017.4291c1f6.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I just installed pre5 and did my current favourite test: mounting a cdrom with ide-scsi. Maybe you remember my problem: I enter the mount, cdrom spins up, around 20-30 seconds, then freeze.

But this time it oops'ed, and here it is:
(I had to write it down by hand, and "filled" it in another oops "form", so just forget the date/time. All the values should be correct, I checked twice.)

# ksymoops < oops 
ksymoops 2.4.5 on i686 2.4.21-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre5/ (default)
     -m /boot/System.map-2.4.21-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Nov  5 19:48:49 linux kernel: Oops: 0002
Nov  5 19:48:49 linux kernel: CPU:    0
Nov  5 19:48:49 linux kernel: EIP:    0010:[<c0213ab3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  5 19:48:49 linux kernel: EFLAGS: 00010202
Nov  5 19:48:49 linux kernel: eax: 00000000   ebx: 00000001   ecx: c1613d84   edx: 3e076fe3
Nov  5 19:48:49 linux kernel: esi: d93ca000   edi: c0363d80   ebp: c165cd80   esp: d98d3f2c
Nov  5 19:48:49 linux kernel: ds: 0018   es: 0018   ss: 0018
Nov  5 19:48:49 linux kernel: Process setiathome (pid: 1371, stackpage=d98d3000)
Nov  5 19:48:49 linux kernel: Stack: 00000177 51eb851f d98d2000 00100000 c01299e5 bffffa60 d98d3f50 3e076fe3
Nov  5 19:48:49 linux kernel:        c1613d60 c0363d80 00000286 c0363cd0 c01dcbd6 c0363d80 00000000 c0213a50
Nov  5 19:48:49 linux kernel:        c1634c80 04000001 00000000 d98d3fc4 c0109129 0000000f c1613d60 d98d3fc4
Nov  5 19:48:49 linux kernel: Call Trace:    [<c01299e5>] [<c01dcbd6>] [<c0213a50>] [<c0109129>] [<c0109348>] [<c010bec8>]
Nov  5 19:48:49 linux kernel: Code: ff 42 18 89 3c 24 c7 44 24 04 01 00 00 00 e8 ae fc ff ff 31


>>EIP; c0213ab3 <idescsi_pc_intr+63/360>   <=====

>>ecx; c1613d84 <_end+12a072c/20557a08>
>>edx; 3e076fe3 Before first symbol
>>esi; d93ca000 <_end+190569a8/20557a08>
>>edi; c0363d80 <ide_hwifs+520/2c60>
>>ebp; c165cd80 <_end+12e9728/20557a08>
>>esp; d98d3f2c <_end+195608d4/20557a08>

Trace; c01299e5 <getrusage+d5/230>
Trace; c01dcbd6 <ide_intr+e6/180>
Trace; c0213a50 <idescsi_pc_intr+0/360>
Trace; c0109129 <handle_IRQ_event+69/a0>
Trace; c0109348 <do_IRQ+98/f0>
Trace; c010bec8 <call_do_IRQ+5/d>

Code;  c0213ab3 <idescsi_pc_intr+63/360>
00000000 <_EIP>:
Code;  c0213ab3 <idescsi_pc_intr+63/360>   <=====
   0:   ff 42 18                  incl   0x18(%edx)   <=====
Code;  c0213ab6 <idescsi_pc_intr+66/360>
   3:   89 3c 24                  mov    %edi,(%esp,1)
Code;  c0213ab9 <idescsi_pc_intr+69/360>
   6:   c7 44 24 04 01 00 00      movl   $0x1,0x4(%esp,1)
Code;  c0213ac0 <idescsi_pc_intr+70/360>
   d:   00 
Code;  c0213ac1 <idescsi_pc_intr+71/360>
   e:   e8 ae fc ff ff            call   fffffcc1 <_EIP+0xfffffcc1> c0213774 <idescsi_do_end_request+a4/e0>
Code;  c0213ac6 <idescsi_pc_intr+76/360>
  13:   31 00                     xor    %eax,(%eax)

Nov  5 19:48:49 linux kernel:  <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


Hope this helps

Regards,
Stephan
