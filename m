Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272158AbTHNFEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 01:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272162AbTHNFEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 01:04:22 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:32460 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S272158AbTHNFET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 01:04:19 -0400
Date: Thu, 14 Aug 2003 17:03:56 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: gene.heskett@verizon.net
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O13int for interactivity
Message-ID: <1800000.1060837436@ijir>
In-Reply-To: <200308130833.43362.gene.heskett@verizon.net>
References: <200308050207.18096.kernel@kolivas.org>
 <200308130124.31978.gene.heskett@verizon.net> <98750000.1060753418@ijir>
 <200308130833.43362.gene.heskett@verizon.net>
X-Mailer: Mulberry/3.1.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========1809249384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1809249384==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ah.  I see you have framebuffer console on, whereas I have plain VGA=20
console only.  Try turning framebuffer off; two drivers for the same=20
hardware may well fight over it.  My X isn't patched, it just has their=20
driver modules and the libraries installed.

Andrew

--On Wednesday, August 13, 2003 08:33:43 AM -0400 Gene Heskett=20
<gene.heskett@verizon.net> wrote:

> On Wednesday 13 August 2003 01:43, Andrew McGregor wrote:
>> --On Wednesday, August 13, 2003 01:24:31 AM -0400 Gene Heskett
>>
>> <gene.heskett@verizon.net> wrote:
>>> Unrelated question:  I've applied the 2.6 patches someone pointed
>>> me at to the nvidia-linux-4496-pkg2 after figuring out how to get
>>> it to unpack and leave itself behind, so x can be run on 2.6 now.
>>> But its a 100% total crash to exit x by any method when using it
>>> that way.
>>>
>>> Has the patch been updated in the last couple of weeks to prevent
>>> that now?  It takes nearly half an hour to e2fsck a hundred gigs
>>> worth of drives, and its going to bite me if I don't let the
>>> system settle before I crash it to reboot, finishing the reboot
>>> with the hardware reset button.
>>>
>>> Better yet, a fresh pointer to that site.
>>
>> http://www.minion.de/
>>
>> Works fine for me, as of 2.6.0-test1 (which is when I downloaded the
>> patch).  I don't get the crash on either of my systems (GeForce2Go
>> P3 laptop and GeForce4 Athlon desktop).
>>
>> Andrew
>
> I see some notes about patching X, which I haven't done.  That might
> be it.  I also doublechecked that I'm running the correct makefile,
> and get this:
>
> [root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2]# ls -lR * |grep Makefile
> -rw-r--r--    1 root     root         3623 Jul 16 22:56 Makefile
> -rw-r--r--    1 root     root         7629 Aug  5 22:24 Makefile
> -rw-r--r--    1 root     root         7629 Aug  5 21:46 Makefile.kbuild
> -rw-r--r--    1 root     root         4865 Aug  5 21:46 Makefile.nvidia
> [root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2]# cd
> ../NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4/ [root@coyote
> NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4]# ls -lR * |grep Makefile -rw-r--r--
> 1 root     root         3623 Jul 16 22:56 Makefile
> -rw-r--r--    1 root     root         5665 Jul 16 22:56 Makefile
> [root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4]#
>
> My video card, from an lspci:
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX
> DDR] (rev b2)
>
> And the XFree86 version is:
> 3.2.1-21
>
> Interesting to note that the 'nv' driver that comes with X
> does not do this.  But it also has no openGL and such.
> We are instructed to remove agp support from the kernel, and
> use that which is in the nvidia kit, and I just checked the
> .config, and its off, so thats theoreticly correct.  A grep
> for FB stuff returns this:
>
> CONFIG_FB=3Dy
># CONFIG_FB_CIRRUS is not set
># CONFIG_FB_PM2 is not set
># CONFIG_FB_CYBER2000 is not set
># CONFIG_FB_IMSTT is not set
># CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=3Dy
># CONFIG_FB_HGA is not set
> CONFIG_FB_RIVA=3Dy
># CONFIG_FB_MATROX is not set
># CONFIG_FB_RADEON is not set
># CONFIG_FB_ATY128 is not set
># CONFIG_FB_ATY is not set
># CONFIG_FB_SIS is not set
># CONFIG_FB_NEOMAGIC is not set
># CONFIG_FB_3DFX is not set
># CONFIG_FB_VOODOO1 is not set
># CONFIG_FB_TRIDENT is not set
># CONFIG_FB_PM3 is not set
># CONFIG_FB_VIRTUAL is not set
>
> I'd assume the 'RIVA' fb is the correct one, its working in
> 2.4, although I can induce a crash there by switching from X
> to a virtual console, and then attempting to switch back to X.
> That will generally bring the machine down.  It is perfectly ok
> to do that, repeatedly, when running the nv driver from X.
>
> --
> Cheers, Gene
> AMD K6-III@500mhz 320M
> Athlon1600XP@1400mhz  512M
> 99.27% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com attornies please note, additions to this message
> by Gene Heskett are:
> Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
>
>




--==========1809249384==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/OxhIHamGxvX4LwIRAjUQAJ4kLkxYW7JqkiSMIVr7BajAE9ltywCgtOiG
C/MCrUDV5Zd428zZbBAuqrQ=
=VRkV
-----END PGP SIGNATURE-----

--==========1809249384==========--

