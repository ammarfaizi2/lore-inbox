Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261992AbREPQAv>; Wed, 16 May 2001 12:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261991AbREPQAl>; Wed, 16 May 2001 12:00:41 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:34827 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S261990AbREPQA0>; Wed, 16 May 2001 12:00:26 -0400
Date: Wed, 16 May 2001 17:58:35 +0200
From: Kurt Garloff <garloff@suse.de>
To: "H. Peter Anvin" <hpa@transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com>, alan@etpnet.phys.tue.nl
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516175835.S18704@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"H. Peter Anvin" <hpa@transmeta.com>,
	Linus Torvalds <torvalds@transmeta.com>, alan@etpnet.phys.tue.nl,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3B002FC6.C0093C18@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+OVWeTxrbAwQuiek"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B002FC6.C0093C18@transmeta.com>; from hpa@transmeta.com on Mon, May 14, 2001 at 12:19:34PM -0700
X-Operating-System: Linux 2.2.19 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+OVWeTxrbAwQuiek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi HPA, Linus, Alan,

On Mon, May 14, 2001 at 12:19:34PM -0700, H. Peter Anvin wrote:
> Linus Torvalds has requested a moratorium on new device number
> assignments. His hope is that a new and better method for device space
> handing will emerge as a result.
>=20
> Alan Cox has requested that I maintain a forked registry for his -ac
> kernel patch tree.  I have agreed to do so once I have forked off the
> "final" version of the registry for Linus' tree.
[...]

I've been following the discussion and would like to throw in my few cents.

First of all, I see perfectly Linus' point of disliking the manual
maintenance of device numbers. As the current solution is not elegant and
requires a lot of work by the device registrar and probably more and more
work in the future, this should be replaced by a better - automatic and
elegant - mechanism in the future. Point taken.

But I'm really surprised reading that the device registry is about to close
now.=20
Well, we need the better mechanism, before doing so.

At first sight, devfs looks like the solution to this. But, on a second
sight, devfs looks like a compromise between a new system, which would=20
completely abstract the details of the underlying hardware and just present
the devices from a user interface point of view, and the current system.=20
We get rid of static major/minors, but the naming scheme still imposes to
know lots of details about the way your hardware is plugged together.
Furthermore, it seems, many people dislike devfs a lot. Instead of fixing a
few problems with devfs or (more likely) with devfsd, they seem to believe
the concept is fundamentally broken, otherwise their behaviour could only be
considered ridiculous.

So, we currently don't have a solution to this problem. A lot of good ideas
have been proposed in this thread, but no working code that addresses all
the issues (autoloading of modules, repeatability of naming, devices needed
early in boot stage, ...) is there or was at least designed to a point where
implementation is just a question of writing it down.
Furthermore, some userspace apps use the major no to determine the exact
type of a (otherwise similar) device to decide what functionality to offer
or how to implement certain operations.

In short: This change breaks currently working things.
This can all be fixed, of course, but I doubt it can happen in very short
time.

To be honest, I fail to believe that such a policy change is happening now,
in the middle of a stable kernel series, and I fail to believe that this is
really what Linus suggested.=20
IMHO, this policy change affects the kernel more than a major rework of VM,
to just give an example. It's very definitely not stuff for 2.4.

As far as I know, HPA has not complained about his workload for the manual
maintenance of the the LANANA. Currently, it still seems doable, and HPA is
doing it, fortunately. Thanks! I've not seen anybody complain about the
way he does it either.

So, I would be very pleased if we could agree, that it's acceptable to go on
with the old manual device registry of HPA for the rest of the 2.4 kernel
series. Let's start the new policy with 2.5.1!

And please no fork! Every fork splits the community in two parts and
basically halves our power. I don't think this would help Linux to be
accepted by more people or to be able to be used to solve more problems=20
in a nice and efficient way.

I think I do very well understand one of the reasons, why Alan wants to stay
with the old scheme. It (still) works.=20
How would you imagine to make a stable Linux distribution, if such a
change happens now? I do not think that all apps can be fixed and a stable,
reproducible and reliable mechanism to manage device nodes can be introduced
within the time frame of 2.4 kernels.=20
Even switching a distro to use devfs only looks easier than this.
So, we would need to keep to the old mechanism, if we don't want to risk
stability and manageability of a distro. Which is paramount ...
I would not like to be forced to use -ac kernels.
(Alan, don't get this wrong! It's great that you prepare kernels to test
 somewhat more experimental features or drivers, but I would like to have
 the choice.)

If we start the new device management with 2.5.1, there's plenty of time to
have the mechanism and the kernel stabilize, to get issues like automatic
module loading sorted and to adapt distributions before 2.6/3.0 comes out.
That's fine with me.

Well, maybe you never considered applying this policy change right now
within 2.4, Linus. Well, ignore my posting then, if you like.

Best regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--+OVWeTxrbAwQuiek
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7AqOqxmLh6hyYd04RAr0+AJ9HvzmKAR0X9pExj0um0bbZfKUrTwCfQWcv
m4Wlh0DsOaHWnKIjbwc8+GA=
=/FIY
-----END PGP SIGNATURE-----

--+OVWeTxrbAwQuiek--
