Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTJOK0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTJOK0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:26:08 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:38907 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S262540AbTJOK0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:26:03 -0400
Message-ID: <00ea01c39306$a8b2e8d0$3eee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Maciej Zenczykowski" <maze@cela.pl>
Cc: "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310131344270.14165-100000@gaia.cela.pl>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Wed, 15 Oct 2003 19:22:51 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski replied to me:

> > When the drive's self-test detected that one bad sector, I could figure out
> > which partition it was in (though not which file, which is why I asked one
> > of those questions several times already).  The drive's self-test read the
> > entire drive and the other partitions had no detectable errors.
>
> Instead of zeroing the entire partition just zero that single sector.
> something like:
> dd if=/dev/zero of=/dev/hda bs=512 seek=$lbasector conv=notrunc count=1
>
> possibly first check (by reading in the oposite direction:
> dd if=/dev/hda of=/dev/null bs=512 skip=$lbasector count=1)
> if this is indeed the place were you get the read error (in syslog)...

Thank you.

> if you can read anything from it then read it to a file and write it back
> from the file...

dd if=/dev/hda8 of=/dev/null already quit at the bad sector.  It's really
certain that that one sector is it, and I won't be able to read anything
from it.  The read check should just be a redundant check that the correct
sector is being addressed there, and it is a good idea to do that.

> as for checking which file contains it... hmm file->sector->lba mapping
> can be performed... I don't know about the other direction.  Worst case
> would require checking the mapping of all files on the partition (and
> assuming it's not in an empty area or non-file system area).

I made a shell script with find commands to copy all files that are in that
partition (all pathnames that aren't in other mounted filesystems) to
/dev/null.  When one aborts, I should know the name.  But this is an
incredibly inefficient way to do it.  Intuitively it seems it should be
straightforward to find at least one of the pathnames that the file has.
Practically it seems it shouldn't take 24 hours to copy all files in a 5GB
partition to /dev/null.  But after several hours it only copied about 20% of
the files to /dev/null, and I'll have to continue it this weekend.  Even the
drive's "long" S.M.A.R.T. self-test only took 47 minutes.

