Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbTAWByB>; Wed, 22 Jan 2003 20:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbTAWByB>; Wed, 22 Jan 2003 20:54:01 -0500
Received: from ns0.usq.edu.au ([139.86.2.5]:19800 "EHLO ns0.usq.edu.au")
	by vger.kernel.org with ESMTP id <S264815AbTAWBx7> convert rfc822-to-8bit;
	Wed, 22 Jan 2003 20:53:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
Date: Thu, 23 Jan 2003 12:02:52 +1000
Message-ID: <08D7835AE15D6F4BABB5C46427F018DF3F0797@babbage.usq.edu.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
Thread-Index: AcLCdRNL6DL/V7zJTHG1CgxrxTfSsgADlUTw
From: "Jacek Radajewski" <jacek@usq.edu.au>
To: "Pete Zaitcev" <zaitcev@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Jan 2003 02:02:53.0206 (UTC) FILETIME=[8A07B360:01C2C283]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original oops log was :


[root@cray root]# ide-floppy driver 0.99.newide
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Unable to handle kernel NULL pointer dereference at virtual address 00000007
 printing eip:
f897f51d
*pde = 00000000
Oops: 0002
soundcore nls_iso8859-1 ide-cd cdrom binfmt_misc autofs tg3 usb-ohci usbcore ext3 jbd aacraid sd_mod scsi_mod  
CPU:    0
EIP:    0010:[<f897f51d>]    Not tainted
EFLAGS: 00010246

EIP is at cdrom_do_packet_command [ide-cd] 0x2d (2.4.18-19.7.xsmp)
eax: f6a2dc00   ebx: 00000000   ecx: ffffffff   edx: c03fdc04
esi: c03fdc04   edi: 00000000   ebp: dd70b89c   esp: c0349ee4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0349000)
Stack: c01ac741 c03fdc04 dd70b89c 00000000 00000000 c03fdbc0 00000000 c03fdc04 
       c03fdbc0 dd70b89c c03fdc04 0000000e c01acacc c03fdc04 dd70b89c c3684e80 
       c03fdc04 00000296 c03fdbc0 c01acf99 c3684e80 0000000e f897f2f0 c36b0d60 
Call Trace: [<c01ac741>] start_request [kernel] 0x1a1 (0xc0349ee4))
[<c01acacc>] ide_do_request [kernel] 0x29c (0xc0349f14))
[<c01acf99>] ide_intr [kernel] 0x129 (0xc0349f30))
[<f897f2f0>] cdrom_pc_intr [ide-cd] 0x0 (0xc0349f3c))
[<c010a61e>] handle_IRQ_event [kernel] 0x5e (0xc0349f50))
[<c010a852>] do_IRQ [kernel] 0xc2 (0xc0349f70))
[<c0106e60>] default_idle [kernel] 0x0 (0xc0349f88))
[<c0105000>] stext [kernel] 0x0 (0xc0349f8c))
[<c010d058>] call_do_IRQ [kernel] 0x5 (0xc0349f94))
[<c0106e60>] default_idle [kernel] 0x0 (0xc0349fa4))
[<c0105000>] stext [kernel] 0x0 (0xc0349fa8))
[<c0106e8c>] default_idle [kernel] 0x2c (0xc0349fc0))
[<c0106ef4>] cpu_idle [kernel] 0x24 (0xc0349fcc))


Code: c7 41 08 00 00 00 00 68 b0 f4 97 f8 8b 41 04 50 52 e8 8d f2 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 



-----Original Message-----
From: Pete Zaitcev [mailto:zaitcev@redhat.com]
Sent: Thursday, 23 January 2003 10:19 AM
To: Jacek Radajewski
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN


> ksymoops 2.4.4 on i686 2.4.18-19.7.xsmp.  Options used

2.4.18-19.7.x should not need ksymoops, because it ships with
kksymoops. In fact, it's harmful, because ksymoops ate the EIP
decoding:

> EIP:    0010:[<f897f51d>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246

Also, the oops does not seem to be related to the BCM card.
Probably your IDE cabling is flakey :)

-- Pete
