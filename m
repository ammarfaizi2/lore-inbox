Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUB2CJd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 21:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUB2CJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 21:09:33 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:59623 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261965AbUB2CJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 21:09:31 -0500
Subject: Re: [patch] new version, u64 cast avoidance
From: Albert Cahalan <albert@users.sf.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Jakub Jelinek <jakub@redhat.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <1078016927.904.17.camel@gaston>
References: <1077915522.2255.28.camel@cube>
	 <16447.56941.774257.925722@napali.hpl.hp.com>
	 <1077920213.2233.44.camel@cube>
	 <20040228104252.GG31589@devserv.devel.redhat.com>
	 <1077979564.2233.70.camel@cube>  <1078012722.905.11.camel@gaston>
	 <1078012762.905.13.camel@gaston>  <1078006870.2233.94.camel@cube>
	 <1078016927.904.17.camel@gaston>
Content-Type: text/plain
Organization: 
Message-Id: <1078012163.2232.136.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Feb 2004 18:49:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 20:08, Benjamin Herrenschmidt wrote:
> > a. my solution, as given
> > b. move u64 and friends to include/linux/*.h
> > c. you promise to never complain about warnings
> > d. printk("Ugly: " U64_FMT "\n", some_u64_value);
> > e. you patch gcc to modify format strings :-)
> > f. ...
> > 
> > In other words, how do you propose to eliminate
> > the casts?
> 
> Can't we live with those casts at least for a while ?
>
> I don't know honestly what is the best solution,
> they all sound equally ugly to me.

They are, until you count the number of occurances.
My solution, as given, puts #if crud in just 6 files.
The existing situation has crud all over the place,
growing day by day.

If there is some patch merging issue, I'd be happy
to send you a separate patch for ppc64.

If you'd prefer, I can create <linux/bit_types.h>
for these types and pull that in. For now it would
be included by all the asm-*/types.h files. Like so:

#if defined(_BROKEN_USER_TYPES) && !defined(__KERNEL__)
typedef unsigned long __u64;
typedef __signed__ long __s64;
#else
#if defined(__GNUC__)
__extension__ typedef unsigned long long __u64;
__extension__ typedef __signed__ long long __s64;
endif
#endif
/* ... */


