Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbUCBCc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 21:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUCBCc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 21:32:27 -0500
Received: from cryptobackpack.org ([68.164.243.10]:1694 "EHLO
	mail.cryptobackpack.org") by vger.kernel.org with ESMTP
	id S261542AbUCBCcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 21:32:24 -0500
Date: Mon, 1 Mar 2004 18:30:08 -0800
From: David Bryson <david@tsumego.com>
To: linux-kernel@vger.kernel.org
Subject: circular pivot_root, is this possible ?
Message-ID: <20040302023008.GA8037@heliosphan.futuretel.com>
Reply-To: David Bryson <david@tsumego.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings!
I'm working on some embedded applications and I am wondering if
something like the following is possible.  I have implemented most of
this but the last few steps are a bit of a mystery to me... and after
reading many threads in the lkml archives I don't believe it's
possible, but I thought I'd ask anyway.

flash media contains two filesystem images, an initrd.gz, a
sys.img(cramfs), and a kernel

1) kernel boots with initrd.gz as root, loading into ram0
2) initrd mounts the flash filesystem, and loads sys.img via loopback
3) a tmpfs is created, contents of sys.img are copied into the tmpfs
4) system does a pivot_root on the tmpfs, passing the initrd as
well(somewhere on the tmpfs filesytem)
5) system begins normal operation

This works find and is fairly easy.  The next part is what I am having
trouble with.

Say the system needs an upgrade.... I want to

1) pivot_root _back out_ of the tmpfs, onto the initrd again
2) obtain via network a new sys.img, write it to the flash
3) wipe tmpfs, and recopy the contents of the new sys.img into memory
4) pivot_root back into the tmpfs and start the higher level system
again

pivot_root circles around root filesystems as various tasks are
completed.

Somehow init isn't behaving properly with me on this.  My first
attempts included an init on both initrd.gz and sys.img.  Having two
init's running at normal system startup.  This did not work well but
got the job done, as init(PID:1 on the initrd) was running as well as
init(some other PID on sys.img)

Eventually I tried only running a script on the initrd.gz to get the
system pivot_root'd to tmpfs.  But if I attempted to start the
circular pivot_root behavior(back to the inird) I still ended up with
init(PID:1) on the tmpfs, while my rootfs was in the initrd again.
Additionally I couldn't unmount devfs because I am assuming the old
processes running under init are still using it.

I also tried killing init with various singals, to see if it would
'reload' the config on the current rootfs(kill -1 1, kill -HUP 1) but
no success there.

So the question remains, is it possible to have circular pivot_roots ?
thanks
Dave

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAQ/GwLfsM4nS2FiARAlEeAJsG3T/cTWacqP0lznv6niRw10TFSgCbBtuV
lMdSJEN1hvUwXXfvdeZv2zE=
=JbP6
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
