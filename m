Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSJWRFN>; Wed, 23 Oct 2002 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbSJWRFN>; Wed, 23 Oct 2002 13:05:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265097AbSJWRFK>;
	Wed, 23 Oct 2002 13:05:10 -0400
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
In-Reply-To: <m1ptu1sm5u.fsf@frodo.biederman.org>
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<1035241872.24994.21.camel@andyp> <m13cqzumx3.fsf@frodo.biederman.org>
	<1035328636.29319.55.camel@andyp>  <m1ptu1sm5u.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Oct 2002 10:11:45 -0700
Message-Id: <1035393105.25019.73.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > lspci output for the system:
> > 00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> > 00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> > 00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
> > 00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> > 00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
> > 00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> > 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
> > 01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)


> And please tell me what kexec_test-1.4 reports. I would love to find out which
> BIOS calls are hanging your system.

It's this one: call print_dasd_type

If I comment it out, kexec_test-1.4 runs to completion.

FYI: My installation is on a scsi disk.  I'm beginning to wonder if
there is something funky with the BIOS not being able to talk to
the SCSI controller after the kernel has used it...  Hmmm.


Full output:
Run 1:
# ./kexec-1.4 -debug kexec_test-1.4
kexecing image
kexec_test 1.4 starting...
eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
idt: 00000000 C0000000
gdt: 00000000 C0000000
Switching descriptors.
Descriptors changed.
In real mode.
Interrupts enabled.
Base memory size: 0277
Can not A20 line.
E820 Memory Map.
000000000009DC00 @ 0000000000000000 type: 00000001
0000000000002400 @ 000000000009DC00 type: 00000002
0000000000020000 @ 00000000000E0000 type: 00000002
0000000027EED140 @ 0000000000100000 type: 00000001
0000000000010000 @ 0000000027FF0000 type: 00000002
0000000000002EC0 @ 0000000027FED140 type: 00000003
0000000001400000 @ 00000000FEC00000 type: 00000002
E801  Memory size: 0009F800
Mem88 Memory size: FFFF
Testing for APM.
APM test done.
DASD type:

<Wedged>

Run 2:
# ./kexec-1.4 -debug kexec_test-1.4
kexecing image
kexec_test 1.4 starting...
eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
idt: 00000000 C0000000
gdt: 00000000 C0000000
Switching descriptors.
Descriptors changed.
In real mode.
Interrupts enabled.
Base memory size: 0277
Can not A20 line.
E820 Memory Map.
000000000009DC00 @ 0000000000000000 type: 00000001
0000000000002400 @ 000000000009DC00 type: 00000002
0000000000020000 @ 00000000000E0000 type: 00000002
0000000027EED140 @ 0000000000100000 type: 00000001
0000000000010000 @ 0000000027FF0000 type: 00000002
0000000000002EC0 @ 0000000027FED140 type: 00000003
0000000001400000 @ 00000000FEC00000 type: 00000002
E801  Memory size: 0009F800
Mem88 Memory size: FFFF
Testing for APM.
APM test done.
Equiptment list: 4427
Sysdesc: F000:E6F5
EDD:  ok 
Video type: VGA
Cursor Position(Row,Column): 0012 0000
Video Mode: 0003
Setting auto repeat rate  done
A20 enabled
Interrupts disabled.
In protected mode.
Halting.

