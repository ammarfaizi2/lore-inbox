Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSCAA0K>; Thu, 28 Feb 2002 19:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSCAAYN>; Thu, 28 Feb 2002 19:24:13 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19102 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310284AbSCAAT1>; Thu, 28 Feb 2002 19:19:27 -0500
Message-Id: <200203010019.g210J1V07447@eng4.beaverton.ibm.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion 
In-Reply-To: Your message of "Tue, 26 Feb 2002 09:22:27 PST."
             <20020226172227.GM4393@matchmail.com> 
Date: Thu, 28 Feb 2002 16:19:00 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of talk about "daemons" ... seems overkill to me.  Any reason not
to let each user do this on their own?  I've got an rm/unrm program
that just stores the "rescued" files in your home directory for a
period of time based on the either the name or pathname.

It is not fully "hardened" -- it is possible to conceive of filenames
and filename/directory name pairs which will confuse it -- but it is
certainly functional for 98% of cases, which has been good enough for
my personal use.

Disadvantages:
    * the mtime is purposefully changed when the file is deleted to make
      it easy to tell when a file was "deleted", so you lose that information.
    * Directory modes and owners are not maintained.
    * File ownerships are maintained only to the extent that a hard
      link allows you to. If you couldn't do a hard link (cross file
      systems) then the "saved" file will be owned by you unless you
      are root.
    * There's no way to say "save until X amount is saved then really
      delete" (whether "X amount" is %age of file system, a fixed amount,
      or some other criteria).  The only criteria is age of deletion.
    * (true) deletions are only attempted when a subsequent file is rm'ed.
      So it's conceivable to delete 300Mb of data that is scheduled to
      disappear in 30 seconds but not have it go away for three days,
      because you left town for the weekend and neither you nor your
      cron scripts ran "rm" again until Monday.

If this sort of program is useful to folks, I'm more than happy to
provide it. No doubt it could be enhanced to address some of the
shortcomings above. I just got tired many years ago of accidentally
typing "rm * .o" and only finding out my typo when I saw "rm: .o: file
not found" and it has, for the most part, served with minor modifications
for many years.

Rick
