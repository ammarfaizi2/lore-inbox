Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbSJUXEk>; Mon, 21 Oct 2002 19:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSJUXEk>; Mon, 21 Oct 2002 19:04:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261804AbSJUXEj>;
	Mon, 21 Oct 2002 19:04:39 -0400
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org
In-Reply-To: <m1k7kfzffk.fsf@frodo.biederman.org>
References: <m1k7kfzffk.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Oct 2002 16:11:12 -0700
Message-Id: <1035241872.24994.21.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 13:02, Eric W. Biederman wrote:

> In bug reports please include the serial console output of 
> kexec kexec_test.  kexec_test exercises most of the interesting code
> paths that are needed to load a kernel with lots of debugging print
> statements, so hangs can easily be detected.

Hi again, Eric.

Thanks for sending out pointers to a fresh batch of code.

I applied your patch cleanly to 2.5.44, and tried it on one of the two
"troublesome" systems that I have used in the past.  I had to make one
unrelated change to the SCSI subsystem to fix a problem with a hang
during an ordinary reboot.

Symptoms:
kexec bzImage makes it all the way down to the indirect call at the very
bottom of machine_kexec() before the system appears to hang.

Debugging output from "kexec kexec_test":
# ./kexec ./kexec_test
kexecing image
kexec_test 1.1 starting...
eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
idt: 00000000 C0000000
gdt: 00000000 C0000000
Switching descriptors.
Descriptors changed.
In real mode.
Interrupts enabled.
Base memory size: 0277
--> [ edited: long pause here ] <--
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
A20 enabled
Interrupts disabled.
In protected mode.
Halting.

System info:
IBM eServer xSeries 220 Type 8645-2AX
	processor	: 0
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 8
	model name	: Pentium III (Coppermine)
	stepping	: 10
	cpu MHz		: 799.962
	cache size	: 256 KB
	fdiv_bug	: no
	hlt_bug		: no
	f00f_bug	: no
	coma_bug	: no
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 2
	wp		: yes
	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
	bogomips	: 1576.96

	% lspci
	00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
	00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
	00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
	00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
	00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
	00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
	01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)

What other information can I provide?

Regards,
Andy

ps: if it helps, the OSDL CGL tree has bootimg and linux-2.4.18, and
that combination works (unless X is still running) on this system.





