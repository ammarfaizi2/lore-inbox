Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266512AbRGDHFc>; Wed, 4 Jul 2001 03:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266511AbRGDHFW>; Wed, 4 Jul 2001 03:05:22 -0400
Received: from [210.77.38.126] ([210.77.38.126]:43537 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S266515AbRGDHFH>; Wed, 4 Jul 2001 03:05:07 -0400
Date: Wed, 4 Jul 2001 15:06:59 +0800
From: michaelc <michaelc@turbolinux.com.cn>
X-Mailer: The Bat! (v1.49) UNREG / CD5BF9353B3B7091
Reply-To: michaelc <michaelc@turbolinux.com.cn>
X-Priority: 3 (Normal)
Message-ID: <517423984.20010704150659@turbolinux.com.cn>
To: "D. Stimits" <stimits@idcomm.com>
CC: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: page reserved twice
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wednesday, July 04, 2001, 8:19:27 AM, you wrote:

DS> I'm curious if there is any significance to this, which occurs at each
DS> reboot on an SMP system running noapic (sometimes Netscape manages to
DS> produce a hard lockup on the system, sometimes a core dump indicates NS
DS> had signal 7, bus error, in cases where it doesn't lock the system),
DS> 2.4.6-pre1 with XFS patches:

DS>  kernel: BIOS-provided physical RAM map:
DS>  kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
DS>  kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
DS>  kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
DS>  kernel:  BIOS-e820: 0000000000100000 - 000000000ffe0000 (usable)
DS>  kernel:  BIOS-e820: 000000000ffe0000 - 000000000fff8000 (ACPI data)
DS>  kernel:  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
DS>  kernel: Scan SMP from c0000000 for 1024 bytes.
DS>  kernel: Scan SMP from c009fc00 for 1024 bytes.
DS>  kernel: Scan SMP from c00f0000 for 65536 bytes.
DS>  kernel: found SMP MP-table at 000faf50
DS>  kernel: hm, page 000fa000 reserved twice.
DS>  kernel: hm, page 000fb000 reserved twice.
DS>  kernel: hm, page 000f4000 reserved twice.
DS>  thanteros kernel: hm, page 000f5000 reserved twice.
DS>  thanteros kernel: On node 0 totalpages: 65504
DS>  thanteros kernel: zone(0): 4096 pages.
DS>  kernel: zone(1): 61408 pages.
DS>  kernel: zone(2): 0 pages.
DS>  kernel: Intel MultiProcessor Specification v1.1
DS>  kernel:     Virtual Wire compatibility mode.
DS>  kernel: OEM ID: _AMI_    Product ID: 840_CARMEL__ APIC at: 0xFEE00000


DS> Very similar messages seem to occur on a different machine with RH's
DS> 2.4.2 kernel, BX chipset, and IO-APIC enabled. The machine this is from
DS> has had this message on earlier kernels as well, none of which had XFS
DS> patches. What is the significance (or consequence) of pages reserved
DS> twice?
 I think that the message above  doesn't matter with your nescape crash,
 When linux kernel boot, it reserve all usable low memory,for example
       kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
       kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 then kernel call find_smp_config to get MP configuration table if your machine
 is SMP, and the function will reserve the MP-table at 0xfa000,0xfb000, 0xf4000,
 and because these regions were reserved by kernel, so kernel would
 print the message, so it doesn't cause any problem on your machine.
 

       
-- 
Best regards,
 michael chen                            mailto:michaelc@turbolinux.com.cn

To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


