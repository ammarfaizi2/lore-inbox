Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUG1Prv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUG1Prv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUG1Ppc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:45:32 -0400
Received: from opersys.com ([64.40.108.71]:12558 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S267251AbUG1Por (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:44:47 -0400
Message-ID: <4107C85D.5070201@opersys.com>
Date: Wed, 28 Jul 2004 11:38:05 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Scott Wood <scott@timesys.com>, linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>, Bill Huey <bhuey@lnxw.com>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [patch] IRQ threads
References: <20040727225040.GA4370@yoda.timesys> <20040728062722.GA15283@elte.hu>
In-Reply-To: <20040728062722.GA15283@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> what do you think about making the i8259A's interrupt priorities
> configurable? (a'la rtirq patch) Does it make any sense, given how early
> we mask the source irq and ack the interrupt controller [hence giving
> all other interrupts a fair chance to arrive ASAP]?
> 
> Bernhard Kuhn's rtirq patch is for IO-APIC/APICs, but i think the
> latency issues could be equally well fixed by not keeping the local APIC
> un-ACK-ed during level triggered irqs, but doing the mask & ack thing.
> This will be slightly slower but should make them both redirectable and
> more symmetric and fair.

Not sure why don't want to use something as architecture-specific as the
rtirq patch. We've been developing the Adeos nanokernel for 2 years now,
and it provides a uniform functionality regardless of the architecture
you are running it on. Adeos now runs on x86, PowerPC, ARM (mmu-less and
mmu-full), and IA64. Plus, RTAI now uses Adeos to run side-by-side with
Linux on at least the x86 and the PowerPC. If you're looking at
prioritizing interrupts, then Adeos' interrupt pipeline is certainly the
most compelling method available at this point in time.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

