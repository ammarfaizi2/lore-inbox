Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUHRGBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUHRGBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268651AbUHRGBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:01:51 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:8320 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S268652AbUHRGBK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:01:10 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3 documentation (lack of)
Date: Tue, 17 Aug 2004 23:01:06 -0700
User-Agent: KMail/1.7
References: <20040818025951.63c4134e.diegocg@teleline.es>
In-Reply-To: <20040818025951.63c4134e.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1450325.TfXD8YOqaC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408172301.09350.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1450325.TfXD8YOqaC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 17 August 2004 17:59, you wrote:
> +commit=3Dnrsec	(*)	Ext3 can be told to write all its data and metadata
> +			every 'nrsec' seconds. The default value is 5 seconds.
> +			This means that if you lose your power, you will lose,
> +			as much, the latest 5 seconds of work. This default
> +			value (or any low value) will hurt performance, but
> +			it's good for data-safety. Setting it to 0 disables it.
> +			Disabling it or setting it to very large values will
> +			improve performance,

Setting commit to zero doesn't seem to disable it, judging from my local=20
2.6.8.1-mm1 source.

super.c has:
case Opt_commit:
   if (match_int(&args[0], &option))
      return 0;
   if (option < 0)
      return 0;
   if (option =3D=3D 0)
      option =3D JBD_DEFAULT_MAX_COMMIT_AGE;
   sbi->s_commit_interval =3D HZ * option;
   break;

Where JBD_DEFAULT_COMMIT_AGE is defined to 5 in include/linux/jbd.h. So it=
=20
seems that setting it to zero will just set it to the default commit interv=
al=20
of 5 seconds. Am I missing something?

=2DRyan

--nextPart1450325.TfXD8YOqaC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBIvClW4yVCW5p+qYRAk6mAKDIrIPSY9hfafJp/OjKPmAd2FOlFgCfd0cg
+6luozKqAzzLrFB1BxxLxJM=
=NyNN
-----END PGP SIGNATURE-----

--nextPart1450325.TfXD8YOqaC--
