Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263230AbTCTXEg>; Thu, 20 Mar 2003 18:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbTCTXEg>; Thu, 20 Mar 2003 18:04:36 -0500
Received: from marc2.theaimsgroup.com ([63.238.77.172]:13320 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S263230AbTCTXCh> convert rfc822-to-8bit; Thu, 20 Mar 2003 18:02:37 -0500
Date: Thu, 20 Mar 2003 18:14:53 -0500 (EST)
From: Hank Leininger <hlein@progressive-comp.com>
X-X-Sender: Hank Leininger <hlein@progressive-comp.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
In-Reply-To: <20030320221332.GA13641@wohnheim.fh-wedel.de>
Message-ID: <010303201736060.23184-100000@timmy.spinoli.org>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 20 Mar 2003, [iso-8859-1] Jörn Engel wrote:

> On Thu, 20 March 2003 16:54:13 -0500, Hank Leininger wrote:
> > On 2003-03-20, Joern Engel <joern () wohnheim ! fh-wedel ! de> wrote:
> >
> > A few come to mind:
>
> "Come to mind" doesn't sound line "that'd break our environment." ;)

Well, no ;)  But I could see how they might break some, and/or would
cause real problems even though they wouldn't be insurmountable ones.

> > -To verify and then use a .tar.[bg]z2?, you must gpg --verify and then
> >   tar -x[jz]vf, but to unpack, then verify, then use you must uncompress
> >   to a tempfile or pipe to gpg, then verify, then untar.  Silly waste of
> >   CPU and/or disk space.[*]
>
> Veryfy and use are two action. You need a script or a human, changing
> either one won't be hard.

Right, but if the uncompressed file is what's signed, then you must
waste either CPU uncompressing twice (once to verify, once to untar) or
waste disk (to store the uncompressed file, then verify, then untar).

> > -Verifying downloads immediately, when they won't necessarily be needed /
> >   used right away; no need to unpack until it's needed, but would like to
> >   know the download is bad right away.
>
> real-world?

Sure.  You're net-connected only intermittantly, and want to verify
downloads as soon as you get them, so you can re-get before
disconnecting.  Or you're pulling files down to burn to CD, you'd like
to know if they are bad before you've burned the CD and try to use it
elsewhere; unpacking just to verify is a waste.

> > -Verifying something pulled down to one machine before scp'ing it elsewhere
> >   where it will actually be used.
>
> real-world?

Sure.  Fits same as above.  Say you pull stuff down to a somewhat
central internal repository and then push it out to several other boxes,
which may themselves have no generalized external connectivity (no
default routes, behind firewalls, running local firewalling, etc).
You'd want to verify it there and then (perhaps in addition to at the
final destination depending on how paranoid you are) and then push it
around, still compressed, or you're wasting work.

Hell, here's an easy example: the kernel.org mirror sites.  I don't know
for sure if any of them --verify the tarball+sig files that they mirror,
but it sure would make a lot of sense.  With signatures of the
compressed tarballs, that would be trivial.  With signatures of the .tar
files, it would be far more resource-intensive for them to implement.

Another flavor I hit personally is: I want to hack on and/or upgrade my
laptop to some new version of something while on a flight.  Before
leaving I pull down the tarballs and sig files to my main workstation,
verify the signatures, scp to the laptop.  It'd be a waste to unpack
just to verify before pushing it, a pain to have to unpack and verify on
the laptop right away, and a showstopper if I didn't verify until I was
at 30,000 feet.

> > -Verifying before [bg]unzip means you won't expose [bg]unzip to likely
> >   malicious data (think bugs in [bg]unzip which make them crash on bad
> >   compressed files).  Of course GPG/PGP is still subject to input-based
>
> Crashes don't matter. Exploits would, so that point is actually valid.

Well, indeed, that's what I was suggesting.

> > [*] ...Now if tar had a --sig option to chain gpg between gunzip and
> >     untar... but that would just be Wrong.
>
> unzip && checksig && tar?

Yes, but all as one pipeline, not seperate commands with tempfiles.
After all there is a reason the [Zzj] flags were added to tar.  Signing
the intermediate .tar instead of the .tar.(gz|bs2) breaks that.

But that's inventing questionable features in GNU tar that won't be
present in other tars or archive-managing tools, creating dependencies
on GPG/PGP/tool of choice, etc.  Unnecessary complexity.

Actually, unlike gzip | tar -xf -, you can't start feeding the
signature-checked tar file to tar -xf until all of it has been read in
to be verified, so really, it can't be done in a single pass.


Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1

-----BEGIN PGP SIGNATURE-----

iD8DBQE+ekttIvjvEYYapvERAtY1AJ9QX8suP6G6zHxQjHiM8yxGO8QtEwCeMKJL
+jgFyusy4ofF7esaP/mMu/w=
=9xEC
-----END PGP SIGNATURE-----

