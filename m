Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293192AbSCAEq6>; Thu, 28 Feb 2002 23:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310356AbSCAEpI>; Thu, 28 Feb 2002 23:45:08 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34803
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310350AbSCAEn6>; Thu, 28 Feb 2002 23:43:58 -0500
Date: Thu, 28 Feb 2002 20:44:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020301044445.GH2711@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com> <20020228160552.C23019@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020228160552.C23019@devcon.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 04:05:52PM +0100, Andreas Ferber wrote:
> On Tue, Feb 26, 2002 at 01:34:27PM -0500, Richard B. Johnson wrote:
> 
> > All the deleted files, with the correct path(s), are now in the
> > top directory file the file-system ../lost+found directory. They
> > are still owned by the original user, still subject to the same
> > quota.
> 
> And what about:
> 
> - Luser rm's "foo.c"
> - Luser starts working on new version of "foo.c"
> - Luser recognizes, that the old version was better
> - Luser rm's new "foo.c"
> - Luser tries to unrm the old "foo.c" -> *bang*
> 
> Trust me, there /will/ be a luser who tries to do it this way. 

Yes, users will do that.  And this problem is easily solved by keeping a
copy of each deleted file based on the date, so you can have several
versions of the same file in the undeleted dir.

>If
> teaching lusers were enough, you'd have no need for an unrm at all.
> Everyone would be using version control for important data, and
> everything would be fine.

Not everyone works with text-only formats.

> > The disk space can't run out because you have simply moved
> > files that didn't exceed the disk space before they were moved.
> 
> But a user will end up unable to /free/ any diskspace. User tries
> something, generates a /huge/ error log filling up the quota/disk,
> oops, has to call sysadmin before work can go on... Five minutes
> later, the fix just tried didn't work, oops, has to call admin again,
> and so on. Do you /really/ want this?
> 

The undelete daemon will have to be quota aware.  The unfortunate side
affect is that if the user is close to their limit, undelete is effectively
disabled because there won't be enough space left in their quota to keep the
deleted file.

The only way for undelete to fill up your drives is for the undelete daemon
to crash and die.  This can be avoided by having init monitor it... or
whatever other mechanism you want...

> And how do you want to handle temp files? If you don't exclude them
> from undeletion, they will fill up your diskspace soon. For the moment
> I can't think of any mechanism that identifies temp files reliably
> (without API changes).
>

The temp files will only make other older files in the undelete dir be
purged...

> > All one needs is a compile-time switch to enable the following:
> 
> And a system wide configurable switch, and a user configurable switch
> and so on.
> 
> Undeletion has /many/ implications, did you think through all of them?
>

No, but this thread has brought up many considerations.

>
> 
> Just as a personal note: personally I would simply /refuse/ to work on
> a system where I end up unable to delete even files I /own/, or at
> least I would end up implementing my own way of deleting files which
> circumvents undeletion (there will /always/ be a way to do it).

Yes, statically compiled binaries would work, a library preload, etc.

> If your employer didn't expressively forbid you to keep private data
> on your work account, you are allowed to do so, at least here in
> germany, and you can sue your employer if he takes actions to look
> into your private data without informing you /before/ doing it (taken
> strictly, if you are allowed to keep private data on your work
> account, you even have to be informed explicitly that the data may be
> backuped and recovered later from backup tapes). So in the end,
> undeletion is also a matter of privacy, and the ability to undelete
> may even pose legal problems on a company.
> 

That is a configuration issue.  All the implementation will need to do is be
configurable enough to follow the local policy.

Mike

