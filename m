Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSE0Mfm>; Mon, 27 May 2002 08:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSE0Mfl>; Mon, 27 May 2002 08:35:41 -0400
Received: from elin.scali.no ([62.70.89.10]:7173 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S316593AbSE0Mfk>;
	Mon, 27 May 2002 08:35:40 -0400
Subject: Re: i8259 and IO-APIC
From: Terje Eggestad <terje.eggestad@scali.com>
To: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020522093139.GA390@hookipa>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 May 2002 14:35:36 +0200
Message-Id: <1022502939.12203.81.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm

I'm a bit curious my self, in theory the IO_APIC should drastically
reduce interrupt latency. An x86 has two interrupt pins, IRQ and NMI.  

The first 8259 are (if remember correctly) connected to the IRQ only,
and the second is connected to IRQ2 on the first 8259 (cascade). 
When an Int is triggered the CPU has to go out and read the registers in
the two 8259's to find the triggered interrupt, and call the
corresponding int handler. THe thing is that the 8259 of today are
located in the south bridge, and there are an internal ISA bus in the
south bridge, but still running at the amazing speed in 10MHz.  

THe IO-APIC, when used, the CPU is set to use the two IRQ pins (IRQ, and
NMI) as a two bit bus, and the IO_APIC send the interruot vector on this
bus, saving the CPU from reading the vector over the slow ISA bus, and
can call the interrupt directly.

However, I've on a couple of  occations tried to measure the interrupt
latency and I end up with that the latency is the same either I use 8259
or APIC. Most likely a problem with my measuring. Especially since you
see better thruput using APIC. However I would like to see you get the
same results with a different NIC. 


Now, if our UDP packetloss are due to bursts, and not sustained traffic,
and you have a NIC that uses memory descriptors (like Intel eepro100
chips, or 3com 90x, most new chips do), you can do a workaround by
increasing the receive ring size in the driver. 

TJ
 

 
On Wed, 2002-05-22 at 11:31, Eric Lemoine wrote:
> I already asked this question but did not get any responses. Please
> condider answering.
> 
> Using the old i8259 interrupts controller, my 1-way Linux2.4.16 box
> livelocks when receiving a high rate UDP flow (interrupt rate is so
> high that the NET_RX_SOFTIRQ never gets the chance to pull the
> packets off the backlog queue). However, the receive livelock
> phenomenom completely disappears when making use of the IO-APIC.
> Does anyone have an explanation for this?
> 
> TIA
> -- 
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

