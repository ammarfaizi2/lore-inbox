Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270033AbUIDDYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270033AbUIDDYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUIDDWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:22:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:31640 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S270028AbUIDDSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:18:42 -0400
Message-Id: <200409040227.i842R7io003637@localhost.localdomain>
To: Spam <spam@tnonline.net>
cc: Helge Hafting <helge.hafting@hist.no>, Oliver Hunt <oliverhunt@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Adrian Bunk <bunk@fs.tum.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives 
In-Reply-To: Message from Spam <spam@tnonline.net> 
   of "Fri, 03 Sep 2004 21:30:38 +0200." <518050016.20040903213038@tnonline.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 03 Sep 2004 22:27:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> said:
> Horst von Brand <vonbrand@inf.utfsm.cl> said:
> > Helge Hafting <helge.hafting@hist.no> said:
> 
> > [...]
> 
> >> The only new thing needed is the ability for something to be both
> >> file and directory at the same time.
> 
> > Then why have files and directories in the first place?

>   Good point, we don't need them :)

Great. Then everything is a firectory (or dile?). And a firectory points at
other firectories and contains data. I just don't see how you are supposed
to distinguish the data from further firectories...

>                                     Directories are just a visible
>   grouping of files to make it easier for the user to manage. But some
>   things aren't really that intuitive with todays layout - especially
>   for non-unix users.

No operating system is "intuitive". A person is able to glance over some 7
items, a filesystem handles tens of thousands of objects. Nothing
"intuitive" possible in the layout, everybody has to _learn_ how to handle
this.

>   Just an example where the user needs to edit config file for some
>   program. Where should he look?

Another example: User looks for the sysadmin. Where does she look? Answers
to both questions depend on extra data that can't possibly be deduced just
from the statement.

[...]

>   Using file-as-dir isn't really that much of a change. It isn't those
>   that will confuse people anyway.

See above.

> >>                                       Some tools will need
> >> a update - usually only because they blindly assume that a directory
> >> isn't a file too, or that a file can't be a directory too.  Remove the
> >> mistaken assumption and things will work because the underlying system
> >> calls (chdir or open) _will_ work.
> 
> > But with some weird restrictions: No moving stuff around between files, no
> > linking, some "files" can't be deleted (how would you handle removing the
> > principal stream of a file?).
> 
>   Well. there are read-only files. And if you remove the main stream
>   (which is the file, really) then it will all be gone =)

While some other process is messing with another stream. Right, all goes
away when the last reference goes away. But it stays iff some other process
recreates the data stream. Now what if another process goes ahead and
creates a new file with the same name in the meanwhile... but this is very
diferent from "real" directories, if you delete some particular member it
doesn't go away. Explain that to the poor user that can't be trusted to
keep the distinction between directories and files straight...

> >  Some stuff you'd love to do (is, in fact, the
> > reason for this all) just can't be allowed (i.e., J. Random Luser setting
> > his own icon for system-wide emacs).

>   Users do not normally have write permissions to system-wide
>   applications.

Exactly.

>                 Why would it be any different now?

Because the user wants to be able to associate an
icon/description/comment/... with system files too. This is supposed to be
one of the key reasons for the feature...

> >  So the tools/scripts/users/sysadmins
> > will have to be painfully aware that some of the files aren't, and some of
> > the directories aren't either. Major pain in the neck to use, if you look
> > closer.  Add extra kernel complexity. For little (if any) gain.

>   Not sure what you mean "aren't". Things shouldn't be that much
>   different to administer.

They aren't. Some directories are files, and different rules apply to
them. Some files have structure, and you have to exercise extra care not to
loose that. Very different indeed in my book.

>                            Normal permissions should still apply.

Even streams inside a file have permissions? What does it mean if a file is
"searchable" (new permission needed to handle "x" on directories vs files!)
but not writeable, and the default stream is writeable? Or do they just
have the permissions of the container? In that case, the file must be
readable so the user can have a nice icon for it. Consider /etc/shadow...
And if somebody tries to change permissions on one of the streams?

>                                                                   Sure
>   extra complexity comes _if_ you want to use extended features that
>   are using meta-info. But there is where we need some patches to tar
>   and other backup tools.

And new options (where people already get confused by current options).

>   One other way would be to enter a specific mode (chroot, a bash
>   flag --show-metas, etc) that would allow all streams and metas to be
>   seen as files in directories. Then tar and other tools would back it
>   all up. Restoring will be a little trickier as we don't know if
>   stuff was files or folders before. But I am sure that would be
>   solvable.

"I'm sure it can be solved somehow" isn't enough.

>             Perhaps a tool to convert them back to normal files with
>   meta-data and streams.

Yikes!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
