Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130944AbRCJGH4>; Sat, 10 Mar 2001 01:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130946AbRCJGHh>; Sat, 10 Mar 2001 01:07:37 -0500
Received: from adsl-141-151-140-219.bellatlantic.net ([141.151.140.219]:63986
	"HELO jmcmullan") by vger.kernel.org with SMTP id <S130944AbRCJGHd>;
	Sat, 10 Mar 2001 01:07:33 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Jason McMullan <jmcmullan@linuxcare.com>
Newsgroups: local.linux.kernel
Subject: SMP and APM
Date: 10 Mar 2001 06:06:31 GMT
Organization: Matrix Fire Systems
Distribution: local
Message-ID: <98cg97$3mp$1@dhcp24.resilience.com>
NNTP-Posting-Host: localhost.localdomain
X-Trace: dhcp24.resilience.com 984204391 3801 127.0.0.1 (10 Mar 2001 06:06:31 GMT)
X-Complaints-To: news@localhost
NNTP-Posting-Date: 10 Mar 2001 06:06:31 GMT
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.1 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm working on a BIOS for a SMP machine, and I was
wondering if the following technique would allow us to
use APM _safely_ under SMP for Linux 2.4.x. APM (or -yech-
ACPI) suspend is necessary for a customer's feature, and
SMP support is required.

	APM Idle calls are _not_ supported on the box, only
APM suspend. So we can take a goodly amount of time _doing_
the APM call. (I know about the long AP INIT times) We just
need to do it.

	Besides, it'd be a great start for all those SMP
laptops out there. ;^)

BP - Boot Processor (CPU 0)
AP - Application Processor (CPU 1...N)

APM32 Call Flow
---------------
	* APs disable their interrupts
	* APs save their Local APIC tables
	* APs halt
	* BP calls APM32 BIOS entry point
	* BP gets back from APM32 call. 
	* APs get INITed (arch/i386/kernel/smpboot.c:do_boot_cpu())
	* APs reload their saved APICs
	* APs restart interrupts
	* BP and APs continue on their merry ways


-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.422.8077 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
