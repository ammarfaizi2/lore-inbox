Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWASHes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWASHes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWASHes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:34:48 -0500
Received: from h80ad24de.async.vt.edu ([128.173.36.222]:35554 "EHLO
	h80ad24de.async.vt.edu") by vger.kernel.org with ESMTP
	id S1161229AbWASHer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:34:47 -0500
Message-Id: <200601190734.k0J7Y6i5004199@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Wireless issues (was Re: 2.6.16-rc1-mm1 
In-Reply-To: Your message of "Wed, 18 Jan 2006 14:56:19 PST."
             <20060118145619.4b5c7a3a.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20060118005053.118f1abc.akpm@osdl.org> <200601182229.k0IMTJ56003467@turing-police.cc.vt.edu>
            <20060118145619.4b5c7a3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137656019_3359P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 02:33:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137656019_3359P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 Jan 2006 14:56:19 PST, Andrew Morton said:

> There are orinoco changes in git-pcmcia.patch.  Could you try reverting
> add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch and then
> git-pcmcia.patch?

It turns out that we lost the initialization for the 'config_info_t conf;', so
the compare to conf.Vcc was broken.  Here's a works-for-me patch.

Signed-Off-By: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---

--- linux-2.6.16-rc1-mm1/drivers/net/wireless/orinoco_cs.c.v1	2006-01-19 01:52:03.000000000 -0500
+++ linux-2.6.16-rc1-mm1/drivers/net/wireless/orinoco_cs.c	2006-01-19 02:21:25.000000000 -0500
@@ -205,6 +205,10 @@ orinoco_cs_config(struct pcmcia_device *
 	/* Configure card */
 	link->state |= DEV_CONFIG;
 
+	/* Look up the current Vcc */
+	CS_CHECK(GetConfigurationInfo,
+		pcmcia_get_configuration_info(link, &conf));
+
 	/*
 	 * In this loop, we scan the CIS for configuration table
 	 * entries, each of which describes a valid card


--==_Exmh_1137656019_3359P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDz0DTcC3lWbTT17ARAlIBAKDhGs0p7o6iRp6jcIkloLS8DgptwwCg2BDQ
WHG1DIGzRvtIKomJQRYuYiM=
=oXJS
-----END PGP SIGNATURE-----

--==_Exmh_1137656019_3359P--
