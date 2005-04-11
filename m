Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVDKPa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVDKPa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVDKPa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:30:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:19944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261804AbVDKPar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:30:47 -0400
Date: Mon, 11 Apr 2005 08:32:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Jackson <pj@engr.sgi.com>, pasky@ucw.cz, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
In-Reply-To: <20050411151204.GA5562@elte.hu>
Message-ID: <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu>
 <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Ingo Molnar wrote:
> 
> to construct the combo blob later on, we do have to unpack sched.c (and 
> if it's already a combo-blob that is not cached then we'd have to unpack 
> all parents until we arrive at some full blob).

I really don't want to have this. Having chains of dependencies is really 
painful, and now if _any_ of them gets corrupted, you're screwed.

Yes, GIT already has chains, but they are the minimal possible (ie we have
the path-name-dependent tree chain, which I tried to avoid but really
couldn't). The "commit" chain can grow to arbitrary sizes, but losing any
entry but the top one really doesn't lose any data - you lost your place
in history, but at least you're not totally screwed. You still have your
data, you just can't find your way to the root (but you can, for example,
effectively re-create the whole commit chain if you want to without having
to touch any of the data blobs).

So I would very strongly suggest that we do not have dependent combo
blobs, but that if you want to, a better "network protocol" might be quite
possible. Ie send diffs over the network, and re-create the blobs on the
other side.  You can trivially check that you got it right, because if you
didn't, the name of the result won't match ;)

Please?

			Linus
