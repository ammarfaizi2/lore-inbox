Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312386AbSDJB4i>; Tue, 9 Apr 2002 21:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312392AbSDJB4h>; Tue, 9 Apr 2002 21:56:37 -0400
Received: from lnx00.cecm.usp.br ([143.107.90.10]:4104 "HELO lnx00.cecm.usp.br")
	by vger.kernel.org with SMTP id <S312386AbSDJB4g>;
	Tue, 9 Apr 2002 21:56:36 -0400
Date: Tue, 9 Apr 2002 22:58:54 -0300
From: "Alexis S. L. Carvalho" <alexis@cecm.usp.br>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020409225854.A15883@cecm.usp.br>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409184605.A13621@cecm.usp.br> <200204100041.g3A0fSj00928@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Editor: Vim-601 http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks for your comments.

Thus spake Albert D. Cahalan:
> Alexis S. L. Carvalho writes:
> 
> > Does anyone know of any implementation of soft-updates
> > over ext2? I'm starting a project on this for grad school,
> > and I'd like to know of any previous (current?) efforts.
> 
> That's interesting. Some comments:
> 
> It is common for controllers, RAID arrays, and the disks to
> mess up your ordering. Power failure during a write has been
> known to scribble on random unrelated parts of the disk.
> Power failure often creates bad sectors that can only be
> fixed by a large write that covers the affected area.

OK, but if something scribbles on random unrelated parts of the disk
there's not much you can do besides praying that fsck will fix it.

> Ext2 has deletion time stamps. These are not really good for
> performance, but they help fsck to know what is going on.
> 
> While ext2 fsck doesn't guarantee anything, in practice it is far
> more reliable than ufs fsck. If you change the algorithms to be
> like those used by BSD, then you may lose some of the ability to
> recover. Remember, fsck isn't just for power failures. It tries
> to piece together a filesystem that has suffered disk corruption
> caused by attackers, kernel bugs, fdisk screwups, MS-DOS writing
> past the end of a partition, Windows NT Disk Manager, viruses,
> disk head crashes, and every other cause you can imagine. If you
> change fsck to make BSD-style assumptions about write ordering,
> you weaken the ability to deal with disasters.

I haven't looked into e2fsck yet, but if/when I get to it, I'll probably
add a mode that makes some assumptions about the disk state. If you
don't explicitly ask for this mode, you get the current behavior.

Also, this mode would only be run during the boot sequence under a
specific situation (the system crashed while running with soft-updates).
Note that if you were running a journalling fs, fsck wouldn't be run at
all.

> I'm sure you are aware of ext3. You should also be aware of tux2.

I read some stuff about tux2 a couple of years ago, but I do have to
re-read it all...

> Soft-updates are mainly useful for OS wars. Lots of FUD comes
> flying out of the BSD camp. Ext2 horror stories are rare
> when you consider just how many millions of users ext2 has.

Well, I found soft-updates pretty interesting, and I want to play a bit
with it. Anyway, given my (lack of) experience with kernel programming I
don't believe I'll have anything useful for some time yet...

> In case you are still thinking about what to do, here are a
> few filesystem ideas that you might like:
<nice list of fs projects>

hmm... I guess I find soft-updates sexy enough... :-)

Thanks

Alexis
