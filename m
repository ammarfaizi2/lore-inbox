Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311762AbSCTQVY>; Wed, 20 Mar 2002 11:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311747AbSCTQTa>; Wed, 20 Mar 2002 11:19:30 -0500
Received: from 208-59-250-172.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com ([208.59.250.172]:44672
	"EHLO bradm.net") by vger.kernel.org with ESMTP id <S311752AbSCTQSr>;
	Wed, 20 Mar 2002 11:18:47 -0500
Date: Wed, 20 Mar 2002 11:18:40 -0500
From: Bradley McLean <bradlist@bradm.net>
To: linux-kernel@vger.kernel.org
Subject: Hard hang on 3Ware7850, Dual AthlonMP, Tyan2462
Message-ID: <20020320111840.A7078@nia.bradm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been following the various discussions of athlon MP problems.

We too have systems that consistently hard lock up.

Running RH7.2 with kernel.org kernels, versions 2.4.17, 2.4.18,
or 2.4.18 plus the IO-APIC patch posted for 2.4.19pre3.
Using the latest (release 7.4, driver version 19) 3ware code.

Tyan 2462, 3.5 GB
(2) AMD MP1900+
(6) WB1200JB

Symptoms:  Either under heavy read, or heavy write, system locks up.  No ping, no keyboard.
Tests:
(T1) On single disks, run five simultaneous mke2fs, one each disk.
(T2) On single disks, run five simultaneous bonnie++, one each disk.
(T3) On 4 disk raid5, run three simultaneous bonnie++
(T4) On 4 disk raid5, run four simultaneous postgresql dump/restore/vacuum.

T3 and T4 have failed under everything except stock 2.4.7 and 2.4.9 from RH,
where they run agonizingly slow.

T1 failed on all 2.4.17 and 2.4.18 attempts (including earlier versions
of the 3ware firmware and driver), until the IO-APIC patch was added.
Then T1 and T2 both passed, several repetitions.

T3 and T4 both continue to fail, always during high bandwidth disk reads.
It appears the write portion is solved, either by the upgrade to 7.4 driver
and firmware, or by the IOAPIC patch, or both.  The read still fails
in a predictable time range, but not exactly the same - once the
card is up to full capacity with 256 outstanding commands, it will fail
within the next few minutes.

When the system is set to nosmp, all tests pass, although we've had one
unexplained lockup even under these conditions.  Load data was not
available.

noapic seems to have no effect.

Dual PIII Xeon 550 based systems do not exhibit the symptom.

APIC seems highly suspect.

Anyone with suggestions, or test cases?

Thanks,

-Brad McLean
