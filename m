Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVIGQmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVIGQmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVIGQmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:42:32 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:58946 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751241AbVIGQmb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:42:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YoPf3AKwcbXEZykjc3+P46lHSE3pDWjPAg/Kf9NLEtRW41rEfpgACc+vvddAGDtMJcbJ1gNdDa0Qv7F9IOOsclUTtgkpAhVdsQy5ZeuR4P+ewLewzNN2uGfoSrrQ/ODl2dCrOwuL/sVqZlA4ysiT9zl8EVE7vCGwSzsVwwDvvlM=
Message-ID: <29495f1d0509070942688059a6@mail.gmail.com>
Date: Wed, 7 Sep 2005 09:42:24 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Cc: vatsa@in.ibm.com, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
In-Reply-To: <431F11FF.2000704@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050831165843.GA4974@in.ibm.com>
	 <200509031801.09069.kernel@kolivas.org>
	 <20050903090650.B26998@flint.arm.linux.org.uk>
	 <200509031814.49666.kernel@kolivas.org>
	 <20050904201054.GA4495@us.ibm.com>
	 <20050904212616.B11265@flint.arm.linux.org.uk>
	 <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com>
	 <20050905063229.GB4294@in.ibm.com> <431F11FF.2000704@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, Bill Davidsen <davidsen@tmr.com> wrote:
> Srivatsa Vaddagiri wrote:
> > On Sun, Sep 04, 2005 at 10:48:13PM -0700, Nishanth Aravamudan wrote:
> >
> >>Admittedly, I don't think SMP ARM has been around all that long? Maybe
> >>the existing code just has not been extended.
> >
> >
> > Yeah, maybe ARM never cared for SMP. But we do care :)
> >
> >
> >>I'm not sure on this. It's going to be NULL for other architectures, or
> >>end up being called by the reprogram() call for the last CPU to go idle,
> >>right (presuming there isn't a separate TOD source, like in x86). I
> >>think it is better to be in the reprogram() interface.
> >
> >
> > Non-x86 could have it set to NULL, in which case it doesn't get called.
> > (I know the current code does not take care of this situation).
> > But having an explicit 'all_cpus_idle' interface may be good, since
> > Tony talked of idling some devices when all CPUs are idle. So it
> > probably has non-x86/PIT uses too.
> 
> If this is intended to reduce power, and it originally came from that
> root, then this is the time to put in a hook for transitions to<=>from
> the all-idle state. Various arch may have things other than the PIT
> which should (or at least can) be stopped, and which need to be restarted.

Hrm, got dropped from the Cc... :) Yes, the dynamic-tick generic
infrastructure being proposed, with the idle CPU mask and the
set_all_cpus_idle() tick_source hook, would allow exactly this in
arch-specific code.

Is there a generic location where the all-idle state is entered?
Currently, I think we can do it via the generic reprogram() routine
checking the mask and then calling set_all_cpus_idle(), if
appropriate, after reprogramming the last idle CPU.

Thanks,
Nish
