Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUB1VnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 16:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUB1VnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 16:43:11 -0500
Received: from ssatchell1.pyramid.net ([208.170.252.115]:7553 "EHLO
	ssatchell1.pyramid.net") by vger.kernel.org with ESMTP
	id S261933AbUB1VnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 16:43:07 -0500
Subject: RE: another hard disk broken or xfs problems?
From: Stephen Satchell <list@satchell.net>
To: Michael Joy <mdj00b@acu.edu>
Cc: "'Nathan Scott'" <nathans@sgi.com>,
       "'Nico Schottelius'" <nico-kernel@schottelius.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040225231045.LJJM25915.lakemtao08.cox.net@nagasaki>
References: <20040225231045.LJJM25915.lakemtao08.cox.net@nagasaki>
Content-Type: text/plain
Message-Id: <1078004585.3347.14.camel@ssatchell1.pyramid.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 13:43:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 15:10, Michael Joy wrote:
> One thing I've run into recently is that Hitachi drives come from the
> factory with bad sectors out of the box. If you run a full format on the
> drive checking for bad sectors the first time you use the drive, it will
> occasionally find an error, the format will die, and the next time you
> format nothing will be found.
> 
> It's a symptom of Hitachi not properly QC'ing their drives by fully
> formatting them several times. The problem can reoccur over the first few
> days until the drive finds all the questionable bad sectors and reallocates
> backup sectors to cover for it.

It's not just Hitachi drives, either.  I just purchased a NEW (not
reburbed) Maxtor 80-GB drive to replace a Fujitsu that finally reached
end of life, and found that I had to zero the drive before it would mkfs
properly.  The command I used to make this happen is:

   dd if=/dev/zero of=/dev/hdb bs=1M

I'm used to doing this because I've discovered that the refurb drives my
employer has been buying have been needing zeroing before use.  I know
that's not as good as using a worst-case pattern specific to the drive,
but it's good enough to get the known bad sectors remapped at the start,
then let the drive discover other bad sectors as it goes.  To that end,
the systems under my control run a weekly CRON job that looks something
like this:

  /bin/nice -n 15 /bin/dd if=/dev/hda of=/dev/null bs=128k
  /bin/nice -n 15 /bin/dd if=/dev/hdc of=/dev/null bs=128k
  /bin/nice -n 15 /bin/dd if=/dev/sda of=/dev/null bs=128k

This ensures that all sectors are readable, regardless of file system
state, and relocates and reassigns those sectors that can be read in any
way.

I also have started installing smartmontools into all my systems, and
configuring them to e-mail me when a critical parameter changes -- I'm
getting tired of coming in to work and discovering that a hard drive has
finally bit the big one.  (It doesn't help prevent a crisis, because a
thrown head is such a catastropic event, but it does help with
end-of-life discovery, so a disk change can be scheduled.)

