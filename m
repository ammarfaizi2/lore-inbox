Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVCGA6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVCGA6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVCGA6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:58:43 -0500
Received: from smtp3.oregonstate.edu ([128.193.0.12]:28575 "EHLO
	smtp3.oregonstate.edu") by vger.kernel.org with ESMTP
	id S261346AbVCGA6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:58:23 -0500
Message-ID: <422BA727.1030506@engr.orst.edu>
Date: Sun, 06 Mar 2005 16:58:15 -0800
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, vojtech@suse.cz
Subject: [PATCH] Treat ALPS mouse buttons as mouse buttons
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1A4C177468BAF32EAA8D988F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A4C177468BAF32EAA8D988F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The following patch changes the ALPS touchpad driver to treat some mouse
buttons as mouse buttons rather than what appears to be joystick buttons.
This is needed for the Dell Inspiron 8500's DualPoint stick buttons. Without
this patch only the touchpad buttons behave properly.

--- linux-2.6.11/drivers/input/mouse/alps.c     2005-03-01 23:38:13.000000000 -0800
+++ linux-2.6.11-gentoo-r2/drivers/input/mouse/alps.c   2005-03-06 16:45:07.000000000 -0800
@@ -97,8 +97,8 @@

                input_report_rel(dev, REL_X, x);
                input_report_rel(dev, REL_Y, -y);
-               input_report_key(dev, BTN_A, left);
-               input_report_key(dev, BTN_B, right);
+               input_report_key(dev, BTN_LEFT, left);
+               input_report_key(dev, BTN_RIGHT, right);
                input_sync(dev);
                return;
        }
@@ -389,8 +389,6 @@
        psmouse->dev.evbit[LONG(EV_REL)] |= BIT(EV_REL);
        psmouse->dev.relbit[LONG(REL_X)] |= BIT(REL_X);
        psmouse->dev.relbit[LONG(REL_Y)] |= BIT(REL_Y);
-       psmouse->dev.keybit[LONG(BTN_A)] |= BIT(BTN_A);
-       psmouse->dev.keybit[LONG(BTN_B)] |= BIT(BTN_B);

        psmouse->dev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
        input_set_abs_params(&psmouse->dev, ABS_X, 0, 1023, 0, 0);

-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University


--------------enig1A4C177468BAF32EAA8D988F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCK6csiP+LossGzjARAploAKCASmIsmDVkZ4xS9R94oJYx06Qr1QCgpL8M
pX1FzFtJ5xmmddXM+q8UIxk=
=+VV+
-----END PGP SIGNATURE-----

--------------enig1A4C177468BAF32EAA8D988F--
