Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUH2VYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUH2VYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUH2VYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:24:12 -0400
Received: from holomorphy.com ([207.189.100.168]:38576 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268316AbUH2VX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:23:58 -0400
Date: Sun, 29 Aug 2004 14:23:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040829212350.GX5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <20040829184114.GS5492@holomorphy.com> <20040829192617.GB24937@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829192617.GB24937@apps.cwi.nl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 11:41:14AM -0700, William Lee Irwin III wrote:
>> I guess I might as well write a diffprof(1) too.

On Sun, Aug 29, 2004 at 09:26:17PM +0200, Andries Brouwer wrote:
> Thanks!
> <mutter>
> Is it really necessary to tell Alessandro Rubini, Stephane Eranian,
> Andrew Morton, Werner Almesberger, John Levon, Nikita Danilov
> that their work makes you vomit?
> Many kernel people have such unpleasant habits.
> It fully suffices to say that you considered the original code
> too ugly to fix.
> </mutter>

It probably qualifies as impolite. I suppose a better way of going
about this would be saying that the code has accumulated some cruft,
and then describing the differences in greater detail.

The removal of the multiplier resetting is an oversight; I rarely
use the feature myself, but upon closer examination, the multiplier
accepted by write_profile() is not ASCII. I also question the role of a
profile report extraction utility in alterations of profiling state.

The removal of the reset feature is once again intentional as this
can be done by echo > /proc/profile.

The removal of the individual bin count reporting is intentional, but
not a very nice removal, as it's a useful feature and definitely not a
misfeature. The format of the histogram reporting is, however, not very
useful as sort(1) etc. don't easily interoperate with it. This should
be put back for serious use.

The removal of accepting compressed files is once again intentional,
and replaced with the new feature of accepting '-' as an argument for
the files operated on so that decompression to pipes may replace it.

The removal of the stepsize reporting was intentional, but again not
a nice removal.

The removal of reporting zero hit count symbols was intentional, but
again not nice.

The removal of verbose reporting with text addresses in addition to the
symbol was intentional, but again not nice.

The removal of -V was intentional, as I consider it bloat.

The removal of the normalized load from the reporting was very
intentional, as it's pure gibberish.

The difference I cared the most about was algorithmic. A giant memcpy()
of the profile buffer and making multiple passes over it is ridiculous.
This was recoded as maintaining a buffer large enough to hold the
length of the profile buffer spanning symbol currently being examined.
In this way the memory resources required for it to operate are
drastically reduced from multiple megabytes to just a few pages.


On Sun, Aug 29, 2004 at 09:26:17PM +0200, Andries Brouwer wrote:
> <util-linux maintainer>
> Your code still requires some polishing. No localized messages, etc.

I tend to avoid locale bits due to system resource and library
dependency concerns. I usually try to avoid using (g)libc for similar
reasons also by making syscalls directly, static linking and so on,
but expected that would not go over well.


On Sun, Aug 29, 2004 at 09:26:17PM +0200, Andries Brouwer wrote:
> And next, you removed some features, but do not indicate what
> replacement you see.
> For example, Andrew added the -M option that sets a frequency.
> Are you going to contribute a write_profile too?
> Or do you think nobody should wish to set a frequency?
> </util-linux maintainer>

I wasn't really expecting much to come of it besides prodding people
to clean up bloat. The reduced functionality alone likely precludes it
from consideration for inclusion. Supposing that there is greater
interest, which I don't expect, I can fix these things up and so on.


-- wli
