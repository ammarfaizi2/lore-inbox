Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWEKXuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWEKXuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWEKXuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:50:44 -0400
Received: from CPE-60-226-94-173.qld.bigpond.net.au ([60.226.94.173]:4229 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750835AbWEKXun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:50:43 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Fri, 12 May 2006 09:49:42 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
References: <200605021200.37424.rjw@sisk.pl> <200605110058.19458.rjw@sisk.pl> <20060511113519.GB27638@elf.ucw.cz>
In-Reply-To: <20060511113519.GB27638@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1645266.NK3eb6zrri";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605120949.47046.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1645266.NK3eb6zrri
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 11 May 2006 21:35, Pavel Machek wrote:
> On =C4=8Ct 11-05-06 00:58:18, Rafael J. Wysocki wrote:
> > On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > Now if the mapped pages that are not mapped by the
> > > >  current task are considered, it turns out that they would change
> > > > only if they were reclaimed by try_to_free_pages(). =C2=A0Thus if w=
e take
> > > > them out of reach of try_to_free_pages(), for example by
> > > > (temporarily) moving them out of their respective LRU lists after
> > > > creating the image, we will be able to include them in the image
> > > > without copying.
> > >
> > > I'm a bit curious about how this is true.  There are all sorts of way
> > > in which there could be activity against these pages - interrupt-time
> > > asynchronous network Tx completion, async interrupt-time direct-io
> > > completion, tasklets, schedule_work(), etc, etc.
> >
> > AFAIK, many of these things are waited for uninterruptibly, and
> > uninterruptible
>
> Well, "many of these things" makes me nervous.
>
> > tasks cannot be frozen.  Theoretically we may have a problem if there's
> > an interruptible task that waits for the completion of an operation that
> > gets finished after snapshotting the system.
>
> I'd prefer not to have even theoretical problems. If we don't _know_
> why patch is safe, I'd prefer not to have it.
>
> Needing bdev freezing is bad sign, too.
>
> We are talking 10% speedup here (on low-mem-machines, IIRC), but whole
> design has just got way more complex. Previous snapshot was really
> atomic, and apart from NMI, it was "independend" from the rest of the
> system.
>
> New design depends on bdev freezing (depending on XFS details we do
> not understand), and depends on all the other parts of kernel using
> uninteruptible (when we know that networking sleeps interruptibly).
>
> Too much uncertainity for 10% speedup, I'm afraid. Yes, it was really
> clever to get this fundamental change down to few hundred lines, but
> design complexity remains. Could we drop that patch?

Could you provide justification for your claim that the speedup is only 10%?

Please also remember that you are introducing complexity in other ways, wit=
h=20
that swap prefetching code and so on. Any comparison in speed should includ=
e=20
the time to fault back in pages that have been discarded.

Regards,

Nigel

--nextPart1645266.NK3eb6zrri
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEY82aN0y+n1M3mo0RAql8AJ0c0yP0wbjpwAbQZM4IS9pfZkLCegCeP0a8
M+AlvGbm976haw8Q0MnXVTI=
=n35S
-----END PGP SIGNATURE-----

--nextPart1645266.NK3eb6zrri--
