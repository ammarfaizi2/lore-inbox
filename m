Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVIEIph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVIEIph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVIEIph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:45:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932368AbVIEIpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:45:35 -0400
Date: Mon, 5 Sep 2005 01:45:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Michael Ellerman <michael@ellerman.id.au>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
In-Reply-To: <200509050949.38842@bilbo.math.uni-mannheim.de>
Message-ID: <Pine.LNX.4.58.0509050117310.5316@evo.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
 <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org> <200508301007.11554@bilbo.math.uni-mannheim.de>
 <200509050949.38842@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Sep 2005, Rolf Eike Beer wrote:
> 
> The problem appeared between 2.6.12-git3 and 2.6.12-git4.

Just for reference, that's git ID's

 1d345dac1f30af1cd9f3a1faa12f9f18f17f236e..2a5a68b840cbab31baab2d9b2e1e6de3b289ae1e

and that's 225 commits and the diff is 55,781 lines long.

It would be very good if you could try to use raw git and narrow it down a 
bit more. It's really easy these days with a recent git version, just do

	git bisect start
	git bisect good 1d345dac1f30af1cd9f3a1faa12f9f18f17f236e
	git bisect bad 2a5a68b840cbab31baab2d9b2e1e6de3b289ae1e

and off you go.. That will select a new kernel for you to try, which
basically cuts down the commits to ~110 - and if you can test just a few 
kernels and binary-search a bit more, we'd have it down to just a couple.

If you want to try work smarter (rather than a brute-force binary search 
thing), this command line:

  git-whatchanged -p \
	1d345dac1f30af1cd9f3a1faa12f9f18f17f236e..2a5a68b840cbab31baab2d9b2e1e6de3b289ae1e \
	drivers/video

will actually give you some very good information on what to try (I forget 
your exact original problem - I'm writing this from Italy, and I don't 
have my full email archives here. It was some MGA card that stopped 
working, no? Or was there something else?).

Anyway, git users really have a lot of nifty tools to help chase down bugs
like this. I used that "git bisect" thing twice myself last week. And the
"git-whatchanged" thing really is pretty flexible: as you can see, you can
limit it to both a range of commits and a certain subdirectory (or a _set_
of subdirectories and/or individual files - you can have as many pathname
limits as you want).

And that "-p" thing makes it show the whole diff for the thing (replace if
with a "-s" if you just want to see the descriptions and be silent about 
the actual diff).

All in my never-ending quest to make people more aware of how they can use 
git to pinpoint the source of kernel bugs.

		Linus
