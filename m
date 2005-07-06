Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVGFBRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVGFBRC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 21:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVGFBRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 21:17:01 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:141 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262026AbVGFBQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 21:16:50 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: "Alexander G. M. Smith" <agmsmith@rogers.com>
Cc: ross.biro@gmail.com, vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com,
       Valdis.Kletnieks@vt.edu, ltd@cisco.com, gmaxwell@gmail.com,
       jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <1740726161-BeMail@cr593174-a> (Alexander G. M. Smith's message
 of "Tue, 05 Jul 2005 20:50:08 -0400 EDT")
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a>
X-Hashcash: 1:23:050706:agmsmith@rogers.com::VfTVPQQ0CulmvAtE:000000000000000000000000000000000000000000E7Jb
X-Hashcash: 1:23:050706:ross.biro@gmail.com::cHdvJQwm153POEvy:000000000000000000000000000000000000000000H0uf
X-Hashcash: 1:23:050706:vonbrand@inf.utfsm.cl::FzRQn6zwR56yC4nG:0000000000000000000000000000000000000000m/AB
X-Hashcash: 1:23:050706:mrmacman_g4@mac.com::A1W6vcVrD0H1SYYp:000000000000000000000000000000000000000000HWNk
X-Hashcash: 1:23:050706:valdis.kletnieks@vt.edu::JtYHAuqP/1Huffcx:00000000000000000000000000000000000000dgJh
X-Hashcash: 1:23:050706:ltd@cisco.com::dMo0JFbiuTk9DxJo:0000H27U
X-Hashcash: 1:23:050706:gmaxwell@gmail.com::8/pDn7H2QTkrlGUA:0000000000000000000000000000000000000000001dMJR
X-Hashcash: 1:23:050706:jgarzik@pobox.com::2iK51E9rTqqkbDOY:00000000000000000000000000000000000000000000Bqc4
X-Hashcash: 1:23:050706:hch@infradead.org::+vrY8+RBCs5N1tiQ:000000000000000000000000000000000000000000002dGN
X-Hashcash: 1:23:050706:akpm@osdl.org::V2FePIxi75NjSSTU:0000SST9
X-Hashcash: 1:23:050706:linux-kernel@vger.kernel.org::c0LPGoglPFLVovfs:0000000000000000000000000000000003lRy
X-Hashcash: 1:23:050706:reiserfs-list@namesys.com::cQh02zmH0uZCl96l:000000000000000000000000000000000000EAH4
X-Hashcash: 1:23:050706:zam@namesys.com::VP0O7mPGmUzx51y/:00H0tp
X-Hashcash: 1:23:050706:vs@thebsh.namesys.com::0W50KT7GvS8uZ1Ws:0000000000000000000000000000000000000001BX+A
X-Hashcash: 1:23:050706:ndiller@namesys.com::Ri4zyDh15ZiFLkwz:000000000000000000000000000000000000000001ZNtF
X-Hashcash: 1:23:050706:ninja@slaphack.com::+g5w4kc+fvjuVJWX:0000000000000000000000000000000000000000000ZM9z
Date: Tue, 05 Jul 2005 21:16:21 -0400
Message-ID: <87hdf8zqca.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Tue, 05 Jul 2005 21:16:37 -0400 (EDT)
X-Miltered: at minos with ID 42CB308C.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2005 20:50:08 -0400 EDT, "Alexander G. M. Smith" <agmsmith@rogers.com> said:

> That sounds equivalent to no hard links (other than the usual parent
> directory one).  If there's any directory with two links to it, then
> there will be a cycle somewhere!

What we want is no directed cycles.  That is A is the parent of B is the
parent of C is the parent of A.  We don't care about A is the parent of
B is the parent of C; A is the parent of B is the parent of C.

OK, here's a random idea that just popped into my head, and to which
I've given little thought (read: none whatsoever), and may be the
stupidest idea ever proposed on LKML, but thought I would just toss it
out to see if it could stimulate someone to come up with something
better (read: sane):  Conceptually, foo/.... is just a symlink to
/meta/[filesystem]/[inode of foo].

And a question: is it feasible to store, for each inode, its parent(s),
instead of just the hard link count?

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

