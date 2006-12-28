Return-Path: <linux-kernel-owner+w=401wt.eu-S1753124AbWL1Kt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbWL1Kt4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbWL1Ktz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:49:55 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4706 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbWL1Ktz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:49:55 -0500
Date: Thu, 28 Dec 2006 10:49:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       ranma@tdiedrich.de, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       andrei.popa@i-neo.ro, Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-ID: <20061228104923.GB20596@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Michlmayr <tbm@cyrius.com>,
	Gordon Farquharson <gordonfarquharson@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
	Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
	nickpiggin@yahoo.com.au, arjan@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com> <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org> <97a0a9ac0612272115g4cce1f08n3c3c8498a6076bd5@mail.gmail.com> <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org> <97a0a9ac0612272138o5348488ahfde03f9e22a71b5d@mail.gmail.com> <20061228101659.GB14626@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228101659.GB14626@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 11:16:59AM +0100, Martin Michlmayr wrote:
> * Gordon Farquharson <gordonfarquharson@gmail.com> [2006-12-27 22:38]:
> > >> #define TARGETSIZE (100 << 12)
> > >
> > >That's just 400kB!
> > >
> > >There's no way you should see corruption with that kind of value. It
> > >should all stay solidly in the cache.
> > >
> > >Is this perhaps with ARM nommu or something else strange? It may be that
> > >the program just doesn't work at all if mmap() is faked out with a malloc
> > >or similar.
> > 
> > Definitely a question for the ARM gurus. I'm out of my depth.
> 
> By the way, I just tried it with TARGETSIZE (100 << 12) on a different
> ARM machine (a Thecus N2100 based on an IOP32x chip with 128 MB of
> memory) and I see similar results to that from Gordon:

Work around the glibc memset() problem by passing nr & 255, and re-run
the test.  You're getting false positives.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
