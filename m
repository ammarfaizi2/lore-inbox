Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270464AbRIPKOg>; Sun, 16 Sep 2001 06:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270387AbRIPKO1>; Sun, 16 Sep 2001 06:14:27 -0400
Received: from Expansa.sns.it ([192.167.206.189]:9746 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S270464AbRIPKOL>;
	Sun, 16 Sep 2001 06:14:11 -0400
Date: Sun, 16 Sep 2001 12:14:25 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <otto.wyss@bluewin.ch>,
        <linux-kernel@vger.kernel.org>
Subject: Re: How errorproof is ext2 fs?
In-Reply-To: <200109160858.KAA28624@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.33.0109161205210.20434-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Sep 2001, Rogier Wolff wrote:

> Alan Cox wrote:
> > > due to an not responding USB-keyboard/-mouse (what a nice coincident). Now while
> > > the Mac restarted without any fuse I had to fix the ext2-fs manually for about
> > > 15 min. Luckily it seems I haven't lost anything on both system.
> > >
> > > This leaves me a bad taste of Linux in my mouth. Does ext2 fs really behave so
> > > worse in case of a crash? Okay Linux does not crash that often as MacOS does, so
>
> > That sounds like it behaved well. fsck didnt have enough info to safely
> > do all the fixup without asking you. Its not a reliability issue as such.
>
> Well, fsck wants to ask
>
> 	"Found an unattached inode, connect to lost+found?"
>
> to the user and will interrupt an automatic reboot for that.
>
> This is bad: The safe choice is safe: It won't cause data-loss.
>
> Maybe it should report it (say by Email), but interrupting a reboot
> just for connecting a couple of files to lost+found, that's
> rediculous.
>
> If it would give me enough information when I do this manually, I'd
> make an informed decision. However, what are the chances of me knowing
> that inode 123456 is a staroffice bak-file? So the only way to safely
> operate is to link them into lost+found, and then to look at the files
> manually.
>
That is the right way a block based FS non journaled should act in a Unix
system. Basically fsck can see inode numbers, not file names.
That is also the way UFS acts, and belive me, older UFS versions were
mutch more prone to corruptions and crashes (Solaris 8 UFS seems t make
journaling of part of meta-data, but I am not sure). In front of UFS ext2
is more than rock solid. Unattached i-nodes are just something that can
happen for this kind of filesystems.

If you want a different behaviour, like for sure many others suggested, go
to a journaled filesystem. It seems to me that you would need a filesystem
that would make journaling of both meta-data and data like ext3 or jfs,
(actually reiserFS journals just metadata)

Luigi

