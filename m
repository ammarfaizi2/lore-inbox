Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbTJOPjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTJOPjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:39:23 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:55249 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263442AbTJOPjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:39:20 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: William Lee Irwin III <wli@holomorphy.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: mem=16MB laptop testing
Date: Wed, 15 Oct 2003 17:38:45 +0200
User-Agent: KMail/1.5.9
Cc: Larry Sendlosky <lsendlosky@katana-technology.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20031014105514.GH765@holomorphy.com> <20031015132824.GS16158@holomorphy.com> <3F8D52CD.2000909@katana-technology.com>
In-Reply-To: <3F8D52CD.2000909@katana-technology.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_PoWj/ElAOCNb5Y3";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310151738.55113.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_PoWj/ElAOCNb5Y3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Well, as davej submitted his patch he seems to just have missed a Changeset=
=20
applied to the 2.4 tree...:

ChangeSet@1.404.2.2  2002-05-06 21:30:10-03:00  hch@infradead.org
[PATCH] memsetup fixes (again)

The mem=3D fixes from Red Hat's tree had a small bug:
if mem=3D was not actually used with the additional features, but
int plain old way, is used the value as the size of memory it
wants, not the upper limit.  The problem with this is that there
is a small difference due to memory holes.

I had one report of a person using mem=3D to reduce memory size for
a broken i386 chipset thaty only supports 64MB cached and the rest
as mtd/slram device for swap.  I got broken as the boundaries changed.

arch/i386/kernel/setup.c@1.42  2002-04-23 18:52:12-03:00  hch@infradead.org

So obviously this should be fixed in the 2.6 tree too!

Regards
   Thomas

P.S.: How can be assured that fixes for the 2.4 tree get into the 2.6 tree=
=20
when they are needed there, too? I'd wonder if this missed CS is the only=20
one...

On Wednesday 15 October 2003 15:59, Larry Sendlosky wrote:
> Changeset 1.403.15.8 2002/6/05 davej@suse.de
> [PATCH] large x86 setup cleanup.
>
> Patrick Mochel did a great job here at splitting up some of the larger
> messy parts of arch/i386/kernel/setup.c, and introduced a nice abstraction
> which gives us a much nicer way to ensure we can add workarounds for vend=
or
> specific bugs / features without polluting other vendor code paths.
>
> Mark Haverkamp also brought this up to date for merging in my tree circa
> 2.5.14, and asides from 1-2 now fixed small thinkos, there haven't been
> any problems.
>
> This also features a workaround for an errata item on stepping C0 of
> the Intel Pentium 4 Xeon, which isn't in your tree yet, where we must
> disable the hardware prefetcher to ensure sane operation.
>
> arch/i386/kernel/setup.c 1.41.1.16 2002/06/03 10:10:19 davej@suse.de
> large x86 setup cleanup.
>
> William Lee Irwin III wrote:
> >On Wed, Oct 15, 2003 at 03:20:54PM +0200, Pavel Machek wrote:
> >>Do you want to say that calculation is different, already? We should
> >>probably make 2.5 version match 2.4 version, that's what users
> >>expect. Who changed it and why?
> >
> >No idea when it changed, but I was at least duly disturbed by the tiny
> >384KB ZONE_NORMAL materializing out of thin air when I booted mem=3D16m.

--Boundary-02=_PoWj/ElAOCNb5Y3
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/jWoPYAiN+WRIZzQRAsLrAKDZqQicz36OjLZyF0ilUc7ngW01sgCfS0Dk
h9zApNF0xkaHX9yO9pI7U0Q=
=md3t
-----END PGP SIGNATURE-----

--Boundary-02=_PoWj/ElAOCNb5Y3--
