Return-Path: <linux-kernel-owner+w=401wt.eu-S932643AbWLMJyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWLMJyJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWLMJyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:54:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39652 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932643AbWLMJyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:54:07 -0500
Date: Wed, 13 Dec 2006 10:51:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HZ free ntp
Message-ID: <20061213095132.GA22280@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612060348150.1868@scrub.home> <20061205203013.7073cb38.akpm@osdl.org> <1165393929.24604.222.camel@localhost.localdomain> <Pine.LNX.4.64.0612061334230.1867@scrub.home> <20061206131155.GA8558@elte.hu> <Pine.LNX.4.64.0612061422190.1867@scrub.home> <1165956021.20229.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165956021.20229.10.camel@localhost>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> On Wed, 2006-12-06 at 15:33 +0100, Roman Zippel wrote:
> > On Wed, 6 Dec 2006, Ingo Molnar wrote:
> > > i disagree with you and it's pretty low-impact anyway. There's still
> > > quite many HZ/tick assumptions all around the time code (NTP being one
> > > example), we'll deal with those via other patches.
> > 
> > Why do you pick on the NTP code? That's actually one of the places where
> > assumptions about HZ are largely gone. NTP state is updated incrementally
> > and this won't change, but the update frequency can now be easily
> > disconnected from HZ.
> 
> Hey Roman,
> 	Here's my rough first attempt at doing so. I'd not call it easy, but
> maybe you have some suggestions for a simpler way?
> 
> Basically INTERVAL_LENGTH_NSEC defines the NTP interval length that 
> the time code will use to accumulate with. In this patch I've pushed 
> it out to a full second, but it could be set via config 
> (NSEC_PER_SEC/HZ for regular systems, something larger for systems 
> using dynticks).

cool! I'll give this one a go in -rt, combined with the exponential 
second-overflow patch. (that one is now algorithmically safe, right?)

	Ingo
