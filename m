Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSG3HrR>; Tue, 30 Jul 2002 03:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSG3HrR>; Tue, 30 Jul 2002 03:47:17 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:46068 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315218AbSG3HrP>; Tue, 30 Jul 2002 03:47:15 -0400
Message-Id: <5.1.0.14.2.20020730004204.00a48da0@mail.attbi.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 30 Jul 2002 00:50:32 -0700
To: Ed Vance <EdV@macrolink.com>, "'rwhite@pobox.com'" <rwhite@pobox.com>
From: Robert White <rwhite@pobox.com>
Subject: RE: n_tty.c driver patch (semantic and performance correction)
  (a ll recent versions)
Cc: Russell King <rmk@arm.linux.org.uk>, "'Theodore Tso'" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       Andries Brouwer <aebr@win.tue.nl>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A790E@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, this is an example of "precaching" and was the example I said I have 
seen.  Since there is no USE of the precached data during the read, the 
there wasn't any demonstrable purpose to the action.

That is, this is NOT CODE "IN THE WILD", it is the contrived example of 
use, it doesn't meet the requested requirement that the example be "harmed" 
by the patch as there is no actual algorithm attached.

Any code that did this would then read this data out of the buffer by 
another request after resetting VMIN which *IS* a dependence on "magic 
state" since the current read is blocking on state that cannot be returned 
to the user.

Note that the author of the linked message says "having said that, I don't 
know of any instances where the above is employed." and then agrees the 
patch is worthwhile...

So it doesn't fulfill my request/requirement, the cited author explicitly 
supports my position, and there isn't any implication of how the rest of 
the supposed program might use this magic state...

hmmm....

Not the best argument Ed.

Rob.

At 14:46 7/29/2002 -0700, Ed Vance wrote:
>On Sat, July 27, 2002 at 7:36 PM, Robert White wrote:
> >
> > And if you could show me ONE example of wild code that would be
> > harmed by the mod I would shut up and go away.
> >
> > (I say wild code, but even contrived code would be interesting.)
>
> From the archive ...
>http://marc.theaimsgroup.com/?l=linux-kernel&m=102440556723250&w=2

----------------------------------------------------------------------
-- Rob White         --  Consider: for all vectors v, Cv - Cv = 0   --
-- rwhite@pobox.com  --    general relativity is thus disproved.    --
----------------------------------------------------------------------
-- There once was a man who claimed nothing was true,               --
--   he was later, of course, found to be lying.                    --
----------------------------------------------------------------------
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

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
=Zx5A
-----END PGP PUBLIC KEY BLOCK-----

