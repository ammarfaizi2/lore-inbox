Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWEFSQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWEFSQV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWEFSQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 14:16:21 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:58477 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751062AbWEFSQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 14:16:20 -0400
From: David Brownell <david-b@pacbell.net>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 8/14] random: Remove SA_SAMPLE_RANDOM from USB gadget drivers
Date: Sat, 6 May 2006 11:16:16 -0700
User-Agent: KMail/1.7.1
Cc: Denis Vlasenko <vda@ilport.com.ua>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <9.420169009@selenic.com> <200605061407.02737.vda@ilport.com.ua>
In-Reply-To: <200605061407.02737.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605061116.18274.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 May 2006 4:07 am, Denis Vlasenko wrote:
> On Friday 05 May 2006 19:42, Matt Mackall wrote:
> > Remove SA_SAMPLE_RANDOM from USB gadget drivers

It's conventional to post USB patches to linux-usb-devel, or at least
to CC that list.


> > There's no a priori reason to think that USB device interrupts will
> > contain "entropy" as defined/required by /dev/random. In fact, most
> > operations will be streaming and bandwidth- or CPU-limited.
> > /dev/random needs unpredictable inputs such as human interaction or
> > chaotic physical processes like turbulence manifested in disk seek
> > times.

And that'd be why you removed that SAMPLE_RANDOM from the Lubbock VBUS
irqs ... which come from users connecting (by hand!) a USB cable.  :)

You shouldn't add spaces before labels, or change indents from
pure-tab to tabs-plus-four-spaces.

Admittedly OMAP _now_ has access to the FIPS-certified hardware RNG,
so for that platform it's hard to justify needing other entropy sources.
But on the other hand, DMA completion IRQs aren't exactly predictable
either, and it doesn't necessarily hurt to salt a high entropy pool
with some less-high entropy inputs.



> Come on, let's get real. A few low bits of TSC are random enough
> (for just about any interrupt source).
> 
> Attackers will probably look for easier ways to hack your crypto
> than predicting /dev/random.

I'm not sure I'd go that far.  But I'd agree that this particular
patch should not be merged.

Reasonable people could have arguments about the quality of a given
entropy source ... and the SA_SAMPLE_RANDOM mechanism has no way to
indicate that quality, thereby wrongly implying that all interrupts
have the same entropy contribution.  A few Kbytes/second is very
different from a few bits per hour.

But I disagree with the blanket assertion that only high quality
crypto-ready RNG sources should ever be provided ... and that lower
quality sources are useless.  Sure it helps if attackers need extra
hours to make the attack, but extra minutes help too.

- Dave

