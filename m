Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRADKit>; Thu, 4 Jan 2001 05:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbRADKil>; Thu, 4 Jan 2001 05:38:41 -0500
Received: from h0060979b0848.ne.mediaone.net ([66.30.66.43]:1920 "HELO
	moodswing.numb.org") by vger.kernel.org with SMTP
	id <S129406AbRADKiO>; Thu, 4 Jan 2001 05:38:14 -0500
Date: Thu, 4 Jan 2001 05:38:12 -0500
From: Ryan McCabe <odin@numb.org>
To: johannes@erdfelt.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: USB related oops
Message-ID: <20010104053812.A391@numb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following oops about 70% of the time I boot my machine.

ksymoops 2.3.5 on i686 2.4.0-prerelease.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.0-prerelease/ (specified)
     -m /usr/src/linux/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000040
c0114554
*pde = 00000000
Oops: 0000
CPU     1
EIP:    0010:[<c0114554>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010003
eax: cdc5c004   ebx: cdc5c000   ecx: 00000040   edx: 00000000
esi: 00000038   edi: 00000000   ebp: c15ffed0   esp: c15ffea0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c15ff000)
Stack: cdc5c000 cfaff740 00000000 00000040 cdc5c004 00000202 00000000 00000001
       00000001 00000001 00000003 cdc5c000 cffe9de0 d12e9d0b 00000000 d12f495f
       cfaff740 cffe9dfc cffe9de0 00000000 00000000 00000000 00000000 cfedec00
Call Trace: [<d12e9d0b>] [<d12f495f>] [<d12f4a51>] [<ef82000f>] [<c01a0001>] [<c010a681>] [<c010a866>]
       [<c0107170>] [<c0107170>] [<c0108ff4>] [<c0107170>] [<c0107170>] [<c0100018>] [<c010719c>] [<c0107202>]
       [<c01d8097>] [<c01939de>]
Code: 8b 09 89 4d dc 8b 5e 04 8b 03 85 45 f8 74 e0 83 7d ec 00 0f

>>EIP; c0114554 <__wake_up+d8/18c>   <=====
Trace; d12e9d0b <[usbcore]usb_api_blocking_completion+23/28>
Trace; d12f495f <[usb-uhci]process_urb+1d3/220>
Trace; d12f4a51 <[usb-uhci]uhci_interrupt+a5/108>
Trace; ef82000f <END_OF_CODE+1e4dd028/????>
Trace; c01a0001 <ide_set_handler+65/78>
Trace; c010a681 <handle_IRQ_event+4d/78>
Trace; c010a866 <do_IRQ+a6/f4>
Trace; c0107170 <default_idle+0/34>
Trace; c0107170 <default_idle+0/34>
Trace; c0108ff4 <ret_from_intr+0/20>
Trace; c0107170 <default_idle+0/34>
Trace; c0107170 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cb>
Trace; c010719c <default_idle+2c/34>
Trace; c0107202 <cpu_idle+3e/54>
Trace; c01d8097 <vgacon_cursor+1af/1b8>
Trace; c01939de <set_cursor+6e/80>
Code;  c0114554 <__wake_up+d8/18c>
00000000 <_EIP>:
Code;  c0114554 <__wake_up+d8/18c>   <=====
   0:   8b 09                     mov    (%ecx),%ecx   <=====
Code;  c0114556 <__wake_up+da/18c>
   2:   89 4d dc                  mov    %ecx,0xffffffdc(%ebp)
Code;  c0114559 <__wake_up+dd/18c>
   5:   8b 5e 04                  mov    0x4(%esi),%ebx
Code;  c011455c <__wake_up+e0/18c>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c011455e <__wake_up+e2/18c>
   a:   85 45 f8                  test   %eax,0xfffffff8(%ebp)
Code;  c0114561 <__wake_up+e5/18c>
   d:   74 e0                     je     ffffffef <_EIP+0xffffffef> c0114543 <__wake_up+c7/18c>
Code;  c0114563 <__wake_up+e7/18c>
   f:   83 7d ec 00               cmpl   $0x0,0xffffffec(%ebp)
Code;  c0114567 <__wake_up+eb/18c>
  13:   0f 00 00                  sldt   (%eax)

Kernel panic: Aiee, killing interrupt handler!


The machine is a dual pII with a USB keyboard and mouse.  There is no
ps/2 keyboard connected.  The machine boots fine when the USB keyboard is
disconnected.

Linux version 2.4.0-prerelease (root@moodswing.numb.org) (gcc version
2.95.3 20010101 (prerelease)) #1 SMP Thu Jan 4 04:34:33 EST 2001

The oops happens with kernels 2.4.0-test10, 2.4.0-test12 and
2.4.0-prerelease (with all 4 prerelease-diffs).  I haven't tried
anything older than 2.4.0-test10.

The following kernel messages are printed before the oops:

hub.c: USB new device connect on bus1/1, assigned device number 2
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] AGP 0.99 on Intel 440BX @ 0xf8000000 64MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
mouse0: PS/2 mouse device for input0
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:2.0
hub.c: USB new device connect on bus1/2, assigned device number 3

I can supply the .config, if needed.


Ryan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
