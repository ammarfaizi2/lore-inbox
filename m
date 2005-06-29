Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVF2UlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVF2UlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVF2UlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:41:14 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:47602 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262598AbVF2Ukg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:40:36 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> (Horst von
 Brand's message of "Wed, 29 Jun 2005 01:09:05 -0400")
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
X-Hashcash: 1:23:050629:vonbrand@inf.utfsm.cl::NlxMIXzmN2TNbffz:0000000000000000000000000000000000000000gqMc
X-Hashcash: 1:23:050629:mrmacman_g4@mac.com::knqgA1HPbtTN7IYk:0000000000000000000000000000000000000000014GaF
X-Hashcash: 1:23:050629:ninja@slaphack.com::CV6bd3nQ8S3oGGiy:0000000000000000000000000000000000000000000EDxA
X-Hashcash: 1:23:050629:valdis.kletnieks@vt.edu::FG98SYqvTaoYnmD8:00000000000000000000000000000000000001LcOa
X-Hashcash: 1:23:050629:ltd@cisco.com::KNYaM8RlL2IEg+l2:00007+nZ
X-Hashcash: 1:23:050629:gmaxwell@gmail.com::SwgVoV0Sgwq5HNM1:00000000000000000000000000000000000000000004q/M
X-Hashcash: 1:23:050629:reiser@namesys.com::n0N9HEc5bC1xQzN5:00000000000000000000000000000000000000000000bQV
X-Hashcash: 1:23:050629:jgarzik@pobox.com::0c7hUtoxc905vnZG:00000000000000000000000000000000000000000000lmEv
X-Hashcash: 1:23:050629:hch@infradead.org::uEuYVR4uS2wpAG6K:00000000000000000000000000000000000000000000c39A
X-Hashcash: 1:23:050629:akpm@osdl.org::80vG0fKbHPhk1Ijf:00009YEk
X-Hashcash: 1:23:050629:linux-kernel@vger.kernel.org::y5pDyJt/+rf+z/Wd:000000000000000000000000000000000ogz0
X-Hashcash: 1:23:050629:reiserfs-list@namesys.com::uWbrRmeLJBXNiJ3t:000000000000000000000000000000000000ku9I
Date: Wed, 29 Jun 2005 16:40:14 -0400
Message-ID: <87hdfgvqvl.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42C3076F.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 01:09:05 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:

> Hubert Chan <hubert@uhoreg.ca> wrote: [...]

>> Of course.  With file-as-dir, you can "cd /usr/games/tetris/..." and
>> mess with the game files, or you can run "/usr/games/tetris" and get
>> on with ... stacking blocks.

> And doing "tar cf /dev/tape /usr/games/tetris" gives you a nice tangle
> of undecipherable junk.

Uh, yeah.  I thought we already discussed this in the last flamewar
about merging Reiser4.  You can patch tar/cp/backup programs if you want
to go the file-as-dir route, or you can try to patch all the other
programs if you want to go the xattr route and you really want to edit
you extended attributes using $EDITOR (which I'll admit not everyone
wants to do).

>> The advantage of doing it in the kernel is that you don't need extra
>> support from the applications (or GnomeVFS or KDE).

> I don't see any advantage here... it has to be implemented, and doing
> it in-kernel for one filesystem is /much/ harder than doing it in
> userland, where it'll probably work whatever the underlying filesystem
> is.

Only filesystems that support the capability, or if you have an
appropriate filename munging system (see below) or some other system to
emulate the capability.

> Besides, why should the Tetris scores (or icon, or whatever) reside
> inside the executable, when said executable is perhaps shared by a
> bunch of machines on the network, each of which would like to keep its
> own? Or perhaps the sysadmin is terminally paranoid, and mounts /usr
> read-only (Hey, the FHS people defined what goes in there with
> /exactly/ that in mind too!).

Scores, no.  But Tetris still may have resource data that logically
belongs to it.  Like icons, internationalization data, UI data
(say a Glade file), etc.  It's all part of the same package; it would be
nice (IMHO) if it was grouped together in the filesystem.

I don't think MacOS X stores scores in the app file, but they have a lot
of other stuff in there -- stuff that I mentioned in the previous
paragraph.

>> So typing "/usr/games/tetris" from the command prompt does the same
>> thing as double-clicking it in the file manager.

> Right. And what should happen if I run the (logically equivalent)
> directory /home? Or /etc?

If there's no binary data attached to /home or /etc (i.e. it only has
directory contents), then nothing happens (other than an error
message).  That's like asking what happens if I do
"cat nonexistent.file".  If there's no data there to work with, then
nothing happens.

> What if I want to shove a directory into the tetris executable?
> Symlinks? Hard links to files inside? Outside?  Symlinks from the
> outside in? Hardlinks?

What problems do you see with those?

> And if you now move that to another filesystem, or ship it to another
> machine?

What happens when you copy a file from NTFS that has multiple streams?
Or a file that has extended attributes onto a filesystem that doesn't
support xattr?

> No, the answer "All that will be forbidden" is /not/ allowed, you want
> this stuff working "normally". "Unpack" the contents into real files
> and directories how?

