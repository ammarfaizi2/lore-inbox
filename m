Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286342AbRLJRy1>; Mon, 10 Dec 2001 12:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286341AbRLJRyI>; Mon, 10 Dec 2001 12:54:08 -0500
Received: from borderworlds.dk ([193.162.142.101]:21764 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S286333AbRLJRxz>; Mon, 10 Dec 2001 12:53:55 -0500
To: linux-kernel@vger.kernel.org
Subject: NULL pointer dereference in moxa driver
From: Christian Laursen <xi@borderworlds.dk>
Date: 10 Dec 2001 18:53:48 +0100
Message-ID: <m3zo4rm05v.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem when trying to use two of the serial cards known as
MOXA C104H/PCI.

When only using one, everything works like a charm, but when
an attempt is made to access a serial port on the second card,
I get a NULL pointer dereference.


This is the relevant output from dmesg:

MOXA Smartio family driver version 1.2
Tty devices major number = 174, callout devices major number = 175
Found MOXA C104H/PCI series board(BusNo=0,DevNo=10)


The relevant stuff from /proc/pci:

  Bus  0, device  10, function  0:
    Serial controller: Moxa Technologies Co Ltd Smartio C104H/PCI (rev 2).
      IRQ 10.
      I/O at 0xa800 [0xa87f].
      I/O at 0xa400 [0xa43f].
      I/O at 0xa000 [0xa00f].
  Bus  0, device  11, function  0:
    Serial controller: Moxa Technologies Co Ltd Smartio C104H/PCI (#2) (rev 2).
      IRQ 11.
      I/O at 0x9800 [0x987f].
      I/O at 0x9400 [0x943f].
      I/O at 0x9000 [0x900f].


And here is the decoded oops:

ksymoops 2.4.1 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Nov 24 16:49:35 cola kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000024
Nov 24 16:49:35 cola kernel: c01946e3
Nov 24 16:49:35 cola kernel: *pde = 00000000
Nov 24 16:49:35 cola kernel: Oops: 0000
Nov 24 16:49:35 cola kernel: CPU:    1
Nov 24 16:49:35 cola kernel: EIP:    0010:[mxser_change_speed+15/1760]    Not tainted
Nov 24 16:49:35 cola kernel: EFLAGS: 00010282
Nov 24 16:49:35 cola kernel: eax: 00000000   ebx: d48bfee8   ecx: 00000000   edx: 00000001
Nov 24 16:49:35 cola kernel: esi: 00000000   edi: d4caabf0   ebp: d4caa000   esp: d48bfea0
Nov 24 16:49:35 cola kernel: ds: 0018   es: 0018   ss: 0018
Nov 24 16:49:35 cola kernel: Process minicom (pid: 678, stackpage=d48bf000)
Nov 24 16:49:35 cola kernel: Stack: d4caa000 d48bfee8 d4caabf0 d4caa000 00000000 c02e5280 c0193f8b 00000000 
Nov 24 16:49:35 cola kernel:        d48bfee8 d48bfee8 00000002 c0180b30 d4caa000 d48bfee8 bffff3f8 bffff41c 
Nov 24 16:49:35 cola kernel:        d48bff54 d48bff30 00000500 00000005 00000cbd 00008a3b 7f1c0300 01000415 
Nov 24 16:49:35 cola kernel: Call Trace: [mxser_set_termios+51/128] [change_termios+368/396] [set_termios+383/396] [n_tty_ioctl+185/1024] [tty_ioctl+891/912] 
Nov 24 16:49:35 cola kernel: Code: 8b 46 24 85 c0 74 17 8b 80 00 01 00 00 85 c0 74 0d 8b 40 08 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 46 24                  mov    0x24(%esi),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 17                     je     1e <_EIP+0x1e> 0000001e Before first symbol
Code;  00000007 Before first symbol
   7:   8b 80 00 01 00 00         mov    0x100(%eax),%eax
Code;  0000000d Before first symbol
   d:   85 c0                     test   %eax,%eax
Code;  0000000f Before first symbol
   f:   74 0d                     je     1e <_EIP+0x1e> 0000001e Before first symbol
Code;  00000011 Before first symbol
  11:   8b 40 08                  mov    0x8(%eax),%eax


The machine is an SMP box, but I don't think, that's the cause, as the oops happens
immediately every time.

If there is any other info I need to provide, I'll be happy to do so.

Thanks in advance.

-- 
Best regards
    Christian Laursen
