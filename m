Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbTAORYE>; Wed, 15 Jan 2003 12:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTAORYE>; Wed, 15 Jan 2003 12:24:04 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:34806 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S266731AbTAORYD>; Wed, 15 Jan 2003 12:24:03 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD904@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "'anton@samba.org'" <anton@samba.org>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Date: Wed, 15 Jan 2003 11:32:26 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>(3) setup_ioapic_ids_from_mpc() panic()'s.
>-- the clustered_apic_mode check and/or its current equivalent
>-- no longer suffices with 16 IO-APIC's. Turn off all the
>-- renumbering logic and hardcode the numbers to alternate
>-- between 13 and 14, where they belong.
>-- The real issue here is that the phys_id_present_map is not
>-- properly per- APIC bus. The physid's of IO-APIC's are
>-- irrelevant from the standpoint of the rest of the kernel,
>-- but are inexplicably used to identify them throughout the
>-- rest of arch/i386/ when physids are nothing resembling
>-- unique identifiers in multiple APIC bus systems. This

I also have a problem with setup_ioapic_ids_from_mpc(). I opt for 0xFF as
max io_apic phys_id (and leave it alone!), because even though we have fewer
IO-APICs than that, I'd like to keep the actual numbers from MP table or
ACPI, because all APIC and IO-APIC id's on ES7000 are 8 bit, unique, and
meaningful (used as a bitmaps) when I have to implement CPU, PCI hot plug
and dynamic partitioning (I hate to think of possible confusing tables and
dependencies I will have to maintain otherwise...). 

Could this routine be made with alternative architecturally private path (as
a hook or with a hook inside)?

Thanks,

--Natalie
