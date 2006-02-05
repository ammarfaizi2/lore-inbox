Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWBEBpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWBEBpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 20:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWBEBpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 20:45:44 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:47344 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932529AbWBEBpn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 20:45:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J7VwQ/3FC2xdmq4oT0FGWhOxb8oUSj/yJKKQOw5zg7+zJ5gmhem3od87pGeHg/UWgl60tQWKjRNug/PajI/HVKBwNqrI4XJ3imG3jPtDO/rMJ75zRZBwtB/ZK9Hdzc4VB1Boa2ZvHd4F3FMzwmXsZBn1u+Gq3Mngn20ea9WTO/8=
Message-ID: <787b0d920602041745k65504414taaaef7f6d75b364c@mail.gmail.com>
Date: Sat, 4 Feb 2006 20:45:42 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: athlon 64 dual core tsc out of sync
Cc: linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, safemode@comcast.net
In-Reply-To: <1139101243.2791.78.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>
	 <1139101243.2791.78.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sat, 2006-02-04 at 15:24 -0500, Albert Cahalan wrote:
> > There have been far too many other problems with i386 timekeeping as
> > well.  Really, it's crazy to not use the pmtmr if the pmtmr is
> > available. The next best choice would be HPET. After that, pre-SMM
> > systems should count clock ticks and post-SMM systems should read the
> > RTC or PIT registers. Until we accept this, we'll always be suffering
> > clock problems.
>
> Well, I wouldn't say it's crazy - the TSC is several orders of magnitude
> cheaper than the PM timer, and the only common hardware where it's
> completely useless are Athlon X2 systems.

"the only"???

You clearly haven't been paying attention. Lots of computers vary the
clock rate. They do this several ways.

There may be sudden long-term changes, as when a laptop is unplugged.
The OS will not be told; there will just be timing errors.

Transitions may be gradual. The Opteron documentation describes a
procedure that involves stepping voltage and frequency, bit by bit,
waiting at each stage for the frequency to stabilize.

There is often a sawtooth wave wobble, added to spread the spectrum
of RF emmisions.

Clock ticks get lost all the time. The BIOS may decide do grab the
CPU in SMM (system management mode) for many milliseconds at a time.

It's cool to have a faster way to do things, but not if that way is
typically defective and enabled by default. The default should just
work, no "if"s "and"s or "but"s about it.
