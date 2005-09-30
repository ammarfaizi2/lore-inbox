Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVI3PqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVI3PqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVI3PqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:46:04 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:37175 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030340AbVI3PqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:46:03 -0400
Date: Fri, 30 Sep 2005 17:46:02 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: linux-kernel@vger.kernel.org
Subject: Wrong CPU speed with cpufreq powernow_k7 driver (ACPI related?)
Message-ID: <20050930154602.GA17459@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The CPU frequency gets misdetected with 2.6.14-rc2-git5
(2.6.14-rc2-g8ddec746). At first everything looks OK:

Detected 1200.312 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 516192k/524288k available (1708k kernel code, 7516k reserved, 522k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2402.80 BogoMIPS (lpj=4805616)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD mobile AMD Athlon(tm) 4  stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.

But when the "powernow_k7" module gets inserted, I get:

powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Detected 6287.851 MHz processor.
powernow: No PST tables match this cpuid (0x762)
powernow: This is indicative of a broken BIOS.
powernow: Trying ACPI perflib
powernow: Minimum speed 2619 MHz. Maximum speed 6287 MHz.

If I remove the "powernow_k7" and "freq_table" modules and reinsert
them, the CPU frequency gets randomly detected right or wrong:

Detected 1200.300 MHz processor.
powernow: SGTC: 10000
powernow: Minimum speed 500 MHz. Maximum speed 1200 MHz.

Detected 3132.872 MHz processor.
powernow: No PST tables match this cpuid (0x762)
powernow: This is indicative of a broken BIOS.
powernow: Trying ACPI perflib
powernow: Minimum speed 1305 MHz. Maximum speed 3132 MHz.

Detected 3027.972 MHz processor.
powernow: No PST tables match this cpuid (0x762)
powernow: This is indicative of a broken BIOS.
powernow: Trying ACPI perflib
powernow: Minimum speed 1261 MHz. Maximum speed 3027 MHz.

Detected 1200.275 MHz processor.
powernow: SGTC: 10000
powernow: Minimum speed 500 MHz. Maximum speed 1200 MHz.

Detected 1200.171 MHz processor.
powernow: SGTC: 10000
powernow: Minimum speed 500 MHz. Maximum speed 1200 MHz.

The machine is a Sony Vaio PCG-FX505 with mobile Athlon 1.2 GHz running
Debian stable (sarge). This used to work with linux-2.6.11. Looking at
the git output, there's only a tiny diff between 2.6.11 and current
which shouldn't make a difference. However, there is a large ACPI
patch, so it could be ACPI related cause powernow_k7 tries to fall back
to ACPI.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
