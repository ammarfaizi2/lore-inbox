Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310248AbSCEV3m>; Tue, 5 Mar 2002 16:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310259AbSCEV3d>; Tue, 5 Mar 2002 16:29:33 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:34564 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S310248AbSCEV3M>; Tue, 5 Mar 2002 16:29:12 -0500
Date: Tue, 5 Mar 2002 22:29:10 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Pavel Machek <pavel@suse.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020305222910.A17336@devcon.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com> <20020228160552.C23019@devcon.net> <20020304162614.C96@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020304162614.C96@toy.ucw.cz>; from pavel@suse.cz on Mon, Mar 04, 2002 at 04:26:15PM +0000
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 04:26:15PM +0000, Pavel Machek wrote:
> > 
> > And what about:
> > 
> > - Luser rm's "foo.c"
> > - Luser starts working on new version of "foo.c"
> > - Luser recognizes, that the old version was better
> > - Luser rm's new "foo.c"
> > - Luser tries to unrm the old "foo.c" -> *bang*
> > 
> > Trust me, there /will/ be a luser who tries to do it this way. If
> > teaching lusers were enough, you'd have no need for an unrm at all.
> You don't consider me a luser, right?

No, not really. ;-)

> Okay, and I *did* need unrm few times. Few examples:
> 
> /dev# rm sbpcd *     (simple typo, recovered by immediate powerdown + fsck)

% rm sbpcd *
zsh: sure you want to delete all the files in /dev [yn]? n
rm: remove write-protected file `sbpcd'? n
%

> /big$ mp1enc > samotari.mpg (oops, I did it twice, second time by mistake, and
> 		powerswitch was too far away to make it in time)
> 
> So yes, unrm is usefull. And it would be even more usefull if it recovered
> truncated files, too.  How many times did you do > instead of >>? I did that
> mistake many times, its just easy..

% cat > foo
zsh: file exists: foo
% cat >| foo
[Now zsh is quiet. It even "fixes up" the history if you want so, so
that you can simply press "Up"+"Enter" if you really want to overwrite
the file]

Surely, protection against typos etc. has its value. But do it at the
place where does typos happen (ie. at the shell prompt), not by
messing with lowlevel stuff like the unlink syscall, which

  a) catches only very few ways of destroying a files contents
  b) poses a /great/ deal of complexity on you (like having to
     identify tempfiles, managing disk space etc.)

With some simple checks of the commandline you can catch many of the
common typos which end up destroying data. And it comes at nearly no
cost, is much more flexible and avoids any problems with tempfiles,
quota etc. in the first place.

And for the rest, which are not catched by those checks, that's what
backups are for.

Honestly, I also had a few moments where I wished I had an unrm
command available, and where it required a bit of work to fix up the
mess. But those situations are not that common that I really want to
have to manage a full fledged undeletion system all the time, and work
around the problems that it imposes.

Also, take the "human factor" into account: Users /will/ get more
sloppy with regards to thinking before typing, checking commandlines
before hitting enter etc., if they always have a "safety net" behind
them.  And it /will/ bite them in the ass once they are in a situation
(different system, root, ...) where those safety nets are not
available.

This is also the reason why I don't like those "rm -i" aliases some
distros are setting by default. I have /seen/ luser typing "rm *" when
they just wanted to delete some of the files in a directory, because
they were used to rm asking for every file if they want to delete it.
Now guess what happens if such a luser is dropped into an environment
where those aliases are not set...

And yes, I realize that for example those zsh examples above are also
somewhat into the same direction. But they are different from the "rm
-i" example above in that they don't change the semantics of a
command line, so that you are still obliged into checking the command
line /before/ submitting it, otherwise you get those annoying
questions and still have to resubmit the command.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
