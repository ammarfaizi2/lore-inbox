Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbTJQLtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263404AbTJQLtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:49:49 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:57728 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263403AbTJQLtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:49:47 -0400
Date: Fri, 17 Oct 2003 12:51:13 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310171151.h9HBpDoJ000810@81-2-122-30.bradfords.org.uk>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>,
       "Hans Reiser" <reiser@namesys.com>,
       "Wes Janzen" <superchkn@sbcglobal.net>,
       "Rogier Wolff" <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
 <20031014064925.GA12342@bitwizard.nl>
 <3F8BA037.9000705@sbcglobal.net>
 <3F8BBC08.6030901@namesys.com>
 <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
 <3F8FBADE.7020107@namesys.com>
 <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, consider the two extremes we've seen in this thread now.  Mr. Bradford
> felt that the entire drive should be discarded on account of having one bad
> block.

Please don't spread blatently mis-leading information.

My position on this is that if a drive is _persistantly_ unable to
_write_ to any LBA address, it should be binned.  Read errors are a
separate concern.  If they occur, the drive should simply return an
error.  The OS needs to do _NOTHING_.  No special re-writing to force
a re-allocation should be done - we assume the drive is going to do
that, and if it doesn't:

1. DRIVE -> BIN

2. Restore backup.

> Mr. Machek feels that we should preserve the possibility of reusing
> the bad block because in the future it might appear not to be bad.  I take
> the middle road.  The drive should not be discarded until errors become more
> frequent or numerous, but known bad blocks should be acted on so that those
> physical blocks should not have a chance of being used again.

You may consider that a responsible attitude towards people who are
paying for consultancy, and value their data at more than the physical
cost of the disk, but I do not.

> Suppose the block became readable when the temperature drops (this one
> didn't but I believe some can).  What happens when the block becomes
> readable, and then a program writes new data to that block, and the block
> temporarily appears good?  At that time it will get written and will not get
> reallocated, right?  And a few milliseconds later, what?  I do not want that
> block reused.  I want it reallocated.

1. Monitor drive.

2. Out of spec temperature?  If yes, remount R/O and page an operator.

3. Go to 1

> And when a drive doesn't guarantee reallocation, I want the driver to remove
> the sector from the file system.

Such drives are no better in this regard than ST-506 drives in my
opinion.  I have almost always started discussions with a phrase such
as, "assuming we are talking about modern drives that do their own
defect management".

John.
