Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVBLOja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVBLOja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 09:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVBLOja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 09:39:30 -0500
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:59368 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261407AbVBLOjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 09:39:16 -0500
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
From: "Richard F. Rebel" <rrebel@whenu.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com>
	 <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m/hmZmQkgQOCDMpJUi7L"
Organization: WhenU.com
Date: Sat, 12 Feb 2005 09:39:20 -0500
Message-Id: <1108219160.12693.184.camel@blue.obulous.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-1.2.101mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m/hmZmQkgQOCDMpJUi7L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hugh,

Thank you immensely for answering this so clearly.  Although it leaves
me at a short end, I am grateful I no longer have to bang my head in
this direction any further.  I have wasted a HUGE amount of time in
recent months trying to figure out why different kernel versions caused
my applications memory footprint to change so.

That said, many mod_perl users are *VERY* interested in being able to
detect and observe how "shared" our forked children are.  Shared meaning
private pages shared with children (copy on write).  Is it even possible
to do this in 2.6 kernels?  If so, any pointers would be very helpful.

Thanks again,

Richard F. Rebel

On Sat, 2005-02-12 at 13:06 +0000, Hugh Dickins wrote:
> On Fri, 11 Feb 2005, Richard F. Rebel wrote:
> >=20
> > I can't seem to find clear documentation about the 'share' column
> > from /proc/<pid>/statm.
> >=20
> > Does this include pages that are shared with forked children marked as
> > copy-on-write?
> >=20
> > Does this only reflect libraries that are dynamically loaded?  What
> > about shared memory segments/mmaps (ala shmat or mmmap)?
> >=20
> > If there is a place where I might find documentation that is more clear
> > beyond the proc.txt in the kernel docs and then man pages for procfs,
> > I'd welcome a pointer.
>=20
> You may not be entirely happy with this answer.
> It is a count of "pages of the process" which are "shared" in some sense.
> But precisely what that means has changed from time to time: depending on
> our perception of what we can safely afford the overhead of counting.
>=20
> You may want to look at fs/proc proc_pid_statm() source for the release
> of interest, and follow that back to see exactly what is being counted.
>=20
> Throughout 2.4 (and 2.2 too I think) it was the count of those pages
> instantiated in the process address space which currently have a page
> count greater than 1.  That would include private pages shared with
> forked children, pages from the pagecache (including pages mapped
> from executable or library or shared memory or file mmap), those
> private pages which currently have swap allocated (so they're also
> in the swapcache), and any pages which transitorily have page count
> raised for whatever reason (they'd likely already be in one of the
> above categories).  A ragbag of meanings, but that's all you can
> get from looking at page count.
>=20
> Counting up that not very meaningful number, at frequent intervals
> on large process address spaces, is a waste of valuable time.
>=20
> From 2.5.37 to 2.6.9, it's the total extent of file-backed areas
> (file including executable or library or shared memory) in the
> process address space: a total extent (in pagesize units),
> not a count of instantiated pages.  Much quicker to calculate.
>=20
> But there were complaints about that, and a need to revert from
> total extent to count of instantiated pages.
>=20
> From 2.6.10 onwards, for the foreseeable future, it is the count
> of those pages instantiated in the process address space which are
> shared with a file (including executable or library or shared memory)
> i.e. those pages which are not anonymous, not private.  That count
> does not include private pages shared with forked children, nor
> does it include private pages which happen to have swap allocated.
>=20
> Hugh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Richard F. Rebel <rrebel@whenu.com>
WhenU.com

--=-m/hmZmQkgQOCDMpJUi7L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCDhUYx1ZaISfnBu0RAv+9AJ4g2+E2YxeJ6hRTNiSbjb7GNlSVGQCeNdY4
n8n0spJMZyxUAjwI5Wjg+Vs=
=yl8k
-----END PGP SIGNATURE-----

--=-m/hmZmQkgQOCDMpJUi7L--

