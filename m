Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266262AbSKGBDs>; Wed, 6 Nov 2002 20:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbSKGBDs>; Wed, 6 Nov 2002 20:03:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:52948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266262AbSKGBDq>;
	Wed, 6 Nov 2002 20:03:46 -0500
Subject: Re: kexec for 2.5.46
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org
In-Reply-To: <m14ravfbjj.fsf@frodo.biederman.org>
References: <m14ravfbjj.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Nov 2002 17:11:11 -0800
Message-Id: <1036631471.10457.233.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 22:38, Eric W. Biederman wrote:
> Linus please apply,


FYI: patch applied cleanly for me.

After fudging kexec-tools-1.4 to correct for the new syscall number:

    # ./kexec-1.4+ -debug ./kexec_test-1.4
    Synchronizing SCSI caches: 
    Shutting down devices
    Starting new kernel
    kexec_test 1.4 starting...
    eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
    esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
    idt: 00000000 C0000000
    gdt: 00000000 C0000000
    Switching descriptors.
    Descriptors changed.
    In real mode.
    <hang>

It does not make it to the "Interrupts enabled." print, so it is
probably going wacko at the "sti."

As before, the system:
% lspci -tv
-+-[01]---03.0  Adaptec AIC-7892P U160/m
 \-[00]-+-00.0  ServerWorks CNB20LE Host Bridge
        +-00.1  ServerWorks CNB20LE Host Bridge
        +-01.0  S3 Inc. Savage 4
        +-09.0  Intel Corp. 82557/8/9 [Ethernet Pro 100]
        +-0f.0  ServerWorks OSB4 South Bridge
        +-0f.1  ServerWorks OSB4 IDE Controller
        \-0f.2  ServerWorks OSB4/CSB5 OHCI USB Controller
% cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 799.717
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 1576.96