If you really want to, you can do some filename munging.  The contents
of the /usr/games/tetris/ directory could be put in /usr/games/...tetris,
or something like that.

> "Pack" a directory into one of those structured objects? What would be
> the /practical/ difference between the packed and unpacked forms?

It's really, really ugly. ;-)

It's possible to just put all my files all in a single directory.  But
sorting things into different directories makes things look much nicer.

> (If none, why do it in the first place?  If the packed version has
> significant restrictions, why use it? If the packed version does have
> significant extra capabilities, why not just give those to regular
> objects?)

> Yet again, what somebody (I forget who) called the "Zero - one -
> infinity principle" (I think it was in the area of programming
> languages; which arguably are very complex user interfaces, just like
> what an operating system provides): It only makes sense giving zero,
> exactly one, or how many you wish for of some item/nesting. Here:
> Either files got /no/ strange things inside, or /exactly one/ (and
> then it becomes questionable, as there is no space for regular data
> anymore...), or whatever complex (sub)structure you want. But in the
> last case, there is /no/ difference between a file and a
> directory... and the whole setup is just mess for mess sake, nothing
> else.

Files would have two "forks" (can't think of any better terminology
right now).  A data fork, and a directory fork.

--- Begin useless analogy ---
Sort of like a real folder in meatspace.  I can talk about what I've
written on the folder (because I can write stuff on real physical
folders), or I can talk about what's inside the folder.

Or if I have a document, I can talk about the document itself, or the
random post-its, notes, and paperclips that I have attached to it.
---- End useless analogy ----

Right now, most Linux filesystems have xattrs and acls (stored as
xattrs).  Maybe in the future, the Samba people will get support for
multiple streams.  If I want to copy my NTFS file to ext3 and preserve
the multiple streams, then ext3 will need to support multiple streams
now.  Now we have two strange things inside.  Why not just unify the
interface using something like file-as-dir, or metafs that was proposed
in this thread, or openat, or something like that?

>> Of course, this change does require file managers to understand
>> default actions when it's ambiguous what to do on a double-click --
>> but MacOS X has that too, in the form of the "Open as Folder" option
>> (or whatever it's called).

> Right. For the sake of a filesystem among many on a minority operating
> system /all/ GUI programs have to be rewritten. And all command-line
> stuff. Just because.

Not rewritten; patched.  And not all programs.  Actually, most programs
would work just fine.  The Namesys people can tell you how many programs
didn't work properly when they tried out the metas directory, and how
much patching was required to get them to work properly again.  (Not
counting tar/cp/backup programs.  Everyone already knows about the
problems there.)

> Please /do/ think the above through, giving reasonable answers for
> /all/ of the operations mentioned. Tell what the advantage of all this
> would be on a multiuser operating system, when files are shared via
> the net, when files are being handled from read-only media (or
> filesystems). When different users want different metadata (I'm
> interested in the names of members of the band playing a song, you
> might want a high-resolution image of the album cover, the next guy
> wants the song's lyrics translated into swahili, all for the MP3s on
> the shared server or on the CD each of us bought separately). Consider
> the scenario where all this works only on /a very few/ machines (no
> Sun or *BSD box will have this for a very long time, and to get a
> significant fraction of just Linux systems will take some time), for
> only a limited selection of tools (existing tools will have to be
> rewritten or at least adapted, that doesn't happen overnight).

xattr is being added to most filesystems in Linux.  It doesn't work
everywhere, in all operating systems.  Programs will have to be patched
to work with it.  Does that mean that xattr is a bad idea?

> Factor in space and processing requirements for several, even
> hundreds, of concurrent users (or versions of metadata at least). How
> do you account for that? The 1 byte file with GiB of metadata where
> everybody and their pet iguana store their junk is handled how by
> quota systems?

How do you handle it now when everyone wants different information on a
song?

I don't really see what the problem is here.

Note: I'm not saying that keeping everyone's pet metadata with shared
files is a good idea.  This is your example.  The local library doesn't
allow me to make random annotations to their books, but I can do
whatever I want with my own books.

> What should happen if I email such a file with several versions of
> metadata to someone? Do they get just my metadata, or everybody's?

If I email a picture that I took to a friend, I don't send them the
whole 6 megapixel picture in RAW format.  I convert to JPEG and scale it
down.  If I email a music file that has the lyrics translated into
swahili, I can strip that bit out.  Nobody's forcing you to keep
everything.

> If I copy it to, say, a CD for safekeeping for myself?  For system
> backup purposes?  What if I copy such a file (with only my, or
> everybody's) metadata back from a backup?

You do whatever you want to do with your data.  If you want to keep the
pet iguana's metadata, go ahead.

> Or try to merge it with the version I took with my notebook on a trip,
> changing my parts while the otghers change theirs?  I'd assume all of
> those will requiere special tools, or at least flags selecting the
> right operation or some other unspecified magic, and the "simple to
> use" just went out for lunch.

So what do you do right now when you want to do something like that?
File-as-dir (or the other proposals) won't prevent you from doing that.
It just allows you more options.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

