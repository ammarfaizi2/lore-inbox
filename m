Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWCOKxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWCOKxG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWCOKxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:53:06 -0500
Received: from hs-grafik.net ([80.237.205.72]:8209 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1750701AbWCOKxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:53:05 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc6-mm1 : Setting clocksource results in error
Date: Wed, 15 Mar 2006 11:53:14 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
References: <200603140935.26927@zodiac.zodiac.dnsalias.org> <1142363464.8797.10.camel@cog.beaverton.ibm.com>
In-Reply-To: <1142363464.8797.10.camel@cog.beaverton.ibm.com>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5550509.Po0QGqd7gt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603151153.18873@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5550509.Po0QGqd7gt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

applied patch. Didn't work?! Same error as before..

regards
Alex


Am Dienstag, 14. M=E4rz 2006 20:11 schrieb john stultz:
> On Tue, 2006-03-14 at 09:35 +0100, Alexander Gran wrote:
> > I'm still fiddeling with my way to slow netbeans debugger. I just tried
> > to change the clocksource. That resulted in an error, but apparently
> > worked. Is that expected behaviour:
> > root@t40:/sys/devices/system/clocksource/clocksource0# l
> > insgesamt 0
> > -rw------- 1 root root 4,0K 2006-03-14 09:31 available_clocksource
> > -rw------- 1 root root    0 2006-03-14 09:31 current_clocksource
> > root@t40:/sys/devices/system/clocksource/clocksource0# cat
> > available_clocksource
> > acpi_pm jiffies tsc pit
> > root@t40:/sys/devices/system/clocksource/clocksource0# echo acpi_pm >
> > current_clocksource
> > -su: echo: write error: Das Argument ist ung=FCltig
> > root@t40:/sys/devices/system/clocksource/clocksource0# cat
> > current_clocksource acpi_pm
>
> Huh. Interesting.
>
> Oh! I see it, we're stripping the \n from the name and returning a count
> value one less then what was given.
>
> You can verify it by noticing "echo -n tsc > current_clocksource" does
> not give the error.
>
> This small fix should resolve it.
>
> Thanks for the bug report!
> -john
>
> Signed-off-by: John Stultz <johnstul@us.ibm.com>
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index d2ce2c3..fe22f64 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -220,6 +220,7 @@ sysfs_show_current_clocksources(struct s
>  static ssize_t sysfs_override_clocksource(struct sys_device *dev,
>  					  const char *buf, size_t count)
>  {
> +	size_t ret =3D count;
>  	/* strings from sysfs write are not 0 terminated! */
>  	if (count >=3D sizeof(override_name))
>  		return -EINVAL;
> @@ -241,7 +242,7 @@ static ssize_t sysfs_override_clocksourc
>
>  	spin_unlock_irq(&clocksource_lock);
>
> -	return count;
> +	return ret;
>  }
>
>  /**

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart5550509.Po0QGqd7gt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEF/Ie/aHb+2190pERAmVMAJ9OSvnrMrgRbgTvF69cIqZPhtoKzwCffk9C
zyF4uKfnesbKp/+jiR0CdOA=
=xQ6O
-----END PGP SIGNATURE-----

--nextPart5550509.Po0QGqd7gt--
