Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVIQR6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVIQR6F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVIQR6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 13:58:05 -0400
Received: from master.altlinux.ru ([62.118.250.235]:54797 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751171AbVIQR6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 13:58:04 -0400
Date: Sat, 17 Sep 2005 21:56:46 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Manu Abraham <manu@linuxtv.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts (2)
Message-Id: <20050917215646.78a05044.vsu@altlinux.ru>
In-Reply-To: <432C344D.1030604@linuxtv.org>
References: <432C344D.1030604@linuxtv.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__17_Sep_2005_21_56_46_+0400_=za513V5CmaHaY4b"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__17_Sep_2005_21_56_46_+0400_=za513V5CmaHaY4b
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 17 Sep 2005 19:20:45 +0400 Manu Abraham wrote:

> Can somebody give me a pointer as to what i am possibly doing wrong.
> 
> The module loads fine..
> The module unloads fine.. But i get a "free free IRQ" on free_irq()..

You are not calling pci_enable_device() in your probe handler.  You
MUST call this function, check for success, and only after that you
can use pdev->irq (recent kernels perform interrupt routing only after
the device is enabled, so the value of pdev->irq before the call to
pci_enable_device() may not be valid).

--Signature=_Sat__17_Sep_2005_21_56_46_+0400_=za513V5CmaHaY4b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLFjiW82GfkQfsqIRAgNjAJ984w98S4pF7CWCPRv2CNZJI/QMiQCcCOwO
9Js2Ov8wK+P4lnKAeHuzCKE=
=Q1xy
-----END PGP SIGNATURE-----

--Signature=_Sat__17_Sep_2005_21_56_46_+0400_=za513V5CmaHaY4b--
