Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280015AbRKFTBI>; Tue, 6 Nov 2001 14:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280031AbRKFTA7>; Tue, 6 Nov 2001 14:00:59 -0500
Received: from cc76797-a.ensch1.ov.nl.home.com ([213.51.205.95]:33028 "EHLO
	jumbo.ceram119") by vger.kernel.org with ESMTP id <S280015AbRKFTAr>;
	Tue, 6 Nov 2001 14:00:47 -0500
Date: Tue, 6 Nov 2001 20:01:11 +0100
From: "Dennis J.A. Bijwaard" <bijwaard@bijwaard.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: kernel panic smp & usb scanner, with ksymoops, superseded
Message-ID: <20011106200111.B18732@jumbo.ceram119>
Reply-To: bijwaard@home.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Sorry about the previous message, I forgot to attach the ksymoops.

I repeatedly get kernel panics when I try to use my usb scanner. As my
scanner is not specified in /usr/src/linux/drivers/usb/scanner.h, I
added it myself at the end of scanner_device_ids as:
    /* Compeye simplex / Trust combiscan / Powervision Technologies Inc. */
        { USB_DEVICE(0x05cb, 0x1483) }, /* compeye simplex */

The kernel panic occurs when I try to scan using sane (in this case the
hp backend). Something similar occurs with other usb backends like mustek.

I've attached the kernel panic info from kernel 2.4.14, with and without
processing by ksymoops. The problem also occured in 2.4.13.
-- 
Kind regards,
                   Dennis Bijwaard

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="README.scanner-2.4.14"

[hp] scsi_flush writing 2 bits
[hp] 0x0000 1B 45                       .E
invalid operand 0000
CPU: 1
EIP: 0010: [<c0114b1a>] not tainted
FLAGS: 00010282
eax: 000000018   ebx: c6c15a20   ecx: 00000097   edx: 01000000
esi: c5aca5edc   edi: c5ca4000   ebp: c5ca5ec8   esp: c5ca5e8c
ds: 0018 es: 0018 ss: 0018
Process dnetc(pid: 825,stackpage=c5ca5000)
Stack: c0221f96 c718b260 c5ca5edc c5ca4000 00000000 00000000 00010000 c73efded
       c0276b40 eb7278d4 017078d4 00000002 00000002 00000001 c5ca5edc c62cd380
       c015ab4 c19fda68 c718b1e8 00000001 00000001 c5ca4000 c718b26c c718b262
Call Trace: [<c0105ab4>] [<c0105dc50>] [<c9oe9dd5>] [<c90dd37a>] [<c90dd6d9>] [<c011efd5>] [<c90dd95a>] [<c0108411>] [<c01086c6>] [<c010a648>]

Code: 0f 0b 8d 65 c8 5b 5e 5f 89 ec 5d c3 89 f6 55 89 e5 83 ec 10
<o>kernel panic: Aiee, killing interrupt handler!
In interupt handler - not syncing

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="README.scanner-2.4.14.out"

ksymoops 2.4.3 on i686 2.4.14.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m /usr/src/linux/System.map (default)

CPU: 1
EIP: 0010: [<c0114b1a>] not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
FLAGS: 00010282
eax: 000000018   ebx: c6c15a20   ecx: 00000097   edx: 01000000
esi: c5aca5edc   edi: c5ca4000   ebp: c5ca5ec8   esp: c5ca5e8c
ds: 0018 es: 0018 ss: 0018
Process dnetc(pid: 825,stackpage=c5ca5000)
Stack: c0221f96 c718b260 c5ca5edc c5ca4000 00000000 00000000 00010000 c73efded
       c0276b40 eb7278d4 017078d4 00000002 00000002 00000001 c5ca5edc c62cd380
       c015ab4 c19fda68 c718b1e8 00000001 00000001 c5ca4000 c718b26c c718b262
Call Trace: [<c0105ab4>] [<c0105dc50>] [<c9oe9dd5>] [<c90dd37a>] [<c90dd6d9>] [<c011efd5>] [<c90dd95a>] [<c0108411>] [<c01086c6>] [<c010a648>]
Code: 0f 0b 8d 65 c8 5b 5e 5f 89 ec 5d c3 89 f6 55 89 e5 83 ec 10

>>EIP; c0114b1a <schedule+592/5a0>   <=====
Trace; c0105ab4 <__down+6c/c8>
Trace; c0105dc50 <END_OF_CODE+b37f7add2/????>
Code;  c0114b1a <schedule+592/5a0>
0000000000000000 <_EIP>:
Code;  c0114b1a <schedule+592/5a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0114b1c <schedule+594/5a0>
   2:   8d 65 c8                  lea    0xffffffc8(%ebp),%esp
Code;  c0114b1e <schedule+596/5a0>
   5:   5b                        pop    %ebx
Code;  c0114b20 <schedule+598/5a0>
   6:   5e                        pop    %esi
Code;  c0114b20 <schedule+598/5a0>
   7:   5f                        pop    %edi
Code;  c0114b22 <schedule+59a/5a0>
   8:   89 ec                     mov    %ebp,%esp
Code;  c0114b24 <schedule+59c/5a0>
   a:   5d                        pop    %ebp
Code;  c0114b24 <schedule+59c/5a0>
   b:   c3                        ret    
Code;  c0114b26 <schedule+59e/5a0>
   c:   89 f6                     mov    %esi,%esi
Code;  c0114b28 <__wake_up+0/c0>
   e:   55                        push   %ebp
Code;  c0114b28 <__wake_up+0/c0>
   f:   89 e5                     mov    %esp,%ebp
Code;  c0114b2a <__wake_up+2/c0>
  11:   83 ec 10                  sub    $0x10,%esp

<o>kernel panic: Aiee, killing interrupt handler!

--MW5yreqqjyrRcusr--
