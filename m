Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbUBCLPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 06:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUBCLPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 06:15:39 -0500
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:11138 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265979AbUBCLPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 06:15:37 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Date: Tue, 3 Feb 2004 22:14:49 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
References: <200401291917.42087.kernel@kolivas.org> <200402032207.38006.kernel@kolivas.org> <20040203111236.GA8508@elte.hu>
In-Reply-To: <20040203111236.GA8508@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402032214.49229.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004 22:12, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > > for lowprio tasks they are of little use, unless you modify gcc to
> > > sprinkle mwait yields all around the 'lowprio code' - not very
> > > practical i think.
> >
> > Yuck!
> >
> > Looks like the kernel is the only thing likely to be smart enough to
> > do this correctly for some time yet.
>
> no, there's no way for the kernel to do this 'correctly', without
> further hardware help. mwait is suspending the current virtual CPU a bit
> better than rep-nop did. This can be exploited for the idle loop because
> the idle loop does nothing so it can execute the rep-nop. (mwait can
> likely also be used for spinlocks but that is another issue.)
>
> user-space code that is 'low-prio' cannot be slowed down via mwait,
> without interleaving user-space instructions with mwait (or with
> rep-nop).
>
> this is a problem area that is not solved by mwait - giving priority to
> virtual CPUs should be offered by CPUs, once the number of logical cores
> increases significantly - if the interaction between those cores is
> significant. (there are SMT designs where this isnt an issue.)

Actually I was trying to say something like my patch, but done correctly. I 
agree with new instructions not helping at the moment.

Con
