Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWBEXPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWBEXPk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 18:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWBEXPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 18:15:40 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:28650 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750784AbWBEXPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 18:15:39 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 6 Feb 2006 09:02:44 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
References: <200602030918.07006.nigel@suspend2.net> <20060204012312.GH3291@elf.ucw.cz> <200602041451.45232.rjw@sisk.pl>
In-Reply-To: <200602041451.45232.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4936427.QhiOm8Z08v";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602060902.50386.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4936427.QhiOm8Z08v
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 04 February 2006 23:51, Rafael J. Wysocki wrote:
> Hi,
>
> On Saturday 04 February 2006 02:23, Pavel Machek wrote:
> > On So 04-02-06 02:08:33, Olivier Galibert wrote:
> > > On Sat, Feb 04, 2006 at 01:49:44AM +0100, Pavel Machek wrote:
> > > > > Why don't you try to design the system so that the progress bar
> > > > > can't fuck up the suspend unless they really, really want to?=20
> > > > > Instead of one where a forgotten open(O_CREAT) in a corner of
> > > > > graphics code can randomly trash the filesystem through metadata
> > > > > corruption?
> > > >
> > > > Even if I only put chrome code to userspace, open() would still be
> > > > deadly. I could do something fancy with disallowing syscalls,
> > >
> > > Nah, simply chroot to an empty virtual filesystem (a tmpfs with max
> > > size=3D0 will do) and they can't do any fs-related fuckup anymore.=20
> > > Just give them a fd through which request some specific resources
> > > (framebuffer mmap essentially I would say) and exchange messages
> > > with the suspend system (status, cancel, etc) and maybe log stderr
> > > for debugging purposes and that's it.  They can't do damage by
> > > mistake anymore.  They can always send signals to random pids, but
> > > that's not called a mistake at that point.
> > >
> > > Even better, you can run _multiple_ processes that way, some for
> > > compression/encryption, some for chrome, etc.
> >
> > No, I do not want to deal with multiple processes. Chrome code is not
> > *as* evil as you paint it... But yes, chroot is a nice idea. Doing
> > chroot into nowhere after freezing system will prevent most stupid
> > mistakes. Rest of userland is frozen, so it can not do anything really
> > wrong (at most you deadlock), if you kill someone -- well, that's only
> > as dangerous as any other code running as root.
>
> I like the chroot idea too.

You're making this too complicated. Just require that the userspace program=
=20
does all it's file opening etc prior to telling kernelspace to do=20
anything. Then clearly document the requirement. If someone breaks the=20
rule, it is their problem, and their testing should show their=20
foolishness. We have done a similar thing in the Suspend2 userspace user=20
interface code, and it works fine.

Regards,

Nigel

> Are we going to chroot from the kernel level (eg. the atomic snapshot
> ioctl()) or from within the suspending utility?
>
> I think the kernel level would protect some people from bugs in their
> own suspending utilities, but then we'd have to mount the tmpfs from the
> kernel level as well.
>
> Greetings,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart4936427.QhiOm8Z08v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5oQaN0y+n1M3mo0RAljHAJ9sV5LWyhzWe3GrHKiX2Y5fHcbVKgCfehoW
N2Ov9nOH09R51zuFNgIJj1w=
=gJlb
-----END PGP SIGNATURE-----

--nextPart4936427.QhiOm8Z08v--
