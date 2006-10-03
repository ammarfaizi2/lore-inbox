Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWJCQbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWJCQbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWJCQbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:31:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750921AbWJCQbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:31:21 -0400
Date: Tue, 3 Oct 2006 09:27:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: "John W. Linville" <linville@tuxdriver.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <1159890876.20801.65.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> 
 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> 
 <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com>
 <1159890876.20801.65.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2006, Lee Revell wrote:
> > 
> > We have sucked, and we continue to suck -- and we are working on it.
> > But, we are not going to be able to whip-up this omelette without
> > breaking a few eggs.  If we can't do that during the merge windows,
> > WHEN CAN WE DO IT?
> 
> This is a question for Linus, it's his rule...

In general, the answer to "when can we break user space" is very simple.

Never.

It's just not acceptable. We maintain old interfaces for years (and in 
some cases, well over a decade by now), simply because the pain from not 
doing so is horrendous, and it makes debugging impossible. You get into 
situations where users need to upgrade to tools that don't work with older 
kernels, and can thus not downgrade, etc etc.

That said, system tools have been given some dispensation. Not a lot, and 
sometimes they take more liberties than they are given - udev in 
particular had too many problems, and some people who maintained it seemed 
to think that they had the "right" to break things as much as they did. I 
think that got cleared up, but the point is: system tools sometimes cannot 
avoid some issues, but damn it, breaking them "just because it fixes 
things" is NOT ACCEPTABLE.

So even if it's a case of "..but it fixes a problem", that in itself is 
not a valid reason for breaking a tool that used to work. It really _has_ 
to be: "It fixes a serious problem, and we tried hard as _hell_ to avoid 
any breakage at all, and it wasn't possible, but this is a one-time 
event".

Quite frankly, the parts of the discussion I have seen does not at all 
imply to me that people tried as hard as possible. For example, I saw Jean 
say that "The wireless tools themselves told about the version mismatch", 
as if that had ANY RELEVANCE AT ALL!

If the kernel knows about the version number, it should make sure that the 
interfaces are honored. Yes, it often means some ugly code at the 
interface layer, but dammit, that's the job of the kernel. It's the whole 
reason why we have some of the abstraction layers we do in the kernel. The 
original reason the readdir() function got a "filldir_t" callback was 
simply the fact that we needed to support two different formats for it. 
The reason we have the whole internal "struct kstat" is exactly the same.

We don't do this version skew dance. If we need to break something, it had 
better be some damn substantial reasons, and even then we're generally 
better off supporting _both_ interfaces for a while (perhaps using a 
version code), and then marking the old one deprecated.

Ugly? Yes, often. But _users_ do matter more. Really.

		Linus
