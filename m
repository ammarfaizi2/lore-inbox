Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTJQLJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263383AbTJQLJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:09:31 -0400
Received: from users.linvision.com ([62.58.92.114]:49312 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263381AbTJQLJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:09:29 -0400
Date: Fri, 17 Oct 2003 13:09:27 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: John Bradford <john@grabjohn.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Message-ID: <20031017110927.GA11792@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60> <20031017102436.GB10185@bitwizard.nl> <200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 11:49:11AM +0100, John Bradford wrote:
> Quote from Rogier Wolff <R.E.Wolff@BitWizard.nl>:
> > On Fri, Oct 17, 2003 at 06:40:01PM +0900, Norman Diamond wrote:
> > > I explained to them why the LBA sector number should still get
> > > reallocated even though the data are lost.
> > 
> > This is unbelievably bad: Sometimes it is worth it, to try and read
> > the block again and again. We've seen blocks getting read after we've
> > retried over 1000 times from "userspace". That doesn't include the
> > retries that the drive did for us "behind the scenes". 
> 
> That's moving in to the realms of more advanced data recovery.  You
> shouldn't really expect to be able to do those kind of forensics on
> intellegent drives using standard filesystem system calls.

Yep. And several manufacturers have told us that they don't put any
"bypass" commands in their firmware so as a data-recovery company we
can't bypass the normal stuff. On SCSI drives we get to set the
"number of retiries" and things like that. Terribly useful. Not on ATA
drives. 

> Besides, are you positive that you always got the correct data off the
> disk?  See the discussions about hashing algorithms - maybe the drive
> simply returned data that had an additional bit flipped and wasn't
> identified as bad.  If you are having to try over 1000 times from
> userspace, the drive is in a bad way.  You shouldn't really make
> assumptions that you do usually, (that the error correction is good
> enough to ensure bad data isn't returned as good data).  If you are
> recovering data from a spreadsheet, for example, the errors could go
> unnoticed, but have catastrophic results.

Yes, as an experienced data-recovery-expert I can look at the data,
and say that I believe it. And I know the risks you explain here.

> > If you manage to convince Toshiba to remap the sector on a "bad read",
> > we'll never ever be able to recover the sector.
> 
> Of course you will - it's remapped, the data isn't overwritten!  You
> may need more advanced tools, but you can still seek the heads to that
> part of the platter and get data from the head-amp.  Just because you
> couldn't use your simple method anymore is real reason to argue
> against fixing the problem.

Nope. Even on SCSI drives there seems to be no way to tell the drive
"please give me the data for raw block XXX". We've pushed the
manufacturers for the ability to do this, but we get nowhere. Feel
free to prove us wrong. Armwaving doesn't work. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
