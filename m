Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWBITX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWBITX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWBITX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:23:57 -0500
Received: from mout2.freenet.de ([194.97.50.155]:26799 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750722AbWBITX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:23:57 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH v2 02/07] cpuset use combined atomic_inc_return calls
Date: Thu, 9 Feb 2006 20:23:51 +0100
User-Agent: KMail/1.8.3
References: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com> <20060209185424.8596.89333.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060209185424.8596.89333.sendpatchset@jackhammer.engr.sgi.com>
Cc: akpm@osdl.org, steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart19653155.FqZbHIMS0a";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602092023.51547.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart19653155.FqZbHIMS0a
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 09 February 2006 19:54, you wrote:
> @@ -1770,8 +1769,7 @@ static long cpuset_create(struct cpuset=20
>  	atomic_set(&cs->count, 0);
>  	INIT_LIST_HEAD(&cs->sibling);
>  	INIT_LIST_HEAD(&cs->children);
> -	atomic_inc(&cpuset_mems_generation);
> -	cs->mems_generation =3D atomic_read(&cpuset_mems_generation);
> +	cs->mems_generation =3D atomic_inc_return(&cpuset_mems_generation);
>  	fmeter_init(&cs->fmeter);
> =20
>  	cs->parent =3D parent;
> @@ -1861,7 +1859,7 @@ int __init cpuset_init_early(void)
>  	struct task_struct *tsk =3D current;
> =20
>  	tsk->cpuset =3D &top_cpuset;
> -	tsk->cpuset->mems_generation =3D atomic_read(&cpuset_mems_generation);
> +	tsk->cpuset->mems_generation =3D atomic_inc_return(&cpuset_mems_generat=
ion);
>  	return 0;
>  }

Is this hunk really correct? I did not look into the code, but from
the patch context it seems like it adds an inc here.

=2D-=20
Greetings Michael.

--nextPart19653155.FqZbHIMS0a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD65bHlb09HEdWDKgRAmK/AKCpX4oJ2Z7IQ3JLPexRG+6jnV62FQCgmzPa
6vFmO30025602h1FtxYYfHA=
=9J2+
-----END PGP SIGNATURE-----

--nextPart19653155.FqZbHIMS0a--
