Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSKKWqc>; Mon, 11 Nov 2002 17:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSKKWqc>; Mon, 11 Nov 2002 17:46:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:23517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261524AbSKKWqa>;
	Mon, 11 Nov 2002 17:46:30 -0500
Subject: Re: Kexec for v2.5.47 (test feedback)
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
In-Reply-To: <m1vg349dn5.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com> 
	<m1vg349dn5.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Nov 2002 14:52:29 -0800
Message-Id: <1037055149.13304.47.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 10:15, Eric W. Biederman wrote:
> kexec is a set of system calls that allows you to load another kernel
> from the currently executing Linux kernel.

> And is currently kept in two pieces.
> The pure system call.
> http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.47.x86kexec.diff

FYI: that patch applies cleanly to pure 2.5.47 (bk ChangeSet@1.823).

The current front of the tree does not patch 100% cleanly (conflicts
with recent module changes).

Results on my usual problem machine:

# ./kexec-1.5 ./kexec_test-1.5
Shutting down devices
Debug: sleeping function called from illegal context at include/asm/semaphore.h9
Call Trace: [<c011a698>]  [<c0216193>]  [<c012b165>]  [<c0132dec>]  [<c0140357> Starting new kernel
kexec_test 1.5 starting...
eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
idt: 00000000 C0000000
gdt: 00000000 C0000000
Switching descriptors.
Descriptors changed.
Legacy pic setup.
In real mode.
<hang>

Sorry about the linewrap.

Same as last time, but the good news is that splitting the load and reboot
operations works as expected.

> And the set of hardware fixes known to help kexec.
> http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.47.x86kexec-hwfixes.diff

Missing or inaccessible.  I'll try some duct tape and the
linux-2.5.44.x86kexec-hwfixes.diff and see what happens.

Confirming some earlier suspicions:
CONFIG_SMP=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

Last time I tried to run a UP kernel (and no APIC support) on this system
it wasn't pretty.  I'll add that to my list of combinations to try.

And as always:
% lspci 
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
% cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 799.957
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
% 



