Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSGXPGG>; Wed, 24 Jul 2002 11:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSGXPGG>; Wed, 24 Jul 2002 11:06:06 -0400
Received: from [196.26.86.1] ([196.26.86.1]:14467 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317331AbSGXPGF>; Wed, 24 Jul 2002 11:06:05 -0400
Date: Wed, 24 Jul 2002 17:26:49 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc3-ac2 SMP
In-Reply-To: <200207231150.14141.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207241643010.17209-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, James Cleverdon wrote:

> Drat!  I thought I had all the logical vs. physical stuff straightened out.
> Could you give this patch a try?  It dumps all kinds of APIC state info.  
> You'll need to put a call to apic_state_dump() into check_timer() just after 
> the TIMER: printk.

ID=0x02000000, LVR=0x00170011, TPR=0x00000000, ARB=0x00000002, PROCPRI=0x000000F0
DFR=0x0FFFFFFF, LDR=0x01000000, ICR=0x00088500, SPIV=0x000001FF, ICR=0x00088500,
ICR2=0x03000000, LVTT=0x00000000, LVTPC=0x00000000
LVT0=0x00010700, LVT1=0x00000400, LVTERR=0x000000FE
ISR: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
TMR: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
IRR: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
clustered_apic_mode=0, esr_disable=0, target_cpus=0x00 apic_broadcast_id=0x0F
raw_phys_apicid[]=       00 01 02 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
			 00 00 00 00 00 00 00 00 00 00 00 00 00
cpu_2_logical_apicid[]=  01 01 02 08 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
			 FF FF FF FF FF FF FF FF FF FF FF FF FF
cpu_2_physical_apicid[]= 02 00 01 03 FF FF FF FF FF FF FF FF FF FF FF FF FF FF F
			 F FF FF FF FF FF FF FF FF FF FF FF FF FF
I/O APIC # 0:
00: 00000931:04000000 00010939:02000000 00010000:00000000 00000941:0F000000
04: 00000949:0F000000 00000951:0F000000 00010959:02000000 00000961:0F000000
08: 00000969:0F000000 00000971:0F000000 00000979:0F000000 00000981:0F000000
0C: 00000989:0F000000 00000991:0F000000 00000999:0F000000 000009A1:0F000000
10: 00010000:00000000 00010000:00000000 00010000:00000000 00010000:00000000
14: 00010000:00000000 00010000:00000000 00010000:00000000 00010000:00000000

> (Hmmm....  Must clean up this patch and submit it to kdb as two new commands, 
> one for I/O APICs and one for local APICs....)

i'd vote for that =) except for one thing.

+       /* APICs tend to spasm when they get errors.  Disable the error intr. */
+       apic_write_around(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);

Isn't that a bit drastic?

Regards,
	Zwane
-- 
function.linuxpower.ca


