Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbUB2D0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 22:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUB2D0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 22:26:40 -0500
Received: from waste.org ([209.173.204.2]:50410 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261971AbUB2D0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 22:26:38 -0500
Date: Sat, 28 Feb 2004 21:25:58 -0600
From: Matt Mackall <mpm@selenic.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jakub Jelinek <jakub@redhat.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: [patch] new version, u64 cast avoidance
Message-ID: <20040229032558.GS3883@waste.org>
References: <1077915522.2255.28.camel@cube> <16447.56941.774257.925722@napali.hpl.hp.com> <1077920213.2233.44.camel@cube> <20040228104252.GG31589@devserv.devel.redhat.com> <1077979564.2233.70.camel@cube> <1078012722.905.11.camel@gaston> <1078012762.905.13.camel@gaston> <1078006870.2233.94.camel@cube> <1078016927.904.17.camel@gaston> <1078012163.2232.136.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078012163.2232.136.camel@cube>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 06:49:23PM -0500, Albert Cahalan wrote:
> On Sat, 2004-02-28 at 20:08, Benjamin Herrenschmidt wrote:
> > > a. my solution, as given
> > > b. move u64 and friends to include/linux/*.h
> > > c. you promise to never complain about warnings
> > > d. printk("Ugly: " U64_FMT "\n", some_u64_value);
> > > e. you patch gcc to modify format strings :-)
> > > f. ...
> > > 
> > > In other words, how do you propose to eliminate
> > > the casts?
> > 
> > Can't we live with those casts at least for a while ?
> >
> > I don't know honestly what is the best solution,
> > they all sound equally ugly to me.
> 
> They are, until you count the number of occurances.
> My solution, as given, puts #if crud in just 6 files.
> The existing situation has crud all over the place,
> growing day by day.
> 
> If there is some patch merging issue, I'd be happy
> to send you a separate patch for ppc64.
> 
> If you'd prefer, I can create <linux/bit_types.h>
> for these types and pull that in. For now it would
> be included by all the asm-*/types.h files. Like so:
> 
> #if defined(_BROKEN_USER_TYPES) && !defined(__KERNEL__)
> typedef unsigned long __u64;
> typedef __signed__ long __s64;
> #else
> #if defined(__GNUC__)
> __extension__ typedef unsigned long long __u64;
> __extension__ typedef __signed__ long long __s64;
> endif
> #endif
> /* ... */

And if we can actually manage to eliminate the long-deprecated
inclusion of kernel headers by userspace in 2.7, we can kill that
conditional too.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
