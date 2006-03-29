Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWC2Xyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWC2Xyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWC2Xyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:54:50 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:62904 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751274AbWC2Xyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:54:50 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Date: Thu, 30 Mar 2006 09:53:26 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
References: <20060329220808.GA1716@elf.ucw.cz> <200603300936.22757.ncunningham@cyclades.com> <20060329154748.A12897@unix-os.sc.intel.com>
In-Reply-To: <20060329154748.A12897@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1401891.cczBfNHnks";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603300953.32298.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1401891.cczBfNHnks
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 30 March 2006 09:47, Ashok Raj wrote:
> On Thu, Mar 30, 2006 at 09:36:16AM +1000, Nigel Cunningham wrote:
> > Hi.
> >
> >
> > So if you have a single core x86, you want X86_PC, and if you have HT or
> > SMP, you want GENERICARCH? If so, could this be done via selects or
> > depends or at least defaults in Kconfig?
>
> Yes, i think only SUSPEND_SMP is affect by this. I thought Rafael cced
> Pavel during that exchange, maybe i missed.
>
> > Regards,
> >
> > Nigel
>
> How about this patch.
>
> Make SUSPEND_SMP depend on X86_GENERICARCH, since hotplug cpu requires
> !X86_PC due to some race in IPI handling.  See more discussion here
>
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114303306032338&w=3D2
>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> --------------------------------------------------------------
>
> Index: linux-2.6.16-git16/kernel/power/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.16-git16.orig/kernel/power/Kconfig
> +++ linux-2.6.16-git16/kernel/power/Kconfig
> @@ -96,5 +96,5 @@ config SWSUSP_ENCRYPT
>
>  config SUSPEND_SMP
>         bool
> -       depends on HOTPLUG_CPU && X86 && PM
> +       depends on HOTPLUG_CPU && X86 && PM && X86_GENERICARCH
>         default y

Sounds like the right approach to me, but I think it's better to use select=
s.=20
I reckon that if the user selects SMP and then selects suspend support,=20
everything else required should be automatic. If we do too many 'depends=20
on's, they have to mess about figuring out what they haven't selected yet a=
nd=20
why they can't find the option to suspend. Most people don't seem to know=20
about '/' in make menuconfig.

Regards,

Nigel

--nextPart1401891.cczBfNHnks
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKx38N0y+n1M3mo0RAkcTAJ4pnDa8MsHEV8OuF0l7b+44J/b3RgCg6FaX
8rTXlSHVXFdpDmn11vyOTNM=
=mXRP
-----END PGP SIGNATURE-----

--nextPart1401891.cczBfNHnks--
