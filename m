Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278099AbRJWROw>; Tue, 23 Oct 2001 13:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278101AbRJWROm>; Tue, 23 Oct 2001 13:14:42 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:30528 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S278099AbRJWROd>; Tue, 23 Oct 2001 13:14:33 -0400
Date: Tue, 23 Oct 2001 19:14:58 +0200
From: Cliff Albert <cliff@oisec.net>
To: linux-kernel@vger.kernel.org
Cc: coldsync-bugs@ooblick.com
Subject: [OOPS] USB, Palm M500, Coldsync
Message-ID: <20011023191458.A4261@oisec.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	coldsync-bugs@ooblick.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Coldsync segfaults after a successful hotsync with my Palm M500 which is connected using the USB Cradle. It also generates a oops. I hope the following info is enough to fix this problem.

Distribution: Debian(sid) w/ Coldsync (coldsync-2.2.2-20011012.tar.gz)

]------------------------[uname -ar]-----------------------------------------[
Linux version 2.4.12-ac5 (root@joanne) (gcc version 2.95.4 20011006 (Debian prer
elease)) #8 Mon Oct 22 09:27:00 CEST 2001

]------------------------[OOPS]----------------------------------------------[
ksymoops 2.4.3 on i586 2.4.12-ac5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-ac5/ (default)
     -m /boot/System.map-2.4.12-ac5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.12-ac5 failed
c01f0ae0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01f0ae0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286
eax: 0000001f   ebx: c9c70894   ecx: c6de7000   edx: ffffffff
esi: c6de7380   edi: c9c70800   ebp: c9c708f0   esp: c3b3ded0
ds: 0018   es: 0018   ss: 0018
Process coldsync (pid: 3533, stackpage=c3b3d000)
Stack: c01fc376 ffffffff c9c70894 c9c70800 c6f87c60 00000000 c01fa900 c9c70894 
       c6f87c60 c2564000 c23a4ac0 c13162a0 c0191e60 c2564000 c6f87c60 c6f87c60 
       c23a4ac0 c13162a0 c6f19aa0 00000001 c3b3c000 0a19576e 00000000 00200286 
Call Trace: [<c01fc376>] [<c01fa900>] [<c0191e60>] [<c01957f0>] [<c0192481>] 
   [<c012f0a0>] [<c012e23b>] [<c012e287>] [<c0106b23>] 
Code: 8b 42 14 85 c0 74 19 8b 80 bc 00 00 00 8b 40 18 52 8b 40 10 

>>EIP; c01f0ae0 <usb_unlink_urb+8/270>   <=====
Trace; c01fc376 <usb_serial_deregister+2b2/efc>
Trace; c01fa900 <usb_reset_device+6aa0/822c>
Trace; c0191e60 <tty_hung_up_p+bc0/1ca8>
Trace; c01957f0 <tty_unregister_driver+2464/2594>
Trace; c0192480 <tty_hung_up_p+11e0/1ca8>
Trace; c012f0a0 <fput+38/c0>
Trace; c012e23a <filp_close+5a/64>
Trace; c012e286 <sys_close+42/84>
Trace; c0106b22 <__up_wakeup+105e/2644>
Code;  c01f0ae0 <usb_unlink_urb+8/270>
00000000 <_EIP>:
Code;  c01f0ae0 <usb_unlink_urb+8/270>   <=====
   0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
Code;  c01f0ae2 <usb_unlink_urb+a/270>
   3:   85 c0                     test   %eax,%eax
Code;  c01f0ae4 <usb_unlink_urb+c/270>
   5:   74 19                     je     20 <_EIP+0x20> c01f0b00 <usb_unlink_urb+28/270>
Code;  c01f0ae6 <usb_unlink_urb+e/270>
   7:   8b 80 bc 00 00 00         mov    0xbc(%eax),%eax
Code;  c01f0aec <usb_unlink_urb+14/270>
   d:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c01f0af0 <usb_unlink_urb+18/270>
  10:   52                        push   %edx
Code;  c01f0af0 <usb_unlink_urb+18/270>
  11:   8b 40 10                  mov    0x10(%eax),%eax


1 warning and 1 error issued.  Results may not be reliable.

]--------------------------[ColdSync Version]-----------------------[

coldsync version 2.2.2.
ColdSync homepage at http://www.ooblick.com/software/coldsync/
Compile-type options:
    HAVE_STRCASECMP, HAVE_STRNCASECMP: strings are compared without regard
    to case, whenever possible.
Default global configuration file: /usr/local/etc/coldsync.conf


]--------------------------[USB dmesg]------------------------------[
usb-uhci.c: $Revision: 1.268 $ time 09:31:06 Oct 22 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 10 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x3000, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver serial
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for Handspring Visor
usbserial.c: USB Serial support registered for Palm M500
usbserial.c: USB Serial support registered for Palm M505
usbserial.c: USB Serial support registered for Sony Clie 3.5
usbserial.c: USB Serial support registered for Sony Clie 4.0
visor.c: USB HandSpring Visor, Palm m50x, Sony Clie driver v1.4

]--------------------------[/proc/pci]------------------------------[
  Bus  0, device   7, function  2:
      USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 10.
      Master Capable.  Latency=128.  
      I/O at 0x3000 [0x301f].
			
-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
