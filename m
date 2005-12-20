Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVLTV2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVLTV2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLTV2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:28:10 -0500
Received: from mout2.freenet.de ([194.97.50.155]:51148 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932127AbVLTV2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:28:09 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: [ANN] bcm43xx software encryption support
Date: Tue, 20 Dec 2005 22:27:54 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Message-Id: <200512202227.55027.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart4002859.UW4uScLJBP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4002859.UW4uScLJBP
Content-Type: multipart/mixed;
  boundary="Boundary-01=_adHqDi43rXWhoHU"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_adHqDi43rXWhoHU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I ported the bcm43xx driver (http://bcm43xx.berlios.de) to the
devicescape ieee802.11 stack.
This port is a project branch, so softmac is still supported
and developed.

bcm43xx now supports software-side encryption functionality.
(The hardware supports encryption, but that's not completely
implemented, yet)
I use the driver in my AES-WPA encrypted network and it works
very well. Many things have been fixed in the past few days.

The devicescape stack is still in development and it currently
has an ugly user-inferface. The maintainer is working on cleanups,
so please _do_ _not_ complain about dscape being crap. :)
(We have enough stupid flamewars on lkml, at the moment)
It is indeed very good code, but the user interface is a little
bit ugly at the moment.

Because of the user-interface, it is also a little bit more
difficult to bring the device up. But I wrote a
horribly ugly bash script (sta_up.sh) to do most of the work
for you. Attached is HOWTO, with more details how to get
it working.

Good luck.

Thanks for everyone supporting us! You are a great community.

=2D-=20
Greetings Michael.

--Boundary-01=_adHqDi43rXWhoHU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="HOWTO"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="HOWTO"

****                                    ****
****  HOWTO get bcm43xx-dscape running  ****
****                                    ****

This is a port of the bcm43xx driver for the devicescape ieee802.11
stack. The devicescape ieee802.11 stack is an advanced out-of-mainline
802.11 protocol module.
I will call the "devicescape ieee802.11 stack" simply "dscape" in the
following text.


*** Setting up the bcm43xx driver with dscape is currently non-trivial,
*** as several modifications to the kernel and the userland
*** wpa_supplicant tool are required. We are working on it...


1)  You need to patch the kernel with latest ieee80211-devicescape patchset:
    ftp://ftp.kernel.org/pub/linux/kernel/people/jbenc/ieee80211-devicescape-XXXXXX.tar.bz2
    These patches are diffed against the netdev-2.6 GIT tree. See
    the file GIT-ORIGIN for more information.
    But these patches usually also apply (with some hunk offsets) to
    latest mainline kernels.
    Patch the kernel, compile and install it.
    When configuring, enable "Networking/Generic IEEE 802.11 Networking Stack"
    Reboot.
    If you configured dscape as modules, load the dscape modules:
    modprobe rate_control
    modprobe 80211
    It is important to load rate_control before 80211. (Yes, it should be
    done automatically... Working on it.)

2)  Add dscape support to wpa_supplicant:
    Download latest stable version of wpa_supplicant from:
    http://hostap.epitest.fi/
    (As of this writing, latest stable is 0.4.7)
    Download the corresponding dscape-support patch from:
    ftp://ftp.kernel.org/pub/linux/kernel/people/jbenc/ieee80211-utils/wpa_supplicant/wpa_supplicant-0.4.7_dscape-02.patch
    Patch wpa_supplicant (No, I won't describe the patching
    process here ;) ), compile and install it.

3)  Set up a wpa_supplicant config file in /etc/wpa_supplicant.conf
    Here is an example for an AES WPA encrypted network:

	# WPA AES encryption
	ctrl_interface=/var/run/wpa_supplicant
	network={
		ssid="ACCESSPOINT_SSID"
		key_mgmt=WPA-PSK
		proto=WPA
		pairwise=CCMP TKIP
		group=CCMP TKIP
		psk="MY PASSPHRASE"
		priority=3
	}

4)  Download and compile the bcm43xx-dscape driver.
    Snapshots can be downloaded from:
    ftp://ftp.berlios.de/pub/bcm43xx/snapshots/bcm43xx-dscape-XXXXXXXX.tar.bz2
    UnTar the archive and type make to build the driver.

5)  Take a bottle of your favourite beer, open it and take a swallow.

6)  Now it's time to bring the driver up.
    Do insmod ./bcm43xx.ko to load the driver.
    There is an ugly bash script to bring the driver up after insmod.
    It's found in the bcm43xx-dscape package and is called "sta_up.sh"
    Call ./sta_up.sh --help to get some usage information.
    It may suffice to call ./sta_up.sh without any parameters. See
    the help. Default parameters, which are used when called without parameters,
    are explained there.

7)  If you want to access the internet, make sure your default route
    is correctly set up with your gateway's IP:
    route add default gw 192.168.xxx.xxx

8)  Take another swallow from your bottle of beer and test if it works:
    ping www.kernel.org

9)  If it works, drink the rest of your beer. Otherwise read this HOWTO again,
    and again and again. Complain to bcm43xx-dev@lists.berlios.de, if it still
    does not work.



--Boundary-01=_adHqDi43rXWhoHU--

--nextPart4002859.UW4uScLJBP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDqHdblb09HEdWDKgRAsnDAKCSsmt5XUiH6HXweJ2XW+AjYcAZpQCdF2t+
tvzVgCQcdtwCgQdaJ+AgBro=
=xn6Z
-----END PGP SIGNATURE-----

--nextPart4002859.UW4uScLJBP--
