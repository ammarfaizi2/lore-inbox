Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTJNKFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTJNKFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:05:22 -0400
Received: from users.linvision.com ([62.58.92.114]:22937 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262118AbTJNKFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:05:10 -0400
Date: Tue, 14 Oct 2003 12:05:05 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Message-ID: <20031014100505.GD16683@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk> <20031014074020.GC13117@bitwizard.nl> <200310140800.h9E80BT9000815@81-2-122-30.bradfords.org.uk> <20031014081110.GA14418@bitwizard.nl> <3F8BB9ED.5010504@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8BB9ED.5010504@sbcglobal.net>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 03:55:09AM -0500, Wes Janzen wrote:
> >And the real-time performance of the drive becomes unreliable. 
> >Worst case, in a 1Mbyte block 1 million sectors are remapped,
> >requiring a seek of 10ms. While normally reading that block of
> >data would consume 1/40th of a second, you are now looking at
> >about 3 hours. 

> Well, aren't we talking about hardware sectors?  The hardware sectors 
> are probably at least 1 MB in size to start with.  My old 16GB Maxtor 
> that had remapped its way out of sectors only had 16 to remap (the last 
> unit I had fail due to this problem).  I doubt the hardware sectors were 
> anywhere near 1 byte in size.  The bad sectors also seemed to occur at 

OOops. Sorry. Too quick with the numbers. The remapping granularity is
1 sector (0.5kbytes), and there are 2000 of those in a megabyte.

So if the odd numbered ones end up remapped, you have 2000 seeks to
perform to read that 1Mb of data. That would come to 2000 * 10ms = 20
seconds. Not quite as bad as several hours, but still.... 

> an exponential rate, which is supported by the 5 drives I've seen go bad 
> in this manner.  Supposedly that has to do with debries spreading across 
> the platter and taking out adjacent sectors.  The one drive I didn't 
> send back or replace immediately after the first error (i.e. no more 
> sectors can be remapped) had lost nearly 50MB of space to bad sectors in 
> a week, and 200MB by the time the replacement arrived 4 days later.  I 
> imagine that this only gets worse as more data is packed into a smaller 
> space.

This supports my statement that if you notice sectors getting bad,
replace the disk as fast as you can, and hope that the sector
remapping bails you out until you get that chance.


> Is there even a way to disable sector remapping on an ATA drive anyway?  
> To avoid these "disadvantages of hardware remapping" you'd need some way 
> to ensure that the drive didn't remap any sectors.  As someone noted, 
> their drive remapped a sector without anything showing up in the log. 

Some drives claim "AV compatibility" or something like that. I think
that this means that they will have their spare sectors on the same
cylinder. i.e. no seeking. (just on average 8ms delay).

> I start more closely watching any drive that remaps more than half its 
> available sectors, if it gets close to the limit I replace it (if it's 
> out of warranty, otherwise I help it along with some badblock runs).  
> It's just not worth the hassle of losing data.  At least if the drive 
> detects the error, chances are it recovers the data and copies it to a 
> good sector (at least I've never lost any data from a drive remapping).  
> I can't say the same for the filesystem trying to recover the data, 
> which usually seems to result in a corrupted file.  IMHO, the data 
> integrity of hardware remapping outweighs any performance disadvantage 
> as compared to a filesystem-only based solution.
> 
> Now if only the drive would catch the problem without requiring a write 
> to the offending sector first. ;-)  Maybe that's already fixed on the 
> newer drives, none of my newer ones have remapped sectors yet.

The problem is that it would be nice if the disk could report: I just
read the data from block XXX for you, but I had a hard time getting it
for you. Recommend reassignment. The OS should then log this, and put
the file that this belongs to elsewhere. This gives the OS the
authority, and the sysop the ability to take appropriate action.

I don't mind a couple of remaps on my mp3 collection. But I rather
hate them on my root drive. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
