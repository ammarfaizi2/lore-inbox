Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTJNHkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 03:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTJNHkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 03:40:23 -0400
Received: from users.linvision.com ([62.58.92.114]:62869 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262201AbTJNHkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 03:40:21 -0400
Date: Tue, 14 Oct 2003 09:40:20 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: John Bradford <john@grabjohn.com>
Cc: Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Message-ID: <20031014074020.GC13117@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 08:21:48AM +0100, John Bradford wrote:
> > >
> > >Also, you can use the "badblocks" program. 
> > >  
> > >
> > I think he's using reiserfs on the partition, which ASFAIK doesn't 
> > support marking bad sectors without some work.  I tend to agree with 
> > namesys when they suggest just getting a new drive if it has used up all 
> > of its extra sectors.  In my experience (admittedly limited), any drive 
> > which runs out of extra sectors starts to go bad in a hurry.
> 
> I fail to see the point of this discussion.  What is the point in
> marking sectors bad at the filesystem level, when the drive is
> supposed to be doing it at the firmware level?

I'm not sure in what cases a drive will remap a sector. Manufacturers
are not publishing this.

So if you get a read-error (showing you that some of your data was just
lost!), you could just rewrite that sector and hope for the drive to
remap it. Well, you just lost some of your data. Maybe it was part of a
file you got from a CD. Fine. Easy to replace. Maybe it was part of your
CD-collection-backup. Fine. Easy to replace. Maybe it was part of your
thesis document. Oops. Difficult to replace.

> The drive is probably full of unusable areas, which are correctly
> identified and not used by the firmware.  One more is detected, and
> the firmware doesn't cope with it.  Suddenly we are getting
> suggestions to work around that in the filesystem.

Right. Support for bad sectors is really easy to build into a
filesystem. If Reiserfs doesn't (yet) support it, another reason not 
to use Reiserfs. 

You create a file called something like ".badblocks" in the root
directory. If as a filesystem you get to know of a bad block, just
allocate it towards that file. Next it pays to make the file invisble
from userspace. (otherwise "tar backups" would try to read it!). 

This is usually done by just allocating an inodenumber for it, and
telling  fsck about it, to prevent it being linked into lost+found 
on the first fsck.... 

> The drive may well have been developing faults regularly through it's
> entire lifetime, and you haven't noticed.  Now you have noticed and
> want to work around the problem, but why wouldn't the drive continue
> it's 'natural decay', and assuming it does, why would it be able to
> re-map future bad blocks, but not this one?

On the other hand, I once bumped my knee against the bottom of the table
that my computer was on. That was the exact moment that one of my
sectors went bad. So now I know the cause, and want to remap the sector. 
No gradual decay. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
