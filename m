Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWF0I61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWF0I61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932806AbWF0I61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:58:27 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:53194 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932691AbWF0I6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:58:25 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Greg KH <greg@kroah.com>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 18:58:17 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <20060627075906.GK22071@suse.de> <20060627081252.GC7181@kroah.com>
In-Reply-To: <20060627081252.GC7181@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9376943.bcYqeLmXqz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271858.21810.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9376943.bcYqeLmXqz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 18:12, Greg KH wrote:
> On Tue, Jun 27, 2006 at 09:59:06AM +0200, Jens Axboe wrote:
> > Now I haven't followed the suspend2 vs swsusp debate very closely, but
> > it seems to me that your biggest problem with getting this merged is
> > getting consensus on where exactly this is going. Nobody wants two
> > different suspend modules in the kernel. So there are two options -
> > suspend2 is deemed the way to go, and it gets merged and replaces
> > swsusp. Or the other way around - people like swsusp more, and you are
> > doomed to maintain suspend2 outside the tree.
>
> Actually, there's a third option that is looking like the way forward,
> doing all of this from userspace and having no suspend-to-disk in the
> kernel tree at all.
>
> Pavel and others have a working implementation and are slowly moving
> toward adding all of the "bright and shiny" features that is in suspend2
> to it (encryption, progress screens, abort by pressing a key, etc.) so
> that there is no loss of functionality.
>
> So I don't really see the future of suspend2 because of this...

But what Rafael and Pavel are doing is really only moving the highest level=
 of=20
controlling logic to userspace (ok, and maybe compression and encryption=20
too). Everything important (freezing other processes, atomic copy and the=20
guts of the I/O) is still done by the kernel.

And there _is_ loss of functionality - uswsusp still doesn't support writin=
g a=20
full image of memory, writing to multiple swap devices (partitions or files=
),=20
or writing to ordinary files. They're getting the low hanging fruit, but wh=
en=20
it comes to these parts of the problem, they're going to require either smo=
ke=20
and very good mirrors (eg the swap prefetching trick), or simply refuse to=
=20
implement them.

If we take the problem one step further, and begin to think about=20
checkpointing, they're in even bigger trouble. I'll freely admit that I'd=20
have to redesign the way I store data so that random parts of the image cou=
ld=20
be replaced, have hooks in mm to be able to learn what pages need have=20
changed and would also need filesystem support to handle that part of the=20
problem, but I'd at least be working in the right domain.

I don't want to demean Rafael and Pavels' work for a moment. I've benefited=
=20
from Pavel's help of Gabor in the beginning, and a little bit since he fork=
ed=20
and merged in 2.5. But it seems to me that uswsusp is a short trip down a=20
dead end road. It just doesn't have a future beyond being an interesting ha=
ck=20
that proves you can safely run a program in userspace while snapshotting.=20
Suspending to disk belongs in the kernel. That is shown clearly by the fact=
=20
that uswsusp continues to use kernel code to do the really critical tasks,=
=20
rather than being some super privileged userspace program that does them=20
itself from userspace.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart9376943.bcYqeLmXqz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoPMtN0y+n1M3mo0RAordAKC4+0OGANEebwo8KdDVmELFlldQzgCg5NCQ
9z0klf2zBhltVF9CnBGL4Tc=
=LzWm
-----END PGP SIGNATURE-----

--nextPart9376943.bcYqeLmXqz--
