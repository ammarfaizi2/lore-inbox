Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbUKAJuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUKAJuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbUKAJui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:50:38 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:61154 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S261717AbUKAJuW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:50:22 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: ethernet channel bonding (bonding.o) on 2.6.x
Date: Mon, 1 Nov 2004 10:54:56 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411010955.00347.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.47; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I'm trying to migrate a couple of server from a 2.4 kernel to 2.6 (Mandrake 
9.1 -> 10.0)
All servers have 4 nics (a mix of e1000 and bcm5700) arranged in two logical 
interfaces.

Note: Mandrakes ifconfig/ifup scripts have the necessary logic to ifenslave 
ethX interfaces to a bondX interface automatically (through options in the 
ifcfg-ethX and ifcfg-bondX config files).

On 2.4 I used the following in /etc/modules.conf, which worked perfectly:

- --
alias bond0 bonding
alias bond1 bonding

options bond0 miimon=100 mode=1
options bond1 -o bonding1 miimon=100 mode=1
- --

When I come to use these settings with /etc/modprobe.conf, only bond0 comes 
up. The system complains that there 'doesnt seem to be a device for bond1' 
and doesn't bring it up.

Using 'generate-modprobe.conf' It thinks I should be using:

- --
alias bond0 bonding
alias bond1 bonding
options bond0 miimon=100 mode=1
options bond1 miimon=100
install bond1 /sbin/modprobe -o bonding1 --ignore-install bonding
- --

This doesn't work - I get the same error.

If I manually do:

	# modprobe bonding -o bonding1
	# ifconfig bond1 up

Then I can bring up bond1 by hand. 

I'm guessing the 'install' line is supposed to load a second instance of the 
bonding driver (which I didn't think I needed with 2.6's module loading 
needed - I can load e1000 twice without doing anything special) but it isn't.


Does anyone have a system with more than one bonded interface that actually 
works?

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBhgf0Bn4EFUVUIO0RAuAHAKCDS5DtJMzRJjJGnGXly6b0GjRL/wCg8h/A
PXmz2ltABkxPQWXfVY4XVBQ=
=Wsch
-----END PGP SIGNATURE-----
