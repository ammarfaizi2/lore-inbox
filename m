Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbTBVA2w>; Fri, 21 Feb 2003 19:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267809AbTBVA2w>; Fri, 21 Feb 2003 19:28:52 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:61327 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S265708AbTBVA2v>;
	Fri, 21 Feb 2003 19:28:51 -0500
Date: Sat, 22 Feb 2003 01:38:49 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200302220038.h1M0cn6r004153@harpo.it.uu.se>
To: ionut@badula.org, m.c.p@wolk-project.de
Subject: Re: UP local APIC is deadly on SMP Athlon
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2003 22:41:23 +0100, Marc-Christian Petersen wrote:
>> And this is what I found: eliminating two lines from
>> APIC_init_uniprocessor() makes the problem go away.
>> diff -urNX diff_kernel_excludes linux-2.4.10-pre12/arch/i386/kernel/apic.c
>> linux-2.4.10-pre11++/arch/i386/kernel/apic.c ---
>> linux-2.4.10-pre12/arch/i386/kernel/apic.c	Wed Feb 19 23:53:15 2003 +++
>> linux-2.4.10-pre11++/arch/i386/kernel/apic.c	Fri Feb 21 15:37:06 2003 @@
>> -1087,9 +1087,6 @@
>>
>>  	connect_bsp_APIC();
>>
>> -	phys_cpu_present_map = 1;
>> -	apic_write_around(APIC_ID, boot_cpu_id);
>> -
>>  	apic_pm_init2();
>>
>>  	setup_local_APIC();
>>
>> [patch against 2.4.10-pre12, but 2.4.21-pre4 is reasonably similar]
>Don't do this. I am pretty sure it will break all Intels. I still cannot 
>understand why this fixes your AMD Athlon problem.

This is interesting. Very interesting, even. A plain UP_APIC kernel
(with IO_APIC not enabled or not detected) shouldn't need to touch
APIC_ID at all. I strongly suspect this is a remnant of apic.c's old
SMP-only history, and that it should be removed for UP_APIC-only.

I need to get some downtime (zzz...) but I'll look into this ASAP.

/Mikael
