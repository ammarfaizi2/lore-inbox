Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVB1AvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVB1AvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVB1AvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:51:05 -0500
Received: from ylpvm53-ext.prodigy.net ([207.115.57.84]:6019 "EHLO
	ylpvm53.prodigy.net") by vger.kernel.org with ESMTP id S261527AbVB1At6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:49:58 -0500
Message-ID: <422269BA.9070308@ecs.fullerton.edu>
Date: Sun, 27 Feb 2005 16:45:46 -0800
From: Eric Gaumer <gaumerel@ecs.fullerton.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <hermes@gibson.dropbear.id.au>
CC: linux-kernel@vger.kernel.org, proski@gnu.org
Subject: Re: [PATCH] orinoco rfmon
References: <4220BB87.2010806@ecs.fullerton.edu> <20050227033944.GA15380@localhost.localdomain>
In-Reply-To: <20050227033944.GA15380@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5CF27C2B398BC7041F6F2BBF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5CF27C2B398BC7041F6F2BBF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Gibson wrote:
>
> This looks like the ancient version of the monitor patch - which
> includes importing a lot of needless junk from the linux-wlan-ng
> tree.  A cleaned up version of monitor has been merged in the orinoco
> CVS tree for ages now, but unfortunately that's long overdue for a
> merge with mainline.  I'm trying to get that merge done - I just don't
> have much time or energy for the orinoco driver these days.  One stack
> of patches which gets part of the way went to Jeff Garzik last week.
> We'll see how we go.
>
> In the meantime go to http://savannah.nongnu.org/projects/orinoco for
> access to the driver CVS.  You probably want to get the "for_linus"
> branch of CVS if you're planning to work with 2.6.
>

Thanks David, the CVS code works great with the small excpetion of the following change to
get it to build.

diff -Nru orinoco-cvs/orinoco_cs.c orinoco-build/orinoco_cs.c
--- orinoco-cvs/orinoco_cs.c    2005-02-26 22:21:55.000000000 -0800
+++ orinoco-build/orinoco_cs.c  2005-02-27 15:00:07.698368136 -0800
@@ -428,7 +428,7 @@
         SET_MODULE_OWNER(dev);
         card->node.major = card->node.minor = 0;

-       SET_NETDEV_DEV(dev, &handle_to_dev(handle));
+       dev->name[0] = '\0';
         /* Tell the stack we exist */
         if (register_netdev(dev) != 0) {
                 printk(KERN_ERR PFX "register_netdev() failed\n");


What's the deal with the broken firmware for monitor mode?

  * v0.15rc1 -> v0.15rc2 - 28 Jul 2004 - Pavel Roskin & David Gibson
  *      o orinoco_pci saves PCI registers on suspend (Simon Huggins).
  *      o Monitor mode disabled on Agere 8.xx firmware - it's broken.

I have 8.4 but things seem fine (used this card in monitor mode for over a year without
problems).

I just disabled the check for broken firmware and things seem fine (better than the original
patch I posted). The iwlist command now works. Could the buggy firmware be generalized a bit
too much? Perhaps only certain versions > 8 are buggy?


--
"Education is what remains after one has forgotten everything he learned in school."
	- Albert Einstein

--------------enig5CF27C2B398BC7041F6F2BBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCImm6ZWL8hfFdQekRAr9ZAJ48b8kVt4PsMBLenE9L8mm2zljEGwCeO7fB
P3SV/UVHcNw1yWWP+oR0vsg=
=ZLpI
-----END PGP SIGNATURE-----

--------------enig5CF27C2B398BC7041F6F2BBF--
