Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTJNHUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 03:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTJNHUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 03:20:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:56704 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262188AbTJNHUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 03:20:43 -0400
Date: Tue, 14 Oct 2003 08:21:48 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk>
To: Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3F8BA037.9000705@sbcglobal.net>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
 <20031014064925.GA12342@bitwizard.nl>
 <3F8BA037.9000705@sbcglobal.net>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>I want to make sure that the drive is now using a non-defective
> >>>>replacement sector.
> >>>>        
> >>>>
> >>>A read won't necessarily do that.  You might have to write to a
> >>>defective sector to force re-allocation.
> >>>      
> >>>
> >>I agree, we are not sure if a read will do that.  That is the reason why two
> >>of my preceding questions were:
> >>    
> >>
> >
> >I've seen a disk (which now failed and will be replaced 3 hours from now)
> >remap defective sectors without reporting any errors to the OS. 
> >The SMART "remapped sector count" just went up, but no errors in the
> >logs. So apparently, the disk noticed something and remapped teh sector
> >without anybody noticing. 
> >  
> >
> Can't you pretty much get the drive to check itself using smartctl, such 
> as running:
>      smartctl -o on -s on -S on /dev/hde &> /dev/null
> in an init script?  Also, I think if you just happen to write to a bad 
> sector the drive will remap it without a warning (unless it doesn't have 
> any remapping sectors left), but if you read from it then to get the 
> drive to "notice" it, you have to write back to that sector.  Or run the 
> drive test which should find it and correct it.

That's correct for the majority of modern IDE disks.

> >>   How can I tell Linux to mark the sector as bad, knowing the LBA sector
> >>   number?
> >>    
> >>
> >
> >man tune2fs .
> >
> >You have to do the math on the LBA sector numbers (subtract the
> >partition start, divide by two). 
> >
> >Also, you can use the "badblocks" program. 
> >  
> >
> I think he's using reiserfs on the partition, which ASFAIK doesn't 
> support marking bad sectors without some work.  I tend to agree with 
> namesys when they suggest just getting a new drive if it has used up all 
> of its extra sectors.  In my experience (admittedly limited), any drive 
> which runs out of extra sectors starts to go bad in a hurry.

I fail to see the point of this discussion.  What is the point in
marking sectors bad at the filesystem level, when the drive is
supposed to be doing it at the firmware level?

The drive is probably full of unusable areas, which are correctly
identified and not used by the firmware.  One more is detected, and
the firmware doesn't cope with it.  Suddenly we are getting
suggestions to work around that in the filesystem.

The drive may well have been developing faults regularly through it's
entire lifetime, and you haven't noticed.  Now you have noticed and
want to work around the problem, but why wouldn't the drive continue
it's 'natural decay', and assuming it does, why would it be able to
re-map future bad blocks, but not this one?

Working around the problem in the filesystem makes no sense at all on
a modern IDE drive.

John.
