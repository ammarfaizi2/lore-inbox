Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263269AbSJHTRN>; Tue, 8 Oct 2002 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263265AbSJHTQO>; Tue, 8 Oct 2002 15:16:14 -0400
Received: from kim.it.uu.se ([130.238.12.178]:54457 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S263255AbSJHTPY>;
	Tue, 8 Oct 2002 15:15:24 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15779.12316.221479.23071@kim.it.uu.se>
Date: Tue, 8 Oct 2002 21:21:00 +0200
To: EricAltendorf@orst.edu
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.41: arch/i386/kernel/mpparse.c: compile error
In-Reply-To: <200210081103.46463.EricAltendorf@orst.edu>
References: <200210081103.46463.EricAltendorf@orst.edu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Altendorf writes:
 > error was:
 > 
 >   gcc -Wp,-MD,arch/i386/kernel/.mpparse.o.d -D__KERNEL__ -Iinclude 
 > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
 > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
 > -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0 
 > -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
 > -DKBUILD_BASENAME=mpparse   -c -o arch/i386/kernel/mpparse.o 
 > arch/i386/kernel/mpparse.c
 > arch/i386/kernel/mpparse.c: In function `MP_processor_info':
 > arch/i386/kernel/mpparse.c:126: warning: implicit declaration of 
 > function `Dprintk'
...
 > # CONFIG_SMP is not set
 > CONFIG_PREEMPT=y
 > # CONFIG_X86_UP_APIC is not set
 > # CONFIG_X86_UP_IOAPIC is not set
...
 > CONFIG_X86_FIND_SMP_CONFIG=y
 > CONFIG_X86_MPPARSE=y

Known bug in scripts/Configure when you switch from an SMP or APIC-enabled
config to one without local APIC: MPPARSE is still emitted.
'make oldconfig' fixes it.
