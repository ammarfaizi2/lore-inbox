Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVEMRzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVEMRzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVEMRzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:55:42 -0400
Received: from remus.commandcorp.com ([130.205.32.4]:36770 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S262458AbVEMRzH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:55:07 -0400
Subject: Re: Sync option destroys flash!
From: "Michael H. Warfield" <mhw@wittsend.com>
Reply-To: mhw@wittsend.com
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org, mhw@wittsend.com
In-Reply-To: <20050513171758.GB23621@csclub.uwaterloo.ca>
References: <1116001207.5239.38.camel@localhost.localdomain>
	 <20050513171758.GB23621@csclub.uwaterloo.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NGaZ/pbFUZqN7ej5+f36"
Organization: Thaumaturgy & Speculms Technology
Date: Fri, 13 May 2005 13:53:48 -0400
Message-Id: <1116006828.5239.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
X-MailScanner-From: mhw@wittsend.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NGaZ/pbFUZqN7ej5+f36
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-05-13 at 13:17 -0400, Lennart Sorensen wrote:

> Certainly causes lots of unnecesary writes which flash doesn't like.
> Given sync doesn't appear to be the default, whyever would you add sync
> to vfat?

	RedHat does it when they automount USB drives.  It's in their "hal"
package.  Law of unintended consequences, I guess.

> > 	Flash drives have a limited number of write cycles.  Many many
> > thousands of write cycles, but limited, none the less.  They are also
> > written in blocks which are much larger than the "sector" size report
> > (several K in a physical nand flash block, IRC).
> >=20
> > 	What happens, with the sync option on a VFAT file system, is that the
> > FAT tables are getting pounded and over-written over and over and over
> > again as each and every block/cluster is allocated while a new file is
> > written out.  This constant overwriting eventually wears out the first
> > block or two of the flash drive.

> All the flash I have used do automatic wear leveling.  Maybe I have only
> used high quality flash media (given I am doing work with embedded
> industrial grade gear, that is quite plausible).  Of course wear
> leveling doesn't mean you aren't doing way more writes than necesary,
> but it helps spread the load away from the FAT, which would otherwise
> quickly die on most flash cards no matter what system you use for
> writing to it.

	Yeah, I've heard that claimed but a real problem is that nobody can
tell which ones do or don't until you've got a crispy chip.  I've looked
and I haven't been able to find a single reference on any that you might
pick up at Best Buy or Fry's.  I've never seen one that has it written
on it that it has any sort of wear leveling like that.  But I guess we
don't all buy our flash drives at an industrial supply house (forget
Tiger Direct or CDW either - consumer grade).  I would bet that most
people don't even REALIZE that flash has a limited life and wears out.

> 700M =3D 1.4M 512byte sectors.  I guess if it actually writes one sector
> at a time and syncs, and it's not a media with good wear leveling, then
> yes that would destroy the sectors holding the FAT.  Ouch.  Crappy
> media, and bad way to treat it.  Unfortunately there is no bug, just
> user error, and potentially badly designed flash media firmware.

	Unfortunately, it's the default under some RedHat stuff (yes, I've
filed the bug reports) and the documentation on "mount" is incorrect and
it's arguable if it's any value, and there's no warning of the risks.
"User error" is a bit off the mark when the user has to take action he
has no knowledge of to work around a destructive default he doesn't even
know exists (here I'm referring specifically to the need to unmount the
automounted flash and then remount it somewhere else without the unsafe
options).

	User error also boils down to removing drives before they are unmounted
or sync'ed.  Windows seems to deal with this problem without jacking off
on the FAT tables.  Why is it that Linux has a procedure that is
potentially destructive and degrades performance so badly when MS gets
away without it in Windows?  It's an MS file system.  One of the
contributors on the Fedora list remarked that this explained why his USB
keys were so slow on Linux compared to Windows.

