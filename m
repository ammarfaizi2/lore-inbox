Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293653AbSB1S1p>; Thu, 28 Feb 2002 13:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293647AbSB1SYq>; Thu, 28 Feb 2002 13:24:46 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:16399 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293646AbSB1SXe>; Thu, 28 Feb 2002 13:23:34 -0500
Date: Thu, 28 Feb 2002 16:05:52 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: ext3 and undeletion
Message-ID: <20020228160552.C23019@devcon.net>
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Feb 26, 2002 at 01:34:27PM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 01:34:27PM -0500, Richard B. Johnson wrote:

> All the deleted files, with the correct path(s), are now in the
> top directory file the file-system ../lost+found directory. They
> are still owned by the original user, still subject to the same
> quota.

And what about:

- Luser rm's "foo.c"
- Luser starts working on new version of "foo.c"
- Luser recognizes, that the old version was better
- Luser rm's new "foo.c"
- Luser tries to unrm the old "foo.c" -> *bang*

Trust me, there /will/ be a luser who tries to do it this way. If
teaching lusers were enough, you'd have no need for an unrm at all.
Everyone would be using version control for important data, and
everything would be fine.

> The disk space can't run out because you have simply moved
> files that didn't exceed the disk space before they were moved.

But a user will end up unable to /free/ any diskspace. User tries
something, generates a /huge/ error log filling up the quota/disk,
oops, has to call sysadmin before work can go on... Five minutes
later, the fix just tried didn't work, oops, has to call admin again,
and so on. Do you /really/ want this?

And how do you want to handle temp files? If you don't exclude them
from undeletion, they will fill up your diskspace soon. For the moment
I can't think of any mechanism that identifies temp files reliably
(without API changes).

> All one needs is a compile-time switch to enable the following:

And a system wide configurable switch, and a user configurable switch
and so on.

Undeletion has /many/ implications, did you think through all of them?



Just as a personal note: personally I would simply /refuse/ to work on
a system where I end up unable to delete even files I /own/, or at
least I would end up implementing my own way of deleting files which
circumvents undeletion (there will /always/ be a way to do it).

If your employer didn't expressively forbid you to keep private data
on your work account, you are allowed to do so, at least here in
germany, and you can sue your employer if he takes actions to look
into your private data without informing you /before/ doing it (taken
strictly, if you are allowed to keep private data on your work
account, you even have to be informed explicitly that the data may be
backuped and recovered later from backup tapes). So in the end,
undeletion is also a matter of privacy, and the ability to undelete
may even pose legal problems on a company.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
