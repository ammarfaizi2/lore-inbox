Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311040AbSCLMzS>; Tue, 12 Mar 2002 07:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311024AbSCLMzI>; Tue, 12 Mar 2002 07:55:08 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:4136 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311023AbSCLMyt>; Tue, 12 Mar 2002 07:54:49 -0500
Date: Tue, 12 Mar 2002 13:56:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312135605.P25226@dualathlon.random>
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020312112900.A14628@holomorphy.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 11:29:00AM +0000, wli@holomorphy.com wrote:
> For specific reasons why multiplication by a magic constant (related to
> the golden ratio) should have particularly interesting scattering
> properties, Knuth cites Vera Turán Sós, Acta Math. Acad. Sci. Hung. 8

I know about the scattering properties of some number (that is been
measured empirically if I remeber well what I read). I was asking for
something else, I was asking if this magical number can scatter better a
random input as well or not. My answer is no. And I believe the nearest
you are to random input to the hashfn the less the mul can scatter
better than the input itself and it will just lose cache locality for
consecutive pages. So the nearest you are, the better if you avoid the
mul and you take full advantage of the randomness of the input, rather
than keeping assuming the input has pattenrs.

I mean, start reading from /dev/random and see how the distribution goes
with and without mul, it will be the same I think.

> I will either sort out the results I have on the waitqueues or rerun
> tests at my leisure.

I'm waiting for it, if you've monitor patches I can run something too.
I'd like to count the number of collisions over time in particular.

> Note I am only trying to help you avoid shooting yourself in the foot.

If I've rescheduling problems you're likely to have them too, I'm quite
sure, if something the fact I keep the hashtable large enough will make
me less bitten by the collisions. The only certain way to avoid riskying
regressions would be to backout the wait_table part that was merged in
mainline 19pre2. the page_zone thing cannot generate any regression for
instance (same is true for page_address), the wait_table part is gray
area instead, it's just an heuristic like all the hashes and you can
always have a corner case bitten hard, it's just that the probabiliy for
such a corner case to happen has to be small enough for it to be
acceptable, but you can always be unlucky, no matter if you mul or not,
you cannot predict the future of what's the next pages that the people
will wait on from userspace.

Andrea
