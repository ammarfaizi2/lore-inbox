Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSEBW4i>; Thu, 2 May 2002 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSEBW41>; Thu, 2 May 2002 18:56:27 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:29280 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315456AbSEBWyT>;
	Thu, 2 May 2002 18:54:19 -0400
From: "Kosta Porotchkin" <kporotchkin@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: IO APIC error
Date: Thu, 2 May 2002 17:44:34 -0600
Message-ID: <007a01c1f234$d7214eb0$a396a8c0@compaq12xl510a>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I discovered some strange behavior of APIC initialization which forced me to
start reading the kernel source code.
Platform: Dual Xeon(tm) motherboard with Intel 82870P2 chipset, diskless.
Net-booting kernel 2.4.17 (Sherman from MontaVista).
1. For some reason the "dmesg" is not displaying an early kernel messages.
The log started somewhere from CPU #2 initialization (which is third CPU -
Two Xeons are recognized as four processors, it is normal). I stopped this
kernel in debugger and got some messages from MP table parsing procedure
which were not included in "dmesg" output:
   I/O APIC # 2 Version 32 at 0xFEC00000
   I/O APIC # 3 Version 32 at 0xFEC80000
   I/O APIC # 4 Version 32 at 0xFEC80400
   I/O APIC # 5 Version 32 at 0xFEC81000
   I/O APIC # 8 Version 32 at 0xFEC81400

2. When I looking through the "dmesg" output I can see the IO APICs ID
re-assignment:
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
init IO_APIC IRQs

3. The things are going wrong during the test phase (i.e. after the "testing
the IO APIC....................." is printed). IO APIC #2 register #00 reads
02008000, which is wrong according to the chipset specification - should be
02000000. That is the reason I got the warning "unexpected IO-APIC, please
mail to linux-smp@vger.kernel.org". Let's said that the platform I using is
pretty new and some hardware errors may happen, so I am less worry about
this particular message. The most strange thing is the readings from the
rest of IO APICs. The IO APIC #3 reads physical ID 4, #4 also 4, both # 5
and #8 has 08000000 in their register #00. How it can be?

4. When I tried to understand the source code, I found that all the IO APIC
operations are done trough the fixed memory addresses (io_apic_read() and
io_apic_write() in io_apic.h). I am sure, I do not understand the boot
process enough for asking my questions, but probably someone from Linux
community will help me to solve this problem. Why the fixed addresses are
used? Shouldn't we use the base address provided by BIOS in MP table for
each IO APIC?

Thanks

Kosta Porotchkin



---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.351 / Virus Database: 197 - Release Date: 4/19/2002


