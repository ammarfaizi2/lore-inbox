Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWAQT7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWAQT7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWAQT7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:59:09 -0500
Received: from host-87-74-62-169.bulldogdsl.com ([87.74.62.169]:15680 "EHLO
	host-87-74-62-169.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964786AbWAQT7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:59:08 -0500
Message-ID: <43CD4C83.9090608@unsolicited.net>
Date: Tue, 17 Jan 2006 19:58:59 +0000
From: David R <david@unsolicited.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cynbe ru Taren <cynbe@muq.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
In-Reply-To: <E1EywcM-0004Oz-IE@laurel.muq.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1564567D46DA07823F284368"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1564567D46DA07823F284368
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Cynbe ru Taren wrote:
> The current Linux kernel RAID5 implementation is just
> too fragile to be used for most of the applications
> where it would be most useful.

I'm not sure I agree.

> What happens repeatedly, at least in my experience over
> a variety of boxes running a variety of 2.4 and 2.6
> Linux kernel releases, is that any transient I/O problem
> results in a critical mass of RAID5 drives being marked
> 'failed', at which point there is no longer any supported

What "transient" I/O problem would this be. I've had loads of issues with
flaky motherboard/PCI bus implementations that make RAID using addin cards
(all 5 slots filled with other devices) a nightmare. The built in controllers
seem to be more reliable.

> way of retrieving the data on the RAID5 device, even
> though the underlying drives are all fine, and the underlying
> data on those drives almost certainly intact.

This is no problem, just use something like

	mdadm --assemble --force /dev/md5 /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1
/dev/sde1

(Then of course do a fsck)

You can even do this with (nr.drives-1), then add in the last one to be
sync'ed up in the background.

> This has just happened to me for at least the sixth time,
> this time in a brand new RAID5 consisting of 8 200G hotswap
> SATA drives backing up the contents of about a dozen onsite
> and offsite boxes via dirvish, which took me the better part
> of December to get initialized and running, and now two weeks
> later I'm back to square one.

:-( .. maybe try the force assemble?

> I'm currently digging through the md kernel source code
> trying to work out some ad-hoc recovery method, but this
> level of flakiness just isn't acceptable on systems where
> reliable mass storage is a must -- and when else would
> one bother with RAID5?

It isn't flaky for me now I'm using a better quality motherboard, in fact it's
saved me through 3 near simultaneous failures of WD 250GB drives.

> We need RAID5 to be equally resilient in the face of
> real-world problems, people -- it isn't enough to
> just be able to function under ideal lab conditions!

I think it is. The automatics are paranoid (as they should be) when failures
are noticed. The array can be assembled manually though.

> A design bug is -still- a bug, and -still- needs to
> get fixed.

It's not a design bug - in my opinion.

> Something HAS to be done to make the RAID5 logic
> MUCH more conservative about destroying RAID5
> systems in response to a transient burst of I/O
> errors, before it can in good conscience be declared

If such things are common you should investigate the hardware.

> ready for production use -- or at MINIMUM to provide
> a SUPPORTED way of restoring a butchered RAID5 to
> last-known-good configuration or such once transient
> hardware issues have been resolved.

It is. See above.

> In the meantime, IMHO Linux RAID5 should be prominently flagged
> EXPERIMENTAL -- NONCRITICAL USE ONLY or some such, to avoid
> building up ill-will and undeserved distrust of Linux
> software quality generally.

I'd calm down if I were you.

Cheers
David

--------------enig1564567D46DA07823F284368
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzUyIDYHcaCYtZo4RAqqlAKDRkV7JZ0n3ZcV0oyTHOkQEGgS4VACgozTz
0jKchbF/h0/ZhRjAAqlBU+s=
=7xXO
-----END PGP SIGNATURE-----

--------------enig1564567D46DA07823F284368--
