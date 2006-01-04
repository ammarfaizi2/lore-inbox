Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWADXLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWADXLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWADXLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:11:53 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:8608 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751272AbWADXLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:11:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.15-ck1
Date: Thu, 5 Jan 2006 10:10:53 +1100
User-Agent: KMail/1.9
Cc: ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060104195726.GB14782@redhat.com>
In-Reply-To: <20060104195726.GB14782@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051010.54156.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 06:57, Dave Jones wrote:
> On Wed, Jan 04, 2006 at 02:05:54PM -0500, Dave Jones wrote:
>  > On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
>  >  >  +2.6.15-dynticks-060101.patch
>  >  >  +dynticks-disable_smp_config.patch
>  >  > Latest version of the dynticks patch. This is proving stable and
>  >  > effective on virtually all uniprocessor machines and will benefit
>  >  > systems that desire power savings. SMP kernels (even on UP machines)
>  >  > still misbehave so this config option is not available by default for
>  >  > this stable kernel.
>  >
>  > I've been curious for some time if this would actually show any
>  > measurable power savings. So I hooked up my laptop to a gizmo[1] that
>  > shows how much power is being sucked.
>  >
>  > both before, and after, it shows my laptop when idle is pulling 21W.
>  > So either the savings here are <1W (My device can't measure more
>  > accurately than a single watt), or this isn't actually buying us
>  > anything at all, or something needs tuning.
>
> Ah interesting. It needs to be totally idle for a period of time before
> anything starts to happen at all. After about a minute of doing nothing,
> it started to fluctuate once a second 20,21,19,20,19,20,18,21,19,20,22
> etc..
>
> Goes no lower than 18W, and only occasionally peaks above the old idle
> power usage. Not bad at all.
>
> Causing any activity at all puts it back to the 'have to wait a while
> for things to start happening' state again.

Thanks for testing it. Indeed skipping the ticks alone does not really save 
any significant amount of power. The real chance for power savings comes from 
using this period for smarter C state programming. The other thing as you've 
noticed is that timers need to be curbed or minimised to get the maximum 
benefit and the ondemand governor alone, which unfortunately shows up as 
something not obvious in timertop, polls at 140HZ itself - fiddling with 
ondemand/ settings in sys can drop this but slows the rate at which it 
adapts.

I've basically stopped doing any development on dynticks at this time because 
I simply do not know enough about the interaction between the IO Apic and 
what is happening on SMP. The code to handle SMP seems sane, but I'll need 
outside help to cope with whatever the IO APIC is doing. UP is working fine, 
but it won't be long before truckloads of SMP laptops are here.

Cheers,
Con
