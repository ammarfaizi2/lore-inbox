Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSJUJ4f>; Mon, 21 Oct 2002 05:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbSJUJ4f>; Mon, 21 Oct 2002 05:56:35 -0400
Received: from mail.wolnet.de ([213.178.16.8]:8445 "HELO wolnet.de")
	by vger.kernel.org with SMTP id <S261296AbSJUJ4d>;
	Mon, 21 Oct 2002 05:56:33 -0400
From: Peter <pk@q-leap.com>
To: linux-kernel@vger.kernel.org
Subject: oops still occurs with usb-serial converter
Reply-to: pk@q-leap.com
Message-Id: <S.0001127744@wolnet.de>
Date: Mon, 21 Oct 2002 12:02:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The attached kernel oops still occurs (was reported with kernel 2.4.19
on July, 29th):

Hardware:
  Dell Inspiron 2600 Laptop
  USB-Serial Converter: UC-232A

Software:
  minicom (V1.82.1)
  kernel: 2.4.20-pre11

modules loaded:
pl2303                 10104   1
usbserial              17468   0 [pl2303]
uhci                   23600   0 (unused)
usbcore                54144   0 [pl2303 usbserial uhci]

the oops only happens on exit of minicom along with a segmentation
fault.

ksymoops reports:

----------------------------------8<----------------------------------------

ksymoops 2.4.3 on i686 2.4.20-pre11-ql1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre11-ql1/ (default)
     -m /boot/System.map-2.4.20-pre11-ql1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000014
c8ba6279
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c8ba6279>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: c7266600   ebx: ffffff8d   ecx: c7e64800   edx: 00000000
esi: c4e42320   edi: 00000000   ebp: 00000246   esp: c4377e64
ds: 0018   es: 0018   ss: 0018
Process minicom (pid: 2056, stackpage=c4377000)
Stack: ffffff8d c4e42320 00000000 00000282 c8ba79d8 c4e42320 c4e42328 c4e42320 
       00000286 c7c80b60 00000001 00000000 c4393200 c415e1d4 c8ba6ef0 c4e42320 
       c7e64800 ffffffff c7e6481c c7e64800 c415e1d4 c8b9614e c4e42320 c8bb1f09 
Call Trace:    [<c8ba79d8>] [<c8ba6ef0>] [<c8b9614e>] [<c8bb1f09>] [<c8bab4b4>]
  [<c8bab574>] [<c01a2d60>] [<c0183736>] [<c01836b0>] [<c01427e6>] [<c0143d0f>]
  [<c0142258>] [<c01a338e>] [<c0132124>] [<c0131175>] [<c01311c3>] [<c010869f>]
Code: 8b 52 14 8b 42 e8 8b 7a ec 25 00 00 00 2f 0d 00 00 80 01 89 

>>EIP; c8ba6278 <[uhci]uhci_reset_interrupt+24/a0>   <=====
Trace; c8ba79d8 <[uhci]uhci_call_completion+170/1b0>
Trace; c8ba6ef0 <[uhci]uhci_unlink_urb+158/164>
Trace; c8b9614e <[usbcore]usb_unlink_urb+26/30>
Trace; c8bb1f08 <[pl2303]pl2303_close+13c/16c>
Trace; c8bab4b4 <[usbserial]__serial_close+4c/7c>
Trace; c8bab574 <[usbserial]serial_close+90/a4>
Trace; c01a2d60 <release_dev+248/504>
Trace; c0183736 <reiserfs_delete_inode+86/98>
Trace; c01836b0 <reiserfs_delete_inode+0/98>
Trace; c01427e6 <destroy_inode+26/2c>
Trace; c0143d0e <iput+1ee/1f8>
Trace; c0142258 <d_delete+4c/7c>
Trace; c01a338e <tty_release+a/10>
Trace; c0132124 <fput+4c/e0>
Trace; c0131174 <filp_close+54/60>
Trace; c01311c2 <sys_close+42/54>
Trace; c010869e <system_call+32/38>
Code;  c8ba6278 <[uhci]uhci_reset_interrupt+24/a0>
00000000 <_EIP>:
Code;  c8ba6278 <[uhci]uhci_reset_interrupt+24/a0>   <=====
   0:   8b 52 14                  mov    0x14(%edx),%edx   <=====
Code;  c8ba627a <[uhci]uhci_reset_interrupt+26/a0>
   3:   8b 42 e8                  mov    0xffffffe8(%edx),%eax
Code;  c8ba627e <[uhci]uhci_reset_interrupt+2a/a0>
   6:   8b 7a ec                  mov    0xffffffec(%edx),%edi
Code;  c8ba6280 <[uhci]uhci_reset_interrupt+2c/a0>
   9:   25 00 00 00 2f            and    $0x2f000000,%eax
Code;  c8ba6286 <[uhci]uhci_reset_interrupt+32/a0>
   e:   0d 00 00 80 01            or     $0x1800000,%eax
Code;  c8ba628a <[uhci]uhci_reset_interrupt+36/a0>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

----------------------------------8<----------------------------------------

contents of /proc/bus/usb/devices:

----------------------------------8<----------------------------------------

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=1820
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=1800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0557 ProdID=2008 Rev= 0.01
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=serial
E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms


----------------------------------8<----------------------------------------

If there is anything I could to do help to fix this I am more than
willing to do this.

Thanks.

	Peter Kruse

-- 
Peter Kruse <pk@q-leap.com>
Q-Leap Networks GmbH
+497071-703171

