Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282430AbRKZTwb>; Mon, 26 Nov 2001 14:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282448AbRKZTwT>; Mon, 26 Nov 2001 14:52:19 -0500
Received: from fe6.southeast.rr.com ([24.93.67.53]:1544 "EHLO
	Mail6.triad.rr.com") by vger.kernel.org with ESMTP
	id <S282435AbRKZTuq>; Mon, 26 Nov 2001 14:50:46 -0500
Message-ID: <3C029D3F.E43B4E9C@triad.rr.com>
Date: Mon, 26 Nov 2001 14:51:27 -0500
From: "John D. Davis" <jddavis@triad.rr.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16cd i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible problems with khub in current 2.4.15-2.4.16 kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed an odd occurance with the 2.4.15 and 2.4.16 kernels during
testing.

There seems to be a problem with khub.c  or it could be my hardware but
I keep getting the following oops and ptrace about 50% of the time
during boot.  The following snip is from the boot log of the 2.4.16
kernel compliled this afternoon.

If anyone has any ideas or a suggested fix.

John Davis

Nov 26 13:50:02 orca kernel: Freeing unused kernel memory: 252k freed
Nov 26 13:50:02 orca kernel: hub.c: USB new device connect on bus1/1,
assigned device number 2
Nov 26 13:50:02 orca kernel: hub.c: USB hub found
Nov 26 13:50:02 orca kernel: hub.c: 5 ports detected
Nov 26 13:50:02 orca kernel: hub.c: USB new device connect on bus1/1/4,
assigned device number 3
Nov 26 13:50:02 orca kernel: input0: USB HID v1.10 Mouse [Logitech USB
Mouse] on usb1:3.0
Nov 26 13:50:02 orca kernel: hub.c: USB new device connect on bus1/1/5,
assigned device number 4
Nov 26 13:50:02 orca kernel: usb-uhci.c: interrupt, status 2, frame#
1105
Nov 26 13:50:02 orca kernel: input1: USB HID v1.00 Keyboard [FTDI  PS/2
Keyboard And Mouse I/F] on usb1:4.0
Nov 26 13:50:02 orca kernel: Adding Swap: 1228932k swap-space (priority
-1)
Nov 26 13:50:02 orca kernel: usb_control/bulk_msg: timeout
Nov 26 13:50:02 orca kernel: input2<1>Unable to handle kernel paging
request at virtual address ffffffff
Nov 26 13:50:02 orca kernel:  printing eip:
Nov 26 13:50:02 orca kernel: c0264fbb
Nov 26 13:50:02 orca kernel: *pde = 00001063
Nov 26 13:50:02 orca kernel: *pte = 00000000
Nov 26 13:50:02 orca kernel: Oops: 0000
Nov 26 13:50:02 orca kernel: CPU:    0
Nov 26 13:50:02 orca kernel: EIP:    0010:[vsnprintf+523/1056]    Not
tainted
Nov 26 13:50:02 orca kernel: EIP:    0010:[<c0264fbb>]    Not tainted
Nov 26 13:50:02 orca kernel: EFLAGS: 00010097
Nov 26 13:50:02 orca kernel: eax: ffffffff   ebx: c03190b0   ecx:
ffffffff   edx: fffffffe
Nov 26 13:50:02 orca kernel: esi: ffffffff   edi: c1557ed4   ebp:
ffffffff   esp: c1557e84
Nov 26 13:50:02 orca kernel: ds: 0018   es: 0018   ss: 0018
Nov 26 13:50:02 orca kernel: Process khubd (pid: 7, stackpage=c1557000)
Nov 26 13:50:02 orca kernel: Stack: 00000000 c031949f 0000000a c03190a0
00000246 00000001 c1543c00 c0115a0e
Nov 26 13:50:02 orca kernel:        c03190a0 00000400 c029f1b4 c1557ec8
d3b3a000 ffffffff 00000001 c021c3ac
Nov 26 13:50:02 orca kernel:        c029f1a0 00000001 00000000 ffffffff
d3b3b230 00000001 00000004 00000001
Nov 26 13:50:02 orca kernel: Call Trace: [printk+94/272]
[hid_probe+300/320] [usb_find_interface_driver+318/496]
[usb_find_drivers+57/128] [usb_new_device+387/416]
Nov 26 13:50:02 orca kernel: Call Trace: [<c0115a0e>] [<c021c3ac>]
[<c020ebbe>] [<c020ee99>] [<c0210da3>]
Nov 26 13:50:02 orca kernel:    [usb_hub_port_connect_change+539/784]
[usb_hub_port_connect_change+583/784] [usb_hub_events+276/688]
[usb_hub_thread+53/96] [_stext+0/48] [kernel_thread+38/48]
Nov 26 13:50:02 orca kernel:    [<c021226b>] [<c0212297>] [<c0212474>]
[<c0212645>] [<c0105000>] [<c0105516>]
Nov 26 13:50:02 orca kernel:    [usb_hub_thread+0/96]
Nov 26 13:50:02 orca kernel:    [<c0212610>]
Nov 26 13:50:02 orca kernel:
Nov 26 13:50:02 orca kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4
29 c8 f6 04 24 10 89 c6
Nov 26 13:50:02 orca kernel:  <6>EXT3 FS 2.4-0.9.15, 06 Nov 2001 on
ide0(3,5), internal journal
Nov 26 13:50:02 orca kernel: kjournald starting.  Commit interval 5
seconds
Nov 26 13:50:02 orca kernel: EXT3 FS 2.4-0.9.15, 06 Nov 2001 on
ide0(3,1), internal journal
