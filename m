Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTJNIKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbTJNIKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:10:48 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4737 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261959AbTJNIKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:10:43 -0400
Date: Tue, 14 Oct 2003 09:11:59 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310140811.h9E8Bxq1000831@81-2-122-30.bradfords.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Wes Janzen <superchkn@sbcglobal.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20031014074020.GC13117@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
 <20031014064925.GA12342@bitwizard.nl>
 <3F8BA037.9000705@sbcglobal.net>
 <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk>
 <20031014074020.GC13117@bitwizard.nl>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my last mail on this subject.

> I'm not sure in what cases a drive will remap a sector. Manufacturers
> are not publishing this.
> 
> So if you get a read-error (showing you that some of your data was just
> lost!), you could just rewrite that sector and hope for the drive to
> remap it. Well, you just lost some of your data. Maybe it was part of a
> file you got from a CD. Fine. Easy to replace. Maybe it was part of your
> CD-collection-backup. Fine. Easy to replace. Maybe it was part of your
> thesis document. Oops. Difficult to replace.

Sector re-mapping is not a replacement for backing up your data.  It
merely adds resiliance to the disk.  Infact, it's more or less
impossible to get away from these days - modern IDE disks error
correct all the time.  One area of the disk going bad is not an
unlikely event.

> > The drive is probably full of unusable areas, which are correctly
> > identified and not used by the firmware.  One more is detected, and
> > the firmware doesn't cope with it.  Suddenly we are getting
> > suggestions to work around that in the filesystem.
> 
> Right. Support for bad sectors is really easy to build into a
> filesystem. If Reiserfs doesn't (yet) support it, another reason not 
> to use Reiserfs. 

Not at all.  A bad sector map in the filesystem is a pointless feature
for a filesystem which will only likely be used on fault tollerant
devices.  It serves no purpose.  The 'it does no harm' argument is
just as pointless. 

> You create a file called something like ".badblocks" in the root
> directory. If as a filesystem you get to know of a bad block, just
> allocate it towards that file. Next it pays to make the file invisble
> from userspace. (otherwise "tar backups" would try to read it!). 

Doing that kind of thing was quite useful in the 1980s when floppies
were actually expensive and hard disks usually didn't remap bad
sectors.  Nowadays, it usually gains nothing, and may well hide real
faults that could cause data loss later on.

> This is usually done by just allocating an inodenumber for it, and
> telling  fsck about it, to prevent it being linked into lost+found 
> on the first fsck.... 
> 
> > The drive may well have been developing faults regularly through it's
> > entire lifetime, and you haven't noticed.  Now you have noticed and
> > want to work around the problem, but why wouldn't the drive continue
> > it's 'natural decay', and assuming it does, why would it be able to
> > re-map future bad blocks, but not this one?
> 
> On the other hand, I once bumped my knee against the bottom of the table
> that my computer was on. That was the exact moment that one of my
> sectors went bad. So now I know the cause, and want to remap the sector. 
> No gradual decay. 

Again, you are talking around the problem - there almost certainly
will be gradual decay with any disk.  You are just not noticing it
because the firmware is handling it.  If you know that there is a bad
sector, and the disk is not re-mapping it, _why_ isn't it remapping
it?

John.
