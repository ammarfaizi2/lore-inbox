Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUEENMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUEENMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEENMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:12:08 -0400
Received: from gizmo04bw.bigpond.com ([144.140.70.14]:5293 "HELO
	gizmo04bw.bigpond.com") by vger.kernel.org with SMTP
	id S264653AbUEENIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:08:18 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Ian Kumlien <pomac@vapor.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Wed, 5 May 2004 23:12:44 +1000
User-Agent: KMail/1.5.1
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com> <200405052214.38855.ross@datscreative.com.au> <1083760029.2797.33.camel@big>
In-Reply-To: <1083760029.2797.33.camel@big>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200405052312.44623.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 May 2004 22:27, Ian Kumlien wrote:
> On Wed, 2004-05-05 at 14:14, Ross Dickson wrote:
> > To my knowledge the only thing left to sort out for the normal kernel
> > distro is what to do about the timer_ack issue in check_timer().
> > 
> > We need it off for nforce2 to get nmi_watchdog=1 working with ioapic
> > 8254 timer pin0  timer override patch routing. I vote to revisit Maciej's
> > patch that was dropped by Linus after appearing in 2.6.3-mm3. 
> > For those with problems of clock skew with the timer into pin0 routing, 
> > that patch gave a virtual wire timer routing which worked well for those
> > users.
> 
> Whats the real difference between nmi_watchdog?1 and =2? Since
> nmi_watchdog=2 works here:
> 
> NMI:       9884
> LOC:   80297310
> ERR:          0
> MIS:          0

>From memory 2 uses resources that code profiling tools need to use so
if you can use 1 then you can have your watchdog and profile too.

> 
> Also, wouldn't it be better to not depend on bioses and bios versions
> atm, ie hardcode pin0 since Allen Martin stated that it's hardwired on
> pin0?
> 
> ie, just:
> if(pin2 && nforce2_chip)
> {
> 	printk("ALERT: Known defect in bios, mail your manufacturer. Using
> pin0\n");
> 	<whateverisneededtousepin0>
> }

It should be OK, but those with mobos that get clock skew on pin 0 would
then demand a clock skew fix for their noisy hardware. I don't have a
motherboard with skew problems.

Personally I think that the clock system should be made immune to noise
generated timer interrupts just as it has been coded to detect missing
timer interrupts. I am pretty sure on nforce2 athlon mobos the tsc is used
in detecting missing pulses. Kind of like a digital phase locked loop? so
should it not also debounce the interrupts given that the ioapic interrupt
hardware cannot?
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/6385.html
Obviously the pc hardware design is flawed in this respect.

Anyone know how to modify the existing timer tsc code to do this? And
offer to do it? Any brand/type of mobo is open to clock speed up due
to this effect, so I think it should be fixed, debouncing is fundamental
to input transitions that need to be counted.
 
-Ross

> 
> Since this whole problem is pissing me off... It would be much better if
> one had some kind of access to the information from nvidia so you can
> just point at it, telling the mb-manuf. that they are morons and go fix
> =). (Did i mention that i have had this problem for quite some time and
> would have gone postal if it wasn't for Ross Dicksons fixes =))
> 
> -- 
> Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net
> 

