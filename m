Return-Path: <linux-kernel-owner+w=401wt.eu-S965059AbWLMStA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWLMStA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWLMStA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:49:00 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:44840 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965059AbWLMSs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:48:59 -0500
Subject: Re: [RFC] HZ free ntp
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061213095132.GA22280@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <Pine.LNX.4.64.0612060348150.1868@scrub.home>
	 <20061205203013.7073cb38.akpm@osdl.org>
	 <1165393929.24604.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612061334230.1867@scrub.home>
	 <20061206131155.GA8558@elte.hu>
	 <Pine.LNX.4.64.0612061422190.1867@scrub.home>
	 <1165956021.20229.10.camel@localhost>  <20061213095132.GA22280@elte.hu>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 10:48:46 -0800
Message-Id: <1166035726.6425.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 10:51 +0100, Ingo Molnar wrote:
> * john stultz <johnstul@us.ibm.com> wrote:
> 
> > On Wed, 2006-12-06 at 15:33 +0100, Roman Zippel wrote:
> > > On Wed, 6 Dec 2006, Ingo Molnar wrote:
> > > > i disagree with you and it's pretty low-impact anyway. There's still
> > > > quite many HZ/tick assumptions all around the time code (NTP being one
> > > > example), we'll deal with those via other patches.
> > >
> > > Why do you pick on the NTP code? That's actually one of the places where
> > > assumptions about HZ are largely gone. NTP state is updated incrementally
> > > and this won't change, but the update frequency can now be easily
> > > disconnected from HZ.
> >
> > Hey Roman,
> > 	Here's my rough first attempt at doing so. I'd not call it easy, but
> > maybe you have some suggestions for a simpler way?
> >
> > Basically INTERVAL_LENGTH_NSEC defines the NTP interval length that
> > the time code will use to accumulate with. In this patch I've pushed
> > it out to a full second, but it could be set via config
> > (NSEC_PER_SEC/HZ for regular systems, something larger for systems
> > using dynticks).
> 
> cool! I'll give this one a go in -rt, combined with the exponential
> second-overflow patch. (that one is now algorithmically safe, right?)

No, this one will replace the exponential accumulation patch. So we'll
accumulate on second intervals, which should be far enough apart that we
won't be spinning in that loop for long.

thanks
-john


