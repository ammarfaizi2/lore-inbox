Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWBSVMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWBSVMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWBSVMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:12:37 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:33428 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932178AbWBSVMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:12:36 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 07:09:14 +1000
User-Agent: KMail/1.9.1
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz>
In-Reply-To: <20060218142610.GT3490@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1329192.vK9RiKkKQV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602200709.17955.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1329192.vK9RiKkKQV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 19 February 2006 00:26, Pavel Machek wrote:
> Hi!
>
> Thanks for a fresh air in this flamewar...
>
> > I have to completly agree with Sebastian here. 16 months ago I was in
> > the need to have a suspend mode running on my new notebook. Back then
> > Suspend 2 was the only choice, and while it had still problems it was
> > surprisingly well behaving (in contrast to S3 mode and the mainline
> > swsusp). The support of the community was, as said above, very good, and
> > most issues very fixed fast.
>
> Can you test recent swsusp?
>
> > Since it worked good for me, I started to contribute by supplying Fedora
> > patched kernels, helper packages and some documentation. Today on
> > Fedora, it is as easy as installing 4 RPM-packages and adding the
> > "resume2=3D" parameter to the kernel commandline, and I know that it wo=
rks
> > this well on several other distributions too.
>
> ...well, thanks for your good work.
>
> > Some more numbers: judging from my access logs and the feedback I get, I
> > suspect at least 2000 Fedora users using Suspend 2 on a regular basis
> > with success. Listening to the IRC channel and reading the forums and
> > wikis, I see a huge bunch of people using Suspend 2 on nearly every
> > distribution. The problems are incredible low, mostly minor things that
> > get fixed nearly instantly.
>
> Well, at least Fedora and SuSE ship swsusp by default. So it is getting
> huge ammount of testing, too.
>
> > Some pros of Suspend 2 from my view:
> > - it is reliable and stable (really!)
> > - it is fast (10-30 seconds on my notebook with 1280 MB ram, depending
> >   on how much caches are saved)
> > - it can save all buffers and caches and the system is instantly
> >   responsible after resume (even Windows cannot do this and is very slow
> >   the first minute after resume)
> > - it works on all major platforms (x86, SMP, x86_64, there were success
> >   reports for PPC, and I believe even ARM works)
> > - and the most important thing, as already said, it is available _today_
>
> swsusp is also available today, and works better than you think. It is
> slightly slower, but has all the other
> features you listed in 2.6.16-rc3.

It is a lot slower because it does all it's I/O synchronously, doesn't=20
compress the image and throws away memory until at least half is free.

> > The only con I see is the complexity of the code, but then again, Nigel
>
> ..but thats a big con.

It's fud. Hopefully as I post more suspend2 patches to LKML, people will se=
e=20
that Suspend2 is simpler than what you are planning.

> > Again, you said the code is complex, it might be, but still most part of
> > the code is completly seperate from the rest of the kernel, and only
> > touches minor things (and Nigel is still working on that). I believe it
> > would not hurt.
>
> It would hurt at least me, Andrew and Linus... It would make lot
> of suspend2 users very happy...

Pavel, you're very good at making general hand waving statements, but terri=
ble=20
at backing them up with facts, specifics or technical arguments. Could you=
=20
please do some more of the later?

> > From a user, and contributor, point of view, I really do not understand
> > why not even trying to push a working implementation into mainline (I
> > know that you cannot just apply the Suspend 2 patches and shipping it,
>
> It is less work to port suspend2's features into userspace than to make
> suspend2 acceptable to mainline. Both will mean big changes, and may
> cause some short-term problems, but it will be less pain than
> maintaining suspend2 forever. Please help with the former...

That's not true. I've taken time to look at what would be involved in makin=
g=20
suspend2 match the changes you're doing, and I've decided it's just not wor=
th=20
the effort.

Let's be clear. uswsusp is not really moving suspend-to-disk to userspace.=
=20
What it is doing is leaving everything but some code for writing the image =
in=20
kernel space, and implementing ioctls to give a userspace program the abili=
ty=20
to request that other processes be frozen, the snapshot prepared and so on.=
=20
Pages in the snapshot are copied to userspace, possibly compressed or=20
encrypted there in future, then fed back to kernel space so it can use the=
=20
swap routines to do the writing. Very little of substance is being done in=
=20
userspace. In short, all it's doing is adding the complexity of always=20
requiring a userspace program, an initrd/ramfs, kernel routines to (1) expo=
rt=20
the snapshot to userspace  (2) receive pages to be written, and (3) let=20
userspace initiate the real work. It adds the complexity you complain about=
,=20
but with no addition in functionality or usability.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1329192.vK9RiKkKQV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+N59N0y+n1M3mo0RAltUAJ4t5+G47dCwuEJ9O2rY+UxuxV3u+ACfQTBc
d0YUTa2joQBJePvq+jBWYPk=
=95qS
-----END PGP SIGNATURE-----

--nextPart1329192.vK9RiKkKQV--
