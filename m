Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTJMLbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTJMLbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:31:20 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:4809 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S261678AbTJMLbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:31:16 -0400
Message-ID: <33d201c3917d$668c8310$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <200310131033.h9DAXkHu000365@81-2-122-30.bradfords.org.uk>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Mon, 13 Oct 2003 20:30:19 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford replied to me:

> > > > How can I tell Linux to read every sector in the partition?  Oh, I
> > > > might know this one,
> > > >   dd if=/dev/hda8 of=/dev/null
> > > > I want to make sure that the drive is now using a non-defective
> > > > replacement sector.
> > >
> > > A read won't necessarily do that.  You might have to write to a
> > > defective sector to force re-allocation.
> >
> > I agree, we are not sure if a read will do that.  That is the reason why
> > two of my preceding questions were:
> >
> >    How can I find out which file contains the bad sector?  I would like
> >    to try to recreate the file from a source of good data.
>
> How are you going to make sure you write it in the same location as it was
> before?

Mostly it doesn't matter.  The primary purpose of this bit of it is to
recreate the file to contain good data, which is why I would try to recreate
it from a source of good data.  The secondary purpose is:
  IF the bad sector doesn't get reused then great, then the next bit of
effort will be to try to get the sector marked as bad, if there is any way
to do that under Linux.  See the next question, which is now being reposted
for at least the fourth time.
  BUT IF the same sector number gets rewritten then hopefully the same
sector number will be associated with a reallocated non-defective sector and
the data will get written properly.

> >    How can I tell Linux to mark the sector as bad, knowing the LBA
> >    sector number?
>
> Don't.  If the drive can't fix this problem itself, throw it in the bin.

THE DRIVE HAS 1, ONE, HITOTSU, UNO, UN, BAD SECTOR.  The drive is capable of
doing reallocations.  What kind of operation can be done that will persuade
the drive to do the reallocation?

> > And that is also the reason why my last question, which Mr. Bradford
> > replied to, had the stated purpose of making sure that the drive is now
> > using a non-defective replacement sector after the preceding operations
> > have been carried out.
>
> Backup your data.

I want to fix the defective file from an existing backup or recomputation.
Aside from that, it is my crash box (as already posted in this thread).  The
questions are still important because sometimes this kind of thing happens
on machines that aren't crash boxes, and it is not customary to dump a drive
when 99.99% of its preparations for error recovery are still intact.

> Run the S.M.A.R.T. tests.

I DID.  YOU REPLIED TO MY POSTING WHERE I REPORTED THEM.

> Write over the whole disk with something like dd if=/dev/zero of=/dev/hda.

Hmm.  That could well be an answer.  I'll think about it.

Actually I should just write over the whole partition for the present time.
When the drive's self-test detected that one bad sector, I could figure out
which partition it was in (though not which file, which is why I asked one
of those questions several times already).  The drive's self-test read the
entire drive and the other partitions had no detectable errors.

> If you still get errors, replace the disk.

If the errors are not correctable and/or numerous (where I do not count
numerous syslog entries of the same defective sector to be numerous errors)
then of course I will do so.  Even though it's my crash box.

...  By the way, consider this:

Windows 98 has a scandisk command which writes a file scandisk.log in which
the user can see which files have been deleted by scandisk or corrupted
either by scandisk or before scandisk.  The user can try to recreate those
files.

Windows 2000 has a chkdsk command which does not write a logfile.

Therefore it is convenient for Windows 2000 users to keep an installation of
Windows 98 installed in order to run Windows 98's scandisk command when
necessary.  (Doesn't work for NTFS partitions, but otherwise convenient.)

If Linux is really supposed to be even less powerful than both of those,
then there's quite a lot of wasted effort under way in this undertaking.

