Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161353AbWALWIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161353AbWALWIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161354AbWALWIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:08:00 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:2482 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1161353AbWALWH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:07:59 -0500
Date: Thu, 12 Jan 2006 17:11:33 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Dave Jones <davej@redhat.com>, Con Kolivas <kernel@kolivas.org>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060112221133.GA11601@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Dave Jones <davej@redhat.com>, Con Kolivas <kernel@kolivas.org>,
	ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104190554.GG10592@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 02:05:54PM -0500, Dave Jones wrote:
> On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
>  >  +2.6.15-dynticks-060101.patch
>  >  +dynticks-disable_smp_config.patch
>  > Latest version of the dynticks patch. This is proving stable and effective on 
>  > virtually all uniprocessor machines and will benefit systems that desire 
>  > power savings. SMP kernels (even on UP machines) still misbehave so this 
>  > config option is not available by default for this stable kernel.
> 
> I've been curious for some time if this would actually show any measurable
> power savings. So I hooked up my laptop to a gizmo[1] that shows how much
> power is being sucked.
> 
> both before, and after, it shows my laptop when idle is pulling 21W.
> So either the savings here are <1W (My device can't measure more accurately
> than a single watt), or this isn't actually buying us anything at all, or
> something needs tuning.
> 
> 		Dave

I've done quite a bit of testing with dynticks and various c-state strategies.
On my thinkpad T42, dynticks can save about .5 W (as read from the ACPI battery
interface, but hey it's a good ballpark measurement).  This is when compared to
250HZ and the stock ACPI c-state code.  Both tests were running at the lowest
processor frequency (600 MHZ).  The savings were much greater when running at
1.7 GHZ or when comparing to a HZ value of 1000.  Also the advantage was closer
to 1 W when X was not running.

It might be possible to do even a little better.  Currently, I'm developing a
new ACPI idle policy that tries to take advantage of the long time we may
be able to spend in a C3 state.

Thanks,
Adam
