Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270618AbTGURBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTGURBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:01:35 -0400
Received: from ldap.somanetworks.com ([216.126.67.42]:50849 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S270618AbTGURAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:00:51 -0400
Date: Mon, 21 Jul 2003 13:15:47 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: svenud@ozemail.com.au
Cc: Andrew Morton <akpm@osdl.org>, breed@users.sourceforge.net,
       linux-kernel@vger.kernel.org, Tom Sightler <ttsig@tuxyturvy.com>
Subject: Re: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic
Message-Id: <20030721131547.45241e2e.georgn@somanetworks.com>
In-Reply-To: <1058619536.752.19.camel@localhost>
References: <1058619536.752.19.camel@localhost>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Tsqcoe/wrnLVK0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Tsqcoe/wrnLVK0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 19 Jul 2003 22:58:57 +1000
Sven Dowideit <svenud@ozemail.com.au> wrote:

> @@ -4838,7 +4850,7 @@
>         readCapabilityRid(local, &cap_rid);
>  
>         dwrq->length = sizeof(struct iw_range);
> -       memset(range, 0, sizeof(*range));
> +       memset(range, 0, sizeof(range));
>         range->min_nwid = 0x0000;
>         range->max_nwid = 0x0000;
>         range->num_channels = 14;

I suspect that this part of the patch to airo.c is incorrect.  The
intent seems to be to clear a section of memory pointed to by range that
contains (or will soon contain) a struct iw_range.  The sizeof(*range)
is equivalent of the sizeof(struct iw_range) above.  The patch reduces
the size of the memset to the size of the pointer (which I'm assuming is
smaller than the structure [/me goes and looks]).

Of course, the range pointer is derived from the char *extra
parameter...  this could mean that we're actually getting a pre-filled
iw_range and the memset is only supposed to clear the first member.  If
that's the case, I would hope that the author could come up with a
cleaner way of expressing that.

-g

--=.Tsqcoe/wrnLVK0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HB/HoJNnikTddkMRAlpYAJwK1djAB1B6gukGOD+s3/3L6JygtACfdb5O
LVGLcwkhxwWbtgZVQtLYz3k=
=EvyR
-----END PGP SIGNATURE-----

--=.Tsqcoe/wrnLVK0--
