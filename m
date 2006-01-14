Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945988AbWANDm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945988AbWANDm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 22:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945992AbWANDm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 22:42:29 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:17377 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945988AbWANDm3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 22:42:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=btxDJH0N/f98FRJ1UR5qky14PQ6AxVwhLX2E2VIyAce+bnCs8F+faTpBKWjZH1TU7TOT4Dkjns9yPR/jrHgw/JZEJl469mX2t5VQpYW4sv+fwuagCUyql+72X7+S0m4R+fIRYbpLqA/70tfK+HQDuv8CtXel9t5gDOzpj+QCdXk=
Message-ID: <e5bb8d810601131942r53712423kbd924757195f398b@mail.gmail.com>
Date: Fri, 13 Jan 2006 21:42:26 -0600
From: Philipp Rumpf <prumpf@gmail.com>
To: Dave Jones <davej@redhat.com>, Con Kolivas <kernel@kolivas.org>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
In-Reply-To: <20060104190554.GG10592@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041200.03593.kernel@kolivas.org>
	 <20060104190554.GG10592@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Out of curiosity, why didn't you do the monitoring using
/proc/acpi/battery/.../{state,info} (while running off battery)?  I
think that should have much finer granularity, and avoid various
capacitors that might be in the way and explain the effect you
noticed.

I also tried something that sounds like dynticks a couple of years
back, but found that TCP timers made the really long idle times I was
looking for (my idea was actually to use the RTC to wake up the CPU)
impossible.

prumpf

On 1/4/06, Dave Jones <davej@redhat.com> wrote:
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
>                 Dave
>
> [1] http://www.thinkgeek.com/gadgets/electronic/7657/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
