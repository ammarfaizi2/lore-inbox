Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbTAOVxh>; Wed, 15 Jan 2003 16:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267380AbTAOVxh>; Wed, 15 Jan 2003 16:53:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17087 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267376AbTAOVxf>; Wed, 15 Jan 2003 16:53:35 -0500
Date: Wed, 15 Jan 2003 14:01:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@Unisys.Com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>
cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'anton@samba.org'" <anton@samba.org>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <156310000.1042668097@titus>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C022BD904@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C022BD904@usslc-exch-4.slc.unisys.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> (3) setup_ioapic_ids_from_mpc() panic()'s.
>> -- the clustered_apic_mode check and/or its current equivalent
>> -- no longer suffices with 16 IO-APIC's. Turn off all the
>> -- renumbering logic and hardcode the numbers to alternate
>> -- between 13 and 14, where they belong.
>> -- The real issue here is that the phys_id_present_map is not
>> -- properly per- APIC bus. The physid's of IO-APIC's are
>> -- irrelevant from the standpoint of the rest of the kernel,
>> -- but are inexplicably used to identify them throughout the
>> -- rest of arch/i386/ when physids are nothing resembling
>> -- unique identifiers in multiple APIC bus systems. This
> 
> I also have a problem with setup_ioapic_ids_from_mpc(). I opt for 0xFF as
> max io_apic phys_id (and leave it alone!), because even though we have fewer
> IO-APICs than that, I'd like to keep the actual numbers from MP table or
> ACPI, because all APIC and IO-APIC id's on ES7000 are 8 bit, unique, and
> meaningful (used as a bitmaps) when I have to implement CPU, PCI hot plug
> and dynamic partitioning (I hate to think of possible confusing tables and
> dependencies I will have to maintain otherwise...). 
> 
> Could this routine be made with alternative architecturally private path (as
> a hook or with a hook inside)?

I don't think changing the Linux data structures is a problem, but you
need to be really careful not to change anything for normal machines
when writing out to / reading from the IO-APIC - that stuff is too fragile, 
and breaks on strange machines in wierd ways. 

If you can find a clean way to change the internal stuff, and just wrap 
the in/out interfaces, that would seem best to me ...

M.

