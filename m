Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUEDIwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUEDIwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUEDIwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:52:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24980 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264275AbUEDIwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:52:07 -0400
Date: Tue, 4 May 2004 10:50:51 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, peter@mysql.com, linuxram@us.ibm.com,
       alexeyk@mysql.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-ID: <20040504085051.GA24498@devserv.devel.redhat.com>
References: <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org> <1083615727.7949.40.camel@localhost.localdomain> <20040503135719.423ded06.akpm@osdl.org> <1083620245.23042.107.camel@abyss.local> <20040503145922.5a7dee73.akpm@osdl.org> <4096DC89.5020300@yahoo.com.au> <20040503171005.1e63a745.akpm@osdl.org> <1083659274.3844.2.camel@laptop.fenrus.com> <20040504014729.72b9220a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20040504014729.72b9220a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 04, 2004 at 01:47:29AM -0700, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> > 
> > > 
> > > That would cause the kernel to perform lots of pointless pagecache lookups
> > > when the file is already 100% cached.
> > 
> > well surely the read itself will do those AGAIN anyway, so in the fully
> > cached case this is just warming up the cpu cache ;)  (and thus really
> > cheap as nett cost I suspect)
> 
> Probably true for x86, but the cost is noticeable on ppc64, for example. 
> Anton fixed some things in there shortly after it went in, but it's still
> apparent on profiles.

well do the profiles also show that the actual later lookup becomes near
free due to a warm cpu cache?

> 
> We could perhaps speed things up a little bit by using gang lookup in both
> __do_page_cache_readahead() and in do_generic_file_read().

or go into the readahead path only when the first miss occurs; for the fully
cached case you can then avoid the cost while when you're doing IO, well, a
few premature cache misses...


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAl1lrxULwo51rQBIRAszxAJ96P1PxjW7ltkOyhKFJcOJrUf4cnACfcz/q
ej526LJ40j+wykofzL6peX8=
=EQUb
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
