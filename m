Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUA0ATD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbUA0ATC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:19:02 -0500
Received: from auemail2.lucent.com ([192.11.223.163]:43760 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265693AbUA0AS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:18:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16405.44635.564011.414832@gargle.gargle.HOWL>
Date: Mon, 26 Jan 2004 19:18:35 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "John Stoffel" <stoffel@lucent.com>, ak@muc.de, Valdis.Kletnieks@vt.edu,
       bunk@fs.tum.de, cova@ferrara.linux.it, eric@cisu.net,
       linux-kernel@vger.kernel.org
Subject: 2.6.2-rc2 Hangs on boot (was: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED)
In-Reply-To: <20040125220027.30e8cdf3.akpm@osdl.org>
References: <200401232253.08552.eric@cisu.net>
	<200401251639.56799.cova@ferrara.linux.it>
	<20040125162122.GJ513@fs.tum.de>
	<200401251811.27890.cova@ferrara.linux.it>
	<20040125173048.GL513@fs.tum.de>
	<20040125174837.GB16962@colin2.muc.de>
	<200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
	<20040125191232.GC16962@colin2.muc.de>
	<16404.9520.764788.21497@gargle.gargle.HOWL>
	<20040125202557.GD16962@colin2.muc.de>
	<16404.10496.50601.268391@gargle.gargle.HOWL>
	<20040125220027.30e8cdf3.akpm@osdl.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> "John Stoffel" <stoffel@lucent.com> wrote:
>> 
>> Sure, the darn thing wouldn't boot, it kept Oopsing with the
>> test_wp_bit oops (that I just posted more details about).

Andrew> Does this fix the test_wp_bit oops?

Andrew> --- 25/init/main.c~test_wp_bit-oops-fix	2004-01-25 15:29:53.000000000 -0800
Andrew> +++ 25-akpm/init/main.c	2004-01-25 15:30:03.000000000 -0800
Andrew> @@ -434,9 +434,9 @@ asmlinkage void __init start_kernel(void
Andrew>  	}
Andrew>  #endif
Andrew>  	page_address_init();
Andrew> +	sort_main_extable();
Andrew>  	mem_init();
Andrew>  	kmem_cache_init();
Andrew> -	sort_main_extable();
Andrew>  	if (late_time_init)
Andrew>  		late_time_init();
Andrew>  	calibrate_delay();

No, nor does this fix my booting problem(s) with 2.6.2-rc2.  I'm now
back and running 2.6.1-mm5 without any problems.  Is there any further
info I can give, or patches I can apply?  I've applied the early
printk patch, the above patch, and I'm at a loss where the problem is.

It hangs at the following spot:

   Linux version 2.6.2-rc2 (john@jfsnew) (gcc version 3.3.3 20040110
   (prerelease) (Debian)) #2 SMP Mon Jan 26 09:17:00 EST 2004
   BIOS-provided physical RAM map:
    BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
    BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
    BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
    BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
    BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
    BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
    BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
   767MB LOWMEM available.
   found SMP MP-table at 000fe710
   hm, page 000fe000 reserved twice.
   hm, page 000ff000 reserved twice.
   hm, page 000f0000 reserved twice.
   On node 0 totalpages: 196606
     DMA zone: 4096 pages, LIFO batch:1
     Normal zone: 192510 pages, LIFO batch:16
     HighMem zone: 0 pages, LIFO batch:1


Should I start adding in printks, or would it make sense to go back
through the various 2.6.2-bk# snapshots looking for where the problem
hit?

Here's my PCI info, just in case this info helps:

    > lspci
    00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
    00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge
    00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
    00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
    00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
    00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
    00:0d.0 RAID bus controller: Triones Technologies, Inc. HPT302 (rev
    01)
    00:10.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge
    (non-transparent mode) (rev 13)
    00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
    [Cyclone] (rev 24)
    00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev
    03)
    01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
    (rev 82)
    02:08.0 USB Controller: NEC Corporation USB (rev 41)
    02:08.1 USB Controller: NEC Corporation USB (rev 41)
    02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
    02:0b.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394
    Controller (Link)
    03:06.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
    06)
    03:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
    03:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
