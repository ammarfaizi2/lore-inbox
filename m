Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278159AbRJLVls>; Fri, 12 Oct 2001 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278158AbRJLVli>; Fri, 12 Oct 2001 17:41:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50587 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278157AbRJLVlZ>; Fri, 12 Oct 2001 17:41:25 -0400
Date: Fri, 12 Oct 2001 14:38:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        Sean Cavanaugh <seanc@gearboxsoftware.com>
Subject: Re: P4 SMP load balancing
Message-ID: <2170144124.1002897524@mbligh.des.sequent.com>
In-Reply-To: <3BC738AD.A0329BBF@colorfullife.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > ovendev:~# cat /proc/interrupts 
>> >            CPU0       CPU1       
>> >   0:    6348212          0    IO-APIC-edge  timer
>> >   1:          2          0    IO-APIC-edge  keyboard
>> >   2:          0          0          XT-PIC  cascade
>> >   8:          1          0    IO-APIC-edge  rtc
>> >   9:          0          0    IO-APIC-edge  acpi
>> >  16:      92620          0   IO-APIC-level  eth0
>> >  18:       5085          0   IO-APIC-level  aic7xxx, aic7xxx
>> > NMI:          0          0 
>> > LOC:    6348388    6348427 
>> > ERR:          0
>> > MIS:          0
>> 
>> I don't think this should happen. In the event of both procs having equal 
>> priority (linux never changes them, so they always do), we should fall back 
>> to the arbitration priority of the lapic. Whether you have 1 or 2 I/O apics
>> working shouldn't make a difference. 
> 
> The P 4 has a new apic, and lowest priority delivery doesn't work
> anymore.
> 
> <<<<<<< Chapter 7.6.10 of 24547202.pdf
> In operating systems that use the lowest priority interrupt delivery
> mode
> but do not update the TPR, the TPR information saved in the chipset will
> potentially cause the interrupt to be always delivered to the same
> processor from the logical set. This behavior is functionally backward
> compatible with the P6 family processor but may result in unexpected
> performance implications.
> <<<<<<< (search for 245472 on google for the pdf file)

Ick.  Thanks for pointing this out ... will go read the P4 docs closer.

Someone here has patches to set the TPR properly, but they weren't
giving the performance gain we'd hoped for. In light of this, they'd
probably help out much more on the P4. I'll see if I can persuade them 
to publish ...

M.

