Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSADJA6>; Fri, 4 Jan 2002 04:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288554AbSADJAt>; Fri, 4 Jan 2002 04:00:49 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:46587 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288442AbSADJAf>;
	Fri, 4 Jan 2002 04:00:35 -0500
Date: Fri, 4 Jan 2002 01:59:10 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020104015910.L12868@lynx.no>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <20020103150705.F25846@conectiva.com.br> <20020103123623.X12868@lynx.no> <E16MOQT-0001Az-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16MOQT-0001Az-00@starship.berlin>; from phillips@bonn-fries.net on Fri, Jan 04, 2002 at 08:05:56AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, for people that care, I did a quick survey of the changes I made.  My
idea is to conform to what is the current "standard" coding style, and not
necessarily what was thrown into Lindent, so that running Lindent on sources
will change as little as is necessary to make it "standard".

I also checked the l-k archives a bit to confirm the changes match the
formatting of the examples given by the King Penguin.

Sadly, lksr is not responding, so I can't look at the history of changes
to Lindent.  Is there another kernel CVS with CVSWeb that was as complete
as lksr?

On Jan 04, 2002  08:05 +0100, Daniel Phillips wrote:
> On January 3, 2002 08:36 pm, Andreas Dilger wrote:
> > I removed the following two options:
> > -bs: Put a space between sizeof and its argument.

grep -r "sizeof (" linux | wc -l,
grep -r "sizeof(" linux | wc -l:

sizeof (foo): 1611, sizeof(foo): 19364 => -bs should be removed

> > -psl: Put the type of a procedure on the line before its name.

grep -r -B2 "^{" linux | grep "^[^ ]*(" | wc -l,
grep -r -B2 "^{" linux | grep "^.* .*(" | wc -l:

int
foo(int x): 11408, int foo(int x): 57275 => -psl should be removed

> > I added the following options:
> > -nbbo: don't prefer to break lines before boolean operators

grep -r "[&|][&|][ ^I]*$" | wc -l,
grep -r "^[ ^I]*[&|][&|]" | wc -l:

	&& foo): 3338,
	(foo &&: 12003 => -nbbo should be added

> > -ci8: indent continuation lines 8 characters

Hard to measure.

> > -ncs: Do not put a space after cast operators.

grep -r "\*) [a-z_(]" . | wc -l,
grep -r "\*)[a-z_(]" . | wc -l:

(void *) foo: 11274, (void *)foo: 17062 => -ncs should be added

> Not putting a space after a cast is gross ;)

Well, it seems you are in the (slight) minority on this one.  It's not as
big a margin as the other ones, but still measurable.  I wasn't able to
find any examples from the King Penguin himself on this one.  Maybe that
means casts are evil and we should strive to rid the world of them? ;-)

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

