Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUG2VNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUG2VNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUG2VKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:10:47 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:37649 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S265256AbUG2VI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:08:56 -0400
Date: Thu, 29 Jul 2004 14:08:30 -0700
To: Scott Wood <scott@timesys.com>
Cc: Bill Huey <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040729210830.GA12401@nietzsche.lynx.com>
References: <20040727225040.GA4370@yoda.timesys> <20040728062722.GA15283@elte.hu> <20040728212314.GB7167@nietzsche.lynx.com> <20040728213557.GD6685@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728213557.GD6685@yoda.timesys>
User-Agent: Mutt/1.5.6+20040722i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 05:35:57PM -0400, Scott Wood wrote:
> On Wed, Jul 28, 2004 at 02:23:14PM -0700, Bill Huey wrote:
> > That way I picture the problem permits those threads to migration across
> > CPUs and therefore kill interrupt performance from cache thrashing. Do
> > you have a solution for that ? I like the way you're doing it now with
> > irqd() in that it's CPU-local, but as you know it's not priority sensitive.
> 
> Wouldn't the IRQ threads be subject to the same heuristics that the
> scheduler uses with ordinary threads, in order to avoid unnecessary
> CPU migration?  Plus, IRQs ordinarily get distributed across CPUs,
> and in most cases shouldn't have a very large cache footprint
> (especially data; the code can be in multiple CPU caches at once), so
> I don't think this is a susbtantial degradation from the way things
> already are.

I get a number of gripes from SMP aware folks that the context switching
overhead is significant as well as cache issues. That's what the concern
is about.

> If desired by the user, an IRQ thread could be bound to a specific
> CPU to avoid such problems (in which case, they'd probably want to
> set the smp_affinity of the hard IRQ stub to the same CPU).

Yeah, this is an obvious next step in order to get better performance.
Do you have number showing how this logic effects overall SMP and interrupt
performance ?

I wish I could help with this, but I'm doing other things at the moment.

bill
