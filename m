Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288496AbSADFKz>; Fri, 4 Jan 2002 00:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288495AbSADFKg>; Fri, 4 Jan 2002 00:10:36 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:39577 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S288493AbSADFKX>; Fri, 4 Jan 2002 00:10:23 -0500
Message-ID: <3C353920.8000604@allegientsystems.com>
Date: Fri, 04 Jan 2002 00:09:52 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Nick Papadonis <nick@coelacanth.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <3C3382CA.3000503@allegientsystems.com>	<3C345493.5040800@evision-ventures.com>	<20020103154718.C32419@infosys.tuwien.ac.at>	<3C347A12.3070404@evision-ventures.com>	<3C34B35A.7000309@allegientsystems.com> <m3ell76p4h.fsf@localhost.localdomain> <3C35369D.5040600@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Possibly.  If anything it's likely that either the orinoco or the i810 
> driver is not handling spurious interrupts properly.  Now, since I've 
> been using my i810 device in a machine that doesn't share it's 
> interrupt I can't *personally* vouch that it handles things properly, 
> but from looking at the interrupt handler code, it should.  The other 
> possibility is that the orinoco might enable interrupts on the pcmcia 
> slot before it actually registers its own interrupt handler.  If it 
> does, and the card already has the interrupt line lit up, then it can 
> generate an interrupt storm that looks like a machine lockup.  A way 
> to test that is to unload the i810 sound driver and anything else that 
> might use the interrupt the orinoco uses, then load the orinoco, wait 
> until it's fully up and running, then load the i810 driver and see if 
> things work that way.  If it does, then it's almost certainly an init 
> sequence issue in the orinoco driver. 

Forgot to mention, my machine is sharing IRQ 17 between a 3c905 and the 
i810. So it seems ok here. Perhaps there's a problem with the  orinoco 
driver's ISR.

