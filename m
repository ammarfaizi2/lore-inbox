Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292303AbSBTUhE>; Wed, 20 Feb 2002 15:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292292AbSBTUgv>; Wed, 20 Feb 2002 15:36:51 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:39505 "EHLO
	tsmtp5.mail.isp") by vger.kernel.org with ESMTP id <S292293AbSBTUgM>;
	Wed, 20 Feb 2002 15:36:12 -0500
Date: Wed, 20 Feb 2002 21:38:15 +0100
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: Re: hang in 2.4.18-rc2-ac1
Message-Id: <20020220213815.5b49e9f8.diegocg@teleline.es>
In-Reply-To: <20020220211318.14f953dd.diegocg@teleline.es>
In-Reply-To: <20020220192127.622006ff.diegocg@teleline.es>
	<20020220182603.GA20060@matchmail.com>
	<20020220211318.14f953dd.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

En Wed, 20 Feb 2002 10:26:03 -0800
Mike Fedyk <mfedyk@matchmail.com> escribio...:

> On Wed, Feb 20, 2002 at 07:21:27PM +0100, Diego Calleja wrote:
> > This happened while using X & kde & wine. Kernel 2.4.18-rc2-ac1
> > 
> > Feb 20 18:10:15 localhost kernel: Unable to handle kernel paging request at virtual address 000a2e64
> > Feb 20 18:10:15 localhost kernel:  printing eip:
> > Feb 20 18:10:15 localhost kernel: c017a769
> > Feb 20 18:10:15 localhost kernel: *pde = 00000000
> 
> run it through cut -c (to get log info out) then ksymoops and post again.
I'm VERY sorry. I use 'console-log' package, which shows things like that:
Feb 20 18:10:15 localhost kernel: Call Trace: [tty_poll+135/148] [do_select+226/476] [sys_select+820/1156] [system_call+51/64]
I thought I didn't have to pass through ksymoops.
Here is the log through ksymoops:

ksymoops 2.4.3 on i686 2.4.18-rc2-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-rc2-ac1/ (default)
     -m /boot/System.map-2.4.18-rc2-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Feb 20 18:10:15 localhost kernel: Unable to handle kernel paging request at virtual address 000a2e64
Feb 20 18:10:15 localhost kernel: c017a769
Feb 20 18:10:15 localhost kernel: *pde = 00000000
Feb 20 18:10:15 localhost kernel: Oops: 0000
Feb 20 18:10:15 localhost kernel: CPU:    0
Feb 20 18:10:15 localhost kernel: EIP:    0010:[normal_poll+1/270]    Tainted: P
Feb 20 18:10:15 localhost kernel: EFLAGS: 00010282
Feb 20 18:10:15 localhost kernel: eax: 00000000   ebx: c0e28000   ecx: c089df58   edx: c017a768
Feb 20 18:10:15 localhost kernel: esi: c1395b60   edi: c0d38019   ebp: 00000003   esp: c089defc
Feb 20 18:10:15 localhost kernel: ds: 0018   es: 0018   ss: 0018
Feb 20 18:10:15 localhost kernel: Process wineserver (pid: 727, stackpage=c089d000)
Feb 20 18:10:15 localhost kernel: Stack: c01773e3 c0e28000 c1395b60 00000000 c1395b60 00000145 c013bc15 c1395b60
Feb 20 18:10:15 localhost kernel:        00000000 00000000 00000000 0806b348 7fffffff c013bcd9 00000013 c0d38000
Feb 20 18:10:15 localhost kernel:        c089df58 c089df5c 00000013 00000000 0806b348 c089dfbc c089c000 00000000
Feb 20 18:10:15 localhost kernel: Call Trace: [tty_poll+135/148] [do_pollfd+73/136] [do_poll+133/220] [sys_poll+477/736] 
Feb 20 18:10:15 localhost kernel: Code: 20 25 64 2e 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   20 25 64 2e 0a 00         and    %ah,0xa2e64

Feb 20 18:10:15 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb 20 18:10:15 localhost kernel: c017a768
Feb 20 18:10:15 localhost kernel: *pde = 01f8e067
Feb 20 18:10:15 localhost kernel: Oops: 0002
Feb 20 18:10:15 localhost kernel: CPU:    0
Feb 20 18:10:15 localhost kernel: EIP:    0010:[normal_poll+0/270]    Tainted: P
Feb 20 18:10:15 localhost kernel: EFLAGS: 00010282
Feb 20 18:10:15 localhost kernel: eax: 00000000   ebx: c1e18000   ecx: 00000003   edx: c017a768
Feb 20 18:10:15 localhost kernel: esi: c085e840   edi: 00000000   ebp: c06a1f70   esp: c06a1f20
Feb 20 18:10:15 localhost kernel: ds: 0018   es: 0018   ss: 0018
Feb 20 18:10:15 localhost kernel: Process XFree86 (pid: 554, stackpage=c06a1000)
Feb 20 18:10:15 localhost kernel: Stack: c01773e3 c1e18000 c085e840 00000000 00000000 c085e840 c013b626 c085e840
Feb 20 18:10:15 localhost kernel:        00000000 00000100 00000020 c10d9e20 00000145 00000008 c06a0000 7fffffff
Feb 20 18:10:15 localhost kernel:        00000003 00000000 00000000 c131b000 00000000 c013ba7c 00000016 c06a1fa8
Feb 20 18:10:15 localhost kernel: Call Trace: [tty_poll+135/148] [do_select+226/476] [sys_select+820/1156] [system_call+51/64]
Feb 20 18:10:15 localhost kernel: Code: 6c 20 25 64 2e 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   6c                        insb   (%dx),%es:(%edi)
Code;  00000000 Before first symbol
   1:   20 25 64 2e 0a 00         and    %ah,0xa2e64


1 warning issued.  Results may not be reliable.

> 
> Mike

