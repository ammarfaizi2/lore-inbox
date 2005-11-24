Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVKXLjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVKXLjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 06:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVKXLjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 06:39:42 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:47285 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932335AbVKXLjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 06:39:41 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add basic PM support for Nvidia and ATI AGP bridges
Date: Thu, 24 Nov 2005 12:33:10 +0100
User-Agent: KMail/1.8.3
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
References: <20051124060030.GF28070@srcf.ucam.org>
In-Reply-To: <20051124060030.GF28070@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3069255.qMEoAtl9Om";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511241233.16890@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3069255.qMEoAtl9Om
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Matthew Garrett wrote:
>I retrieved these from the swsusp2 patchset, but they seem to be
>independently useful. As a result, I'm not sure who the original author
>is - however, they seem to be pretty obvious.

>@DPATCH@
>diff -ruNp 210-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c
> 210-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c ---
> 210-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c	2005-06-20
> 11:46:51.000000000 +1000 +++
> 210-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c	2005-07-04
> 23:14:18.000000000 +1000 @@ -507,6 +507,33 @@ static void __devexit
> agp_ati_remove(str
> 	agp_put_bridge(bridge);
> }
>
>+#ifdef CONFIG_PM
>+
>+static int agp_ati_suspend(struct pci_dev *pdev, pm_message_t state)
>+{
>+	pci_save_state (pdev);
>+	pci_set_power_state (pdev, 3);

Please remove the spaces after the function names.

>diff -ruNp 210-agp-resume-support.patch-old/drivers/char/agp/nvidia-agp.c
> 210-agp-resume-support.patch-new/drivers/char/agp/nvidia-agp.c ---
> 210-agp-resume-support.patch-old/drivers/char/agp/nvidia-agp.c	2005-06-20
> 11:46:51.000000000 +1000 +++
> 210-agp-resume-support.patch-new/drivers/char/agp/nvidia-agp.c	2005-07-04
> 23:14:18.000000000 +1000 @@ -397,11 +397,40 @@ static struct pci_device_id
> agp_nvidia_p
>
> MODULE_DEVICE_TABLE(pci, agp_nvidia_pci_table);
>
>+#ifdef CONFIG_PM
>+static int agp_nvidia_suspend(struct pci_dev *pdev, pm_message_t state)
>+{
>+	pci_save_state (pdev);
>+	pci_set_power_state (pdev, 3);

Same here.

Eike

--nextPart3069255.qMEoAtl9Om
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDhaT8XKSJPmm5/E4RAsikAJwJdfSs4R95ESJ/8/j1lRkjny29wQCfUnyz
N5V2ZV1E0IfLZgMi/vFa4pE=
=/g84
-----END PGP SIGNATURE-----

--nextPart3069255.qMEoAtl9Om--
