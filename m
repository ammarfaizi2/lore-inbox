Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSFIWFY>; Sun, 9 Jun 2002 18:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSFIWFX>; Sun, 9 Jun 2002 18:05:23 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:35599 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315267AbSFIWFV>;
	Sun, 9 Jun 2002 18:05:21 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206092205.g59M571515016@saturn.cs.uml.edu>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
To: nmiell@attbi.com (Nicholas Miell)
Date: Sun, 9 Jun 2002 18:05:07 -0400 (EDT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        adelton@informatics.muni.cz (Jan Pazdziora), christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <1023658610.1518.12.camel@entropy> from "Nicholas Miell" at Jun 09, 2002 02:36:49 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell writes:
> On Sun, 2002-06-09 at 13:53, Albert D. Cahalan wrote:
>> Nicholas Miell writes:

>>> First of all, some programs (WINE) will actually want
>>> to use the .lnk files, and transparently converting
>>> them to symlinks will complicate that.
>>
>> WINE needs to be able to handle a symlink on ext2, so it can
>> damn well convert back. It's OK to give WINE some hack to get at
>> the content; it's not OK to hack bash to interpret .lnk files.
>
> Why would bash even want to interpret shortcut files?

Some of the shortcut files are symlinks. Of course
this is disgusting, since bash shouldn't have to be
aware of the underlying filesystem type. One would
have to add disgusting hacks to many programs,
including: ln tar mc cpio

> They're a proprietary,
> Windows-only format

...like vfat itself. You might as well argue for ripping
that out and using a userspace solution like mtools.

> Hacking the filesystem to treat something that
> fundamentally is not a symlink as a symlink

Symlinks are implemented, poorly, as .lnk files.
I don't care if you wish it weren't so. Microsoft
doesn't care either.

>>> More importantly, shortcuts are a hell of a lot more complicated than
>>> has been implied. Not only can they point to local files or UNCs (the
>>> \\server\share\path notation), they can also point to any object in the
>>> (Windows) shell's namespace, which includes lots of virtual objects that
>>> don't actually exist on disk.
>>
>> One can live with an occasional broken symlink:
>> "foo" --> "[UNIMPLEMENTED LINK TYPE]"
>
> One can also live with "foo.lnk". (It's much easier and saner, too.)

It's also unusable from common UNIX tools.

>>> Finally, I haven't seen any justification for why symlinks on VFAT are
>>> needed, beyond some vague statements that it's useful when dual booting.
>>> Face it, VFAT isn't a Unix filesystem and introducing ugly hacks to make
>>> it more similar to one will only cause problems in the long run. If you
>>> want symlinks, use a real filesystem or use umsdos on your favorite FAT
>>> filesystem. (Assuming that umsdos still works...).
>>
>> [ insane abuse of VFAT for multi-user systems ]
>
> You're not serious, right?

I'm very serious. The ability to install without partitioning
is important for hesitant new users.

Why not? The system might feel "unclean" to you, but it's
great for converting the Windows users. Not many people
are willing to trash their one-and-only partition, full of
data, to experiment with a new OS. Regular users don't
keep backups. Linux is the only UNIX-like OS that could
do a respectable job of running multi-user on vfat.


