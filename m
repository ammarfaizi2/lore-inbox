Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWHTARN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWHTARN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 20:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWHTARN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 20:17:13 -0400
Received: from 1wt.eu ([62.212.114.60]:38416 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751596AbWHTARM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 20:17:12 -0400
Date: Sun, 20 Aug 2006 02:16:37 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce CONFIG_BINFMT_ELF_AOUT
Message-ID: <20060820001637.GC27115@1wt.eu>
References: <20060819232556.GA16617@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819232556.GA16617@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 03:25:56AM +0400, Solar Designer wrote:
> Willy,
> 
> I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> into 2.4.34-pre.  (2.6 kernels could benefit from the same change, too.)
> 
> The patch adds a new compile-time option to control the support for
> "ELF binaries with a.out format interpreters or a.out libraries".
> Without this patch, such support is enabled on every system that enables
> the support for ELF binaries - although 99% (100%?) of systems don't
> need this hybrid functionality.

I remember having used this patch in a not-so-distant past without any
side effect. Also, 2.4 now mostly runs on servers with a well known
userland, so I believe that being able to disable ELF_AOUT may serve
some users who either want to harden their system or simply reduce its
footprint.

> Moreover, this functionality poses a
> security risk - as proven in practice:
> 
> 	http://www.isec.pl/vulnerabilities/isec-0021-uselib.txt
> 
> This uselib() vulnerability did not affect default kernel builds with
> the -ow patch specifically due to separation of the unneeded/risky code
> into CONFIG_BINFMT_ELF_AOUT and having this option disabled by default.
> (Yes, this change in -ow patches pre-dates the discovery of the uselib()
> vulnerability.)

I remember about it (the vuln), I even used it as a PoC.

> The patch also changes CONFIG_BINFMT_AOUT to be disabled by default on
> archs that had it default to enabled.

However, I don't agree with this part in mainline. While I'm happy to
let the user disable useless/dangerous/untested features, there are
people who build kernels by appending just a few lines to default configs.
I don't want to change their default settings without them noticing this,
even if there's virtually no risk of breaking anything. Same goes for
BINFMT_MISC which got disabled by default in your patch.

A general thumb rule is to allow people to hold the 'Enter' key pressed
during make oldconfig and get identical features as before. This is really
important to maintain the rate of wrong bug reports very low.

> The a.out support is similarly risky and not audited/hardened with the
> same scrutiny that the ELF support has received.

I know and agree with you on this matter. Most people compiling 2.4 for
servers right now most probably do not enable support for a.out already.

So to resume, what I can propose you is :
  - you split the defconfig changes from the rest and let them in a
    state compatible with 2.4.33 features, which even implies setting
    CONFIG_BINFMT_ELF_AOUT to 'y', even if this sounds gross to you.
  - I merge the changes to support the new option
  - you just have to maintain the patch for the defconfig files in owl.

I can also do the split myself if you don't have time, but this work
will get less priority then (since my time is finite too).

Also, you spoke about 2.6. I would like that you keep a list of the
patches from your tree that get merged into 2.4 and which should be
proposed to 2.6. Maybe you'll only propose them when you work on 2.6-owl,
but I would like to ensure that those enhancements don't get lost once
they are in 2.4 mainline.

> Thanks,
> 
> Alexander

Thanks,
Willy

