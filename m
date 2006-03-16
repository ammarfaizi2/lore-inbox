Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWCPDHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWCPDHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWCPDHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:07:32 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:44225 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932206AbWCPDHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:07:32 -0500
Message-Id: <200603160307.k2G37KLX007666@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: Fix sequencer missing negative bound check 
In-Reply-To: Your message of "Thu, 16 Mar 2006 09:19:11 +0800."
             <20060316011911.GA20384@eugeneteo.net> 
From: Valdis.Kletnieks@vt.edu
References: <20060316011911.GA20384@eugeneteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1142478440_5420P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 22:07:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1142478440_5420P
Content-Type: text/plain; charset=us-ascii

On Thu, 16 Mar 2006 09:19:11 +0800, Eugene Teo said:
> dev is missing a negative bound check.
> 
> Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
> 
> --- linux-2.6/sound/oss/sequencer.c~	2006-03-15 10:05:45.000000000 +0800
> +++ linux-2.6/sound/oss/sequencer.c	2006-03-16 09:06:59.000000000 +0800
> @@ -713,7 +713,7 @@
>  	int i, l = 0;
>  	unsigned char  *buf = &event_rec[2];
>  
> -	if ((int) dev > max_synthdev)
> +	if (dev < 0 || dev >= max_synthdev)
>  		return;
>  	if (!(synth_open_mask & (1 << dev)))
>  		return;

Erm??

Looking at a bit more context for the function:

static void seq_sysex_message(unsigned char *event_rec)
{
        int dev = event_rec[1];
        int i, l = 0;
        unsigned char  *buf = &event_rec[2];

        if ((int) dev > max_synthdev)
                return;
        if (!(synth_open_mask & (1 << dev)))
                return;
        if (!synth_devs[dev])
                return;

that 'int dev' came out of an 'unsigned char *' - as such, I doubt you
can get a negative value.  If anything, it should be 'unsigned int dev'.

--==_Exmh_1142478440_5420P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEGNZocC3lWbTT17ARAs6xAJ91+YwE3g7n/AMwsiqz5CRN4TWIygCgpJ23
1bS1NrCIQ6osl5v3o5owHNk=
=ahcq
-----END PGP SIGNATURE-----

--==_Exmh_1142478440_5420P--
