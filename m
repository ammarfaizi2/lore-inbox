Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTJSHzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 03:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTJSHzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 03:55:35 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22277
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262037AbTJSHzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 03:55:32 -0400
Date: Sun, 19 Oct 2003 00:50:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: John Bradford <john@grabjohn.com>
cc: Norman Diamond <ndiamond@wta.att.ne.jp>, Hans Reiser <reiser@namesys.com>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk
 sectors numbered strangely, and what happens to them?)
In-Reply-To: <200310171253.h9HCr1tw000933@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.10.10310190047390.15306-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sheesh, glad somebody slapped the obvious idioticy on the thread with
solid state media.  Yeah there are ways to force this, and the kernel
execute's all transactions with auto retries on the opcode.

If the drive returns valid data regardless of the ecc brut force required
it will not reallocate period.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Fri, 17 Oct 2003, John Bradford wrote:

> Quote from "Norman Diamond" <ndiamond@wta.att.ne.jp>:
> > Now, maybe there is a technique to force it anyway.  When a partition is
> > newly created and is being formatted with the intention of writing data a
> > few minutes later, do writes that "should" have a better chance of being
> > detected.  The way to start this is to simply write every block, but this is
> > obviously insufficient because my block did get written shortly after the
> > partition was formatted and that write didn't cause the block to be
> > reallocated.  So in addition to simply writing every block, also read every
> > block.  For each read that fails, proceed to do another write which "should"
> > force reallocation.
> 
> I am just imagning how many Flash devices will be worn out
> unnecessarily by any filesystem utility that does this transparently
> to the user :-(.
> 
> > Russell King replied to me:
> > 
> > > > When a drive tries to read a block, if it detects errors, it retries up
> > > > to 255 times.  If a retry succeeds then the block gets reallocated.  IF
> > > > 255 RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
> > >
> > > This is perfectly reasonable.  If the drive can't recover your old data
> > > to reallocate it to a new block, then leaving the error present until you
> > > write new data to that bad block is the correct thing to do.
> 
> I 99% agree with that.  The 1% where I don't is that there may be
> situations where there is no interest in doing any data recovery from
> the drive, (you have backups, it is part of a RAID array, or storing
> temporary data that can be re-generated whenever necessary), and also,
> any read errors that occur during a S.M.A.R.T. read test should result
> in a re-mapping of the block.
> 
> > > Think about what would happen if it did get reallocated.  What data would
> > > the drive return when requested to read the bad block?
> > 
> > Why does it matter?  The drive already reported a read failure.  Maybe Linux
> > programs aren't all smart enough to inform the user when a read operation
> > results in an I/O error, but drivers could be smarter.  I think there's
> > probably a bit of room in an inode to add a flag saying that the file has
> > been detected to be partially unreadable.  Sorry for the digression.
> > Anyway, it is 100% true that the data in that block are gone.  The block
> > should be reallocated and the new physical block can either be zeroed or
> > randomized or anything, and that's what subsequent reads will get until the
> > block gets written again.
> 
> 100% agreed.
> 
> > > If the error persists during a write to the bad block, then yes, I'd
> > > expect it to be reallocated at that point - but only because the drive has
> > > the correct data for that block available.
> > 
> > We agree in our moral expectations and our technical analysis that correct
> > data will be available at that time.  But if your word "expect" means you
> > have confidence that the drive will perform correctly, I do not share your
> > confidence (I think it is possible but highly unlikely that the drive did
> > its job correctly during the previous write).
> 
> If the drive is not doing it's job properly DRIVE -> BIN.
> 
> > > Your description of the way Toshibas drive works seems perfectly sane.
> 
> I disagree - we haven't confirmed what happens in the error-on-write
> situation.  If it does indeed always remap the block, then I'd agree
> that that aspect was perfectly sane.
> 
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

