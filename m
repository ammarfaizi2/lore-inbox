Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262135AbSJAQXR>; Tue, 1 Oct 2002 12:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262134AbSJAQXR>; Tue, 1 Oct 2002 12:23:17 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27782 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262135AbSJAQXK>;
	Tue, 1 Oct 2002 12:23:10 -0400
Date: Tue, 1 Oct 2002 17:31:21 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "David L. DeGeorge" <dld@degeorge.org>, linux-kernel@vger.kernel.org
Subject: Re: CPU/cache detection wrong
Message-ID: <20021001163121.GA5565@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"David L. DeGeorge" <dld@degeorge.org>,
	linux-kernel@vger.kernel.org
References: <20021001151525.GA32467@suse.de> <Pine.GSO.3.96.1021001171405.13606L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021001171405.13606L-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 06:03:03PM +0200, Maciej W. Rozycki wrote:

 > > >  Strange -- why not to default to 256K and override it with the value
 > > > obtained from a cache descriptor if != 0, then?
 > > Because the cache descriptor IS zero. So we default to 256K.
 >  You wrote "some of", so I suppose others are OK.

Yes, one stepping only afaik. Though the test in the kernel checks
for 6.11,x with l2==0 just to be sure.
 
 > I meant those others. 
 > Anyway -- is it a new problem?  I can't see it documented in the current
 > P3 spec update.  That's weird -- Intel might hesitate documenting
 > weirdnesses of their chips, however they tend to include such simple and
 > obvious errata in the update.
 > 
 >  The spec actually states the L2 descriptor for the P3 may be as follows:
 > 
 > - 0x43 -- 512kB, unified,
 > - 0x82 -- 256kB, 8-way set associative,
 > - 0x83 -- 512kB, 8-way set associative.
 > 
 > The last descriptor is omitted from the list of known types in cache_table
 > in 2.4.20-pre8 -- could it be the culprit? 

 Added in last nights patch. IIRC, the errata meant there was no
 descriptor at all iirc.
 TBH, I can't recall which document I read about this in, as it was a few
 months back now. I'll look through old mails when I get chance and see if
 I can get to the bottom of it.
 It's possible that this was reported to me, and it is the case you
 describe (missing descriptor), but the old code should have picked
 apart the descriptors in a different way to the new table-lookup,
 so that *should* have worked ok if the descriptor was correct.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
