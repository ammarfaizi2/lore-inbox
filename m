Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbTCLQLA>; Wed, 12 Mar 2003 11:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbTCLQLA>; Wed, 12 Mar 2003 11:11:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3332 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261783AbTCLQK6>; Wed, 12 Mar 2003 11:10:58 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 3/3] add Via Nehemiah ("xstore") rng support
Date: 12 Mar 2003 08:21:26 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4nmq6$3et$1@cesium.transmeta.com>
References: <20030312125542.GA4284@suse.de> <Pine.LNX.4.44.0303120714030.13807-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0303120714030.13807-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
>
> 
> On Wed, 12 Mar 2003, Dave Jones wrote:
> >  
> >  > +#define cpu_has_xstore		boot_cpu_has(X86_FEATURE_XSTORE)
> >  
> > Do we want to do this check only on VIA CPUs I wonder.
> > As a vendor specific extension, I'd be inclined to do that.
> 
> No, the whole point of all the crud in arch/i386/kernel/cpu is to make 
> those tests _once_ at bootup, and then the internal kernel "extended CPU 
> feature set" has a unique feature-set that is independent of manufacturers 
> and totally disjunct, so that we never need to care about manufacturers 
> ever again.
> 

Right.  I have also pointed out to Jeff already that the test is done
wrong... it's pretty clear from the code that VIA has set up a feature
flag space of their own like Intel, AMD and Transmeta already have
(which is a good thing), so we should add that as an additional word
in the feature test vector instead of special-casing such a bit.

In fact, we need to add two words since Intel ran out of theirs and
started using additional flags in %ecx just recently.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
