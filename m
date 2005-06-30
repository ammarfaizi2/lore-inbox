Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVF3TBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVF3TBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVF3TBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:01:04 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:35556 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261517AbVF3TAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:00:53 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <20050630171057.GT16867@khan.acc.umu.se> (David Weinehall's
 message of "Thu, 30 Jun 2005 19:10:57 +0200")
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>
	<8783be6605062914341bcff7cb@mail.gmail.com>
	<42C3615A.9020600@namesys.com> <871x6kv4zd.fsf@evinrude.uhoreg.ca>
	<20050630062956.GP16867@khan.acc.umu.se>
	<87psu3vnvc.fsf@evinrude.uhoreg.ca>
	<20050630171057.GT16867@khan.acc.umu.se>
X-Hashcash: 1:23:050630:reiser@namesys.com::hn/XQSwN86a7J1Hw:0000000000000000000000000000000000000000000A/jr
X-Hashcash: 1:23:050630:vonbrand@inf.utfsm.cl::KCi+3D36MY/VFVwF:0000000000000000000000000000000000000000odOV
X-Hashcash: 1:23:050630:mrmacman_g4@mac.com::eb/rh9Xd0ngCQ3vB:000000000000000000000000000000000000000003A5RA
X-Hashcash: 1:23:050630:ninja@slaphack.com::dUSAKYH6fzQprMlp:00000000000000000000000000000000000000000001Uez
X-Hashcash: 1:23:050630:valdis.kletnieks@vt.edu::5osS144qVKGW0i1T:00000000000000000000000000000000000000Mlcf
X-Hashcash: 1:23:050630:ltd@cisco.com::my/AJjZScz2LN0Jo:0000MycY
X-Hashcash: 1:23:050630:gmaxwell@gmail.com::z2OVvGa0vqqcVLtk:0000000000000000000000000000000000000000000L59o
X-Hashcash: 1:23:050630:jgarzik@pobox.com::noxvCUOpOVTjYFst:0000000000000000000000000000000000000000000083su
X-Hashcash: 1:23:050630:hch@infradead.org::YZJiN8kUAq8jZEaQ:00000000000000000000000000000000000000000000dIGH
X-Hashcash: 1:23:050630:akpm@osdl.org::2etNqY6mDJwy37J/:0000BWuw
X-Hashcash: 1:23:050630:linux-kernel@vger.kernel.org::G2+S9AD74GA9DgsW:000000000000000000000000000000000XFP9
X-Hashcash: 1:23:050630:reiserfs-list@namesys.com::f9iftLGHqR6pZIzo:000000000000000000000000000000000000lPcf
Date: Thu, 30 Jun 2005 15:00:43 -0400
Message-ID: <87ll4rvfdw.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at minos with ID 42C44141.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005 19:10:57 +0200, David Weinehall <tao@acc.umu.se> said:

> For the analogy to be complete:

> User has a file browser (say Nautilus)
> The file browser sees the userland VFS (say a unified VFS between
> GNOME and KDE)
> The VFS sees the real file system

I would say that this only works if everyone is forced to use the same
VFS.  In the web example, everyone is forced to use the same API (HTTP),
and so everyone gets the same view.  For the real filesystem, not
everyone is forced to use the hypothetical unified GNOME/KDE VFS.  So if
I try to edit with gedit or kate, I get something different than if I
try to edit with vi or emacs.

As I see it:
web browser <-> Nautilus/user apps
web server <-> filesystem
web server's filesystem/database/etc. <-> physical disk storage

Of course, we all know that analogies are not perfect.  The layering in
both sides isn't exactly the same.  And other people could assign
different equivalences (e.g. web browser <-> Nautilus/user apps; web
server <-> VFS; web server's filesystem <-> filesystem).

Anyways, the analogy wasn't supposed to be about where to handle the
magic extra functionality, whether userspace or kernel space.  The
analogy was for people who might think that it's stupid to return
foo/.data when the user tries to open the directory foo; it was meant to
illustrate that that idea isn't completely braindead.

> This way the userland VFS can be ported to almost any platform.

I think GNOME and KDE will always need a VFS if it wants to be
cross-platform.  But I think that if the kernel provides extra
functionality, GNOME may be better off.  For example, glib provides its
own threading abstraction.  But on systems that use pthreads, glib's
threading library uses it for its implementation.  And I think it can
even be used on systems that don't offer threading, by doing its own
emulation of threading.

> When toying around on the desktop, an abstraction of what a file is
> works fine with me.  When doing serious work (programming, tar:ing up
> stuff, etc) I want to be bloody sure that I see the files in the same
> way always.  I don't want surprises such as files suddenly behaving as
> directories or vice versa.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

