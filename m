Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318739AbSG0MAj>; Sat, 27 Jul 2002 08:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSG0MAj>; Sat, 27 Jul 2002 08:00:39 -0400
Received: from [196.26.86.1] ([196.26.86.1]:36801 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318739AbSG0MAj>; Sat, 27 Jul 2002 08:00:39 -0400
Date: Sat, 27 Jul 2002 14:21:36 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>,
       <linux-kernel@vger.kernel.org>, lse <lse-tech@lists.sourceforge.net>,
       <riel@conectiva.com.br>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using
 kmalloc_percpu
In-Reply-To: <20020726201526.GZ2907@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0207271345320.20701-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, William Lee Irwin III wrote:

> On Fri, Jul 26, 2002 at 12:50:12PM -0700, Robert Love wrote:
> > In current 2.5?  I thought Andrew and I fixed all those issues and
> > pushed them to Linus...
> > The `configurable NR_CPUS' patch works fine for me.  I always boot with
> > NR_CPUS=2.
> 
> No idea who it works for, it sure doesn't work here. Behold:
> ...changing IO-APIC physical APIC ID to 14 ... ok.
> BIOS bug, IO-APIC#11 ID 0 is already used!...
> Kernel panic: Max APIC ID exceeded!
> 
> In idle task - not syncing

hmm

Since you can only have 4 bits for your IOAPIC ID, you need to stuff them 
all into the 4 bit address space, looking at the IDs there should be 
plenty space for 8 IOAPICs in the 4 bit region. Another funny, is how come 
it tries to reassign IDs for 12 IOAPICs? unless it picked up more from the 
proprietory vendor section of mp tables seeing as it only picked up 8 at 
boot, i think that code might need a once over.

Another strange check is the following;

if (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid))

and earlier...

if (clustered_apic_mode)
	/* We don't have a good way to do this yet - hack */
	phys_id_present_map = (u_long) 0xf;

urgh...

Overrall i think arch/i386/kernel/io_apic.c needs a looking over.

Cheers,
	Zwane
-- 
function.linuxpower.ca









