Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUG2WvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUG2WvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUG2WtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:49:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44190 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267490AbUG2Wrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:47:46 -0400
Date: Fri, 30 Jul 2004 00:44:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040729224409.GA11208@elte.hu>
References: <20040727225040.GA4370@yoda.timesys> <20040728062722.GA15283@elte.hu> <20040728212314.GB7167@nietzsche.lynx.com> <20040728213557.GD6685@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728213557.GD6685@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> On Wed, Jul 28, 2004 at 02:23:14PM -0700, Bill Huey wrote:
> > That way I picture the problem permits those threads to migration across
> > CPUs and therefore kill interrupt performance from cache thrashing. Do
> > you have a solution for that ? I like the way you're doing it now with
> > irqd() in that it's CPU-local, but as you know it's not priority sensitive.
> 
> Wouldn't the IRQ threads be subject to the same heuristics that the
> scheduler uses with ordinary threads, in order to avoid unnecessary
> CPU migration?  Plus, IRQs ordinarily get distributed across CPUs, and
> in most cases shouldn't have a very large cache footprint (especially
> data; the code can be in multiple CPU caches at once), so I don't
> think this is a susbtantial degradation from the way things already
> are.
> 
> If desired by the user, an IRQ thread could be bound to a specific CPU
> to avoid such problems (in which case, they'd probably want to set the
> smp_affinity of the hard IRQ stub to the same CPU).

i fixed this problem in -M5 the other way around: the IRQ threads follow
the affinity settings. They will bind themselves to the first CPU in the
affinity mask and they migrate only at 'safe' points (between hardirqs).

this way e.g. user-space irqbalance will automatically move the IRQ
threads around too.

	Ingo
