Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKBS2e>; Thu, 2 Nov 2000 13:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbQKBS2Y>; Thu, 2 Nov 2000 13:28:24 -0500
Received: from newaccess.hereintown.net ([207.196.96.3]:13176 "EHLO
	newaccess.hereintown.net") by vger.kernel.org with ESMTP
	id <S129069AbQKBS2K>; Thu, 2 Nov 2000 13:28:10 -0500
Date: Thu, 2 Nov 2000 13:38:18 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Ulrich Drepper <drepper@redhat.com>
cc: root@chaos.analogic.com, kernel@kvack.org,
        "Dr. David Gilbert" <dg@px.uk.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <m3bsvy2qlb.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.4.21.0011021334170.83-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2000, Ulrich Drepper wrote:

> I'm seeing this as well, but only with PIII Xeon systems, not PII
> Xeon.  Every single timer interrupt on any CPU is accompanied by a NMI
> and LOC increment on every CPU.
> 
>            CPU0       CPU1       
>   0:     146727     153389    IO-APIC-edge  timer
> [...]
> NMI:     300035     300035 
> LOC:     300028     300028 

You mean that isn't supposed to happen?

           CPU0       CPU1
  0:    8480192    7786028    IO-APIC-edge  timer
  1:          3          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          0    IO-APIC-edge  rtc
 13:          0          0          XT-PIC  fpu
 23:     188915     191259   IO-APIC-level  eth0
 28:         16         14   IO-APIC-level  sym53c8xx
 29:      33655      33665   IO-APIC-level  sym53c8xx
 30:          0          0   IO-APIC-level  es1371
NMI:   16266140   16266140
LOC:   16266123   16266122
ERR:          0

This machine isn't even a Xeon, just a PIII CuMine on a ServerWorks HeIII
chipset.

I reported this on -test6 but got no replies.  I'm now running -test10 and
still seeing it.

-Chris
-- 
Two penguins were walking on an iceburg.  The first one said to the
second, "you look like you are wearing a tuxedo."  The second one said,
"I might be..."
                                              --David Lynch, Twin Peaks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
