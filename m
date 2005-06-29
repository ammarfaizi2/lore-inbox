Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVF2XaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVF2XaC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVF2XaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:30:02 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:54673 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262729AbVF2X3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:29:42 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Ross Biro <ross.biro@gmail.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <8783be6605062914341bcff7cb@mail.gmail.com> (Ross Biro's
 message of "Wed, 29 Jun 2005 17:34:41 -0400")
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>
	<8783be6605062914341bcff7cb@mail.gmail.com>
X-Hashcash: 1:23:050629:ross.biro@gmail.com::56FUPdSly+TvmrbG:000000000000000000000000000000000000000000ANYf
X-Hashcash: 1:23:050629:vonbrand@inf.utfsm.cl::7xSrBgdBfC+4yG1q:0000000000000000000000000000000000000000d1/0
X-Hashcash: 1:23:050629:mrmacman_g4@mac.com::/MP4kak3Ckvi+GOy:000000000000000000000000000000000000000000i5mL
X-Hashcash: 1:23:050629:ninja@slaphack.com::mypDLFChzZAeCw3E:0000000000000000000000000000000000000000000AVR/
X-Hashcash: 1:23:050629:valdis.kletnieks@vt.edu::wPUeJer0LopUrwXJ:00000000000000000000000000000000000000EjUY
X-Hashcash: 1:23:050629:ltd@cisco.com::X0d2AE+czUkGzUEk:0000BLa8
X-Hashcash: 1:23:050629:gmaxwell@gmail.com::RcsVN5N39BaQkEaf:0000000000000000000000000000000000000000002tnnd
X-Hashcash: 1:23:050629:reiser@namesys.com::HM1xdrBGOWmkW3jj:0000000000000000000000000000000000000000000KxZO
X-Hashcash: 1:23:050629:jgarzik@pobox.com::twbW6g0PMjY1w9IJ:00000000000000000000000000000000000000000001d3jV
X-Hashcash: 1:23:050629:hch@infradead.org::FT43+eR0vXrLT3hS:00000000000000000000000000000000000000000000Ewk8
X-Hashcash: 1:23:050629:akpm@osdl.org::JpOwkY8buF63DiRC:0000a45o
X-Hashcash: 1:23:050629:linux-kernel@vger.kernel.org::Wqnpr4TIfvFMjNAO:000000000000000000000000000000001QWbB
X-Hashcash: 1:23:050629:reiserfs-list@namesys.com::+Fa+hago1KzB/4H8:000000000000000000000000000000000000l/y4
Date: Wed, 29 Jun 2005 19:29:30 -0400
Message-ID: <878y0svj1h.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42C32F18.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 17:34:41 -0400, Ross Biro <ross.biro@gmail.com> said:

> I'm confused.  Can someone on one of these lists enlighten me?

> How is directories as files logically any different than putting all
> data into .data files and making all files directories (yes you would
> need some sort of special handling for files that were really called
> .data).  Then it's just a matter of deciding what happens when you
> call open and stat on one of these files?

Logically, I don't think there is a difference. A filesystem that
doesn't support file-as-dir could implement the same functionality that
way. [1]  In fact, that's essentially what MacOS X/NeXTSTEP does with its
bundle format -- it's just a regular directory with regular files
inside.  The Reiser4 implementation would probably look very similar to
that structurally, except that since it understands file-as-dir, it
doesn't need to use the .data name, and it should still know where to
find it.  (Of course, I'm not a Reiser4 developer, and I don't speak for
them.)

[1] (Well, except that file-as-dir as some people would like it to
operate, can do a whole lot of other magic.  (e.g. transparent compress,
etc.  In Reiser4, it's also supposed to allow an interface to filesystem
stuff so that you can manipulate parameters such as whether it should
use the cryptocompress plugin for that file.)  But I think this is a
sort of separate issue.)

> For backwards compatibility, current existing system calls have to
> treat these things as directories.  Perhaps an exception could be made
> for exec.

Which makes the system really quite ugly.  I certainly wouldn't enjoy
having to type "$EDITOR foo.txt/.data" instead of "$EDITOR foo.txt".  If
you want to introduce new system calls, you would have to patch all the
programs pretty much overnight in order for the system to be useful.  It
also makes portability a big pain if you want to support systems that
don't offer the same system calls.

You also get a chicken-and-egg problem.  Application developers don't
patch their programs because nobody's using the system.  Nobody's using
the system because no applications support it.

> But we could have a whole new set of system calls that treat things as
> magic, and if files as directories is as cool as many people think,
> apps will start using the new api.  If not, they won't and the new api
> can be deprecated.

File-as-dir doesn't require new system calls (that I know of), which is
the whole point of the idea.  Existing programs can edit the strange new
attributes without being modified.

The main thing blocking file-as-dir is that there are some
locking(IIRC?) issues.  And, of course, some people wouldn't want it to
be merged into the mainline kernel.  (Of course, the latter doesn't
prevent Namesys from maintaining their own patches for people to play
around with.)

I would like to see file-as-dir so that we can try it out to see if it's
as useful as some of us think it is.  It might be less useful than I
expect, or it could exceed my expectations and someone might come up
with some killer use for it, once we can start playing with it.  And I
think it would be nice if it was merged into mainline so that it gets
more exposure, and we have more people trying it out.

People like Horst (and probably others, who are less vocal), I think,
don't think that it's even worth trying it out because they don't see
any major advantages.  Or at least they think that the potential
negatives outweigh the potential positives.  I respect that they have
different opinions, but I of course disagree and attempt to convince
them otherwise.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

