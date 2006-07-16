Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWGPTWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWGPTWE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWGPTWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:22:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:15854 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751169AbWGPTWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:22:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dUDa4gpXUpZdcnWiLMEfc58UOdDr+OCcW7XstWfHLjaCCvL+NV/YQwSOdFw94U+beAvFP2kdTK3y7c6P1BLP8mvt3dinNEbG6ey5OHPR7KCnJ9pXfWjqFLAf/Mej7ITz6e2BmcKBGnpolOI2yhZUtXRFrs8FV+lYtFCdJ383ujs=
Message-ID: <787b0d920607161222o55cd8837g6545bfd00e50d452@mail.gmail.com>
Date: Sun, 16 Jul 2006 15:22:01 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Albert Cahalan" <acahalan@gmail.com>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, dwmw2@infradead.org,
       arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.18 Headers - Long
In-Reply-To: <20060716185314.GA17172@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
	 <6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
	 <787b0d920607161138l4b6dc25dycaeaaea5e948c769@mail.gmail.com>
	 <20060716185314.GA17172@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Sun, Jul 16, 2006 at 02:38:45PM -0400, Albert Cahalan wrote:
> > On 7/16/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > >On Jul 15, 2006, at 17:09:28, Albert Cahalan wrote:
> >
> > >You realize that on a couple architectures it's fundamentally
> > >impossible to get atomic ops completely in userspace, right?
> >
> > Sure. Those architectures don't need to drag down the rest.
> > Plenty of headers are only exported for some architectures.
>
> Wrong perspective.  The problem is that they may _appear_ to work as
> described, but not actually work in the intended way.  That's a bug,
> and it's a _hard_ bug to locate.

Again:

Plenty of headers are only exported for some architectures.

In other words, for all architectures where things work.

> > (Well actually, such architectures could just give apps a
> > writable flag to disable the scheduler -- this is acceptable
> > for the embedded things these architectures are used for.
>
> Cloud cuckoo land.  In the embedded world, there are folk still want
> to have the security aspects as well.  Moreover, there are far more
> folk who do _NOT_ want to have things like "disable the scheduler" -
> think the realtime folk.

Now you are really wrong. :-)

The Linux system I saw using this hack was carefully tuned
for hard real-time performance. Latency was a few dozen
microseconds. Disabling the scheduler essentially put you
at the highest SCHED_FIFO; aside from that there was
working priority inheritance for both kernel and user code.
The real-time folk love this kind of thing.

Anyway, it's fine to just not let ARM export the header.

> > It's not as if the app developers would care to support
> > those architectures anyway.
>
> That's actually more of a reason to take away the toys they shouldn't
> be playing with in the first place - the only reason these (wrong)
> interfaces are being used is because they're easily accessible.

No. The normal interfaces are dreadful.

App developers will just cut-and-paste the i386 kernel
code if you take away the header files. They do that
often enough already. So all you succeed in doing is
eliminating any hope of portability to ppc and similar.
This is not an improvement.