> > 	On a floppy, this would result in an insane amount of jacking around
> > back and forth between data sectors and the FAT sectors.  In addition t=
o
> > taking forever, that would shorten the life of the diskettes and the
> > drive itself, but who cares about floppies any more.  On a real hard
> > drive, this will cause "head resonances" as the heads go through
> > constant high speed seeks between the cylinder with the FAT tables and
> > the data cylinders.  That can't be good, on a continuous basis, for
> > drive life.  But it's really a disaster for flash memory.  It's going t=
o
> > cause premature failure in most flash memory, even if it doesn't kill
> > them right off as it did in my case with a 700 Meg file.
> >=20
> > 	Can we go back to ignoring "sync" on FAT and VFAT?  I can't see where
> > it does much good.  You might corrupt a file system if you unplugged it
> > while dirty but it beats the hell out of physically burning it up and
> > destroying the drive!

> How about you just don't use the sync option with fat when you don't
> mean to use sync?  sync does exactly what it should, which just happens
> to not be what you want, so don't use it.

	Already filed bug reports with RedHat.  On both HAL and on the
documentation for mount.

> > 	If it's decided that the FAT and VFAT file systems MUST obey the sync
> > option then please do something about a special case for the FAT tables=
!
> > Sync the data if thou must buti...  Thou shalt not, must not, whack off
> > on the FAT tables!!!

> Then the sync option wouldn't be much use anymore.

	Oh?  It's of some use now?  Beyond degrading performance to the point
that it takes many times longer to write a flash system in Linux than in
Windows?  Yes, I know, don't use it.  What's it there for, then?  To
protect idiots from removing drives before they're unmounted?  Those are
the same idiots who will not know what happened when it burns up there
drive and they are the least likely to use that option overtly.  Most
people don't realize that it was being used without their knowledge
(much less the risks associated with using it in the first place) and
just thought it was a Linux problem that it took many times longer to
write USB keys in Linux than in Windows.

> > 	Another option would be to only sync the FAT and VFAT file systems upo=
n
> > close of the file being written or upon close of the last file open on
> > the file system (fs not busy) but that might not help in the case of a
> > whole lotta little files...

> Again not very useful then.

	Rule number one should be "do no harm".  Maybe it should be under some
"force" flag or something just warning people not to use it unless they
really REALLY know what their doing.  I, personally, would never have
used it under any circumstances.  I was shocked to discover that RedHat
was doing this by default.  A warning to THEM would have been better
than a warning to me, since I already knew not to do stupid shit like
that.  Not sure who is responsible for that HAL package or what other
distros may also be vulnerable to this.  I mostly blame RedHat for this
problem first plus the mount man pages (which I suspect they replied on)
second but I question if there shouldn't be a better way to avoid
destroying hardware here.

> > 	I'm also going to file a couple of bug reports in bugzilla at RedHat
> > but this seems to be a more fundamental problem than a RedHat specific
> > problem.  But, IMHO, they should never be setting that damn sync flag
> > arbitrarily.

> No they certainly should not, but it may have something to do with
> making life easier for kde/gnome desktops and automatic mount/umount of
> media.  Dumb idea still, but that happens sometimes.

> Len Sorensen

	Mike
--=20
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com =20
  /\/\|=3Dmhw=3D|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/=
mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

--=-NGaZ/pbFUZqN7ej5+f36
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQCVAwUAQoTprOHJS0bfHdRxAQLvbQP/cPISUvA+MnY6waLrl2EFLc3eOtxsTVs9
6mx9byQXKqU2xh/FEtITUE5L+nAjVn2K8Qa7GmqPSmPTN2uDrYsaYrjkW+uLiwe2
7vFnYFnznFQEMVBHC2b92z4dsdx1JDCMRXfS2RqiPtrivG+Ke8V3ZUKIYfVj9wdh
VA5/PwiSHqQ=
=Hrg6
-----END PGP SIGNATURE-----

--=-NGaZ/pbFUZqN7ej5+f36--

