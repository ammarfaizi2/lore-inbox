Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbULCNqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbULCNqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 08:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbULCNqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 08:46:01 -0500
Received: from procert.cert.dfn.de ([193.174.13.1]:58317 "EHLO
	procert.cert.dfn.de") by vger.kernel.org with ESMTP id S261457AbULCNpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 08:45:49 -0500
Date: Fri, 3 Dec 2004 14:43:45 +0100
From: Friedrich Delgado Friedrichs <delgado@dfn-cert.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, delgado@dfn-cert.de
Subject: Re: Problem: Kernel Panic/Oops on shutdown with 2.6.9 and Dell Optiplex SX280
Message-ID: <20041203134344.GA13010@kermit.dfn-cert.de>
Reply-To: linux-kernel@vger.kernel.org, delgado@dfn-cert.de
References: <20041130160717.GA13106@kermit.dfn-cert.de> <20041130194456.57c5f737.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20041130194456.57c5f737.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Organization: DFN-CERT Services GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I've applied your patch and thankfully the bug was triggered on the
next shutdown (after I had installed the new kernel on the first
workstation).

Andrew Morton schrieb:
> It's interesting that this only happens during shutdown: something may be
> racing against an unmount.

I doubt that. It appears that the bug is triggered somewhere in this
sequence:

K10arpwatch@
K10fbset@
K10powersaved@
K10running-kernel@
K10sshd@
K10update-client@

i.e. after (during) arpwatch shutdown, and before update-client is
run. The latter is an administration script which performs some
lengthy operations on mounted filesystems (fetch updates for packages
and configuration files from a central location).

> I'd suggest that you run with the below patch which, if it's right, will
> display the offending path and will then pause for ten seconds.  If we can
> identify which filesystem type that path lives on then perhaps we can make
> some progress.

Dec  2 17:03:11 kermit arpwatch: exiting
Dec  2 17:03:12 kermit sshd[4564]: Received signal 15; terminating.
Dec  2 17:03:12 kermit kernel: __d_path: skipping NULL vfsmnt
Dec  2 17:03:22 kermit kernel: path: `'
Dec  2 17:03:22 kermit kernel: device eth0 left promiscuous mode

I bet an empty string isn't quite helpful here, or is it?

I'm not quite sure how to proceed now. I'd like to try out 2.6.10rc2
as Alan Cox proposed + maybe we could get some more useful information
out of __d_path

Kind regards
     FDF
--
Friedrich Delgado Friedrichs (IT-Services), DFN-CERT Services GmbH
https://www.dfn-cert.de, +49 40 808077-555 (Hotline)
12. DFN-CERT Workshop und Tutorien, CCH Hamburg, 2-3. Maerz 2005

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQbBtkPqefzmUpgR/AQHTNgf/YtmuoOoQCOHLHSLMldTh8WQb957hfr1f
2vLZVNmBjSHNuzohQ0AWBH0TPeSuVHCcJ7xJzBZGyszVqYM82SrY+DDeg+XVuwP4
s3YGTNrIdlS/Jq7H3XyJ8Zv/yn1Ww78HG05kgCxAhNkhDU9jRIXGkNIQhm68XSSK
wFiDZl72QBUbfoB6LrUa76uEqBlVq4xzlcLW7oNXpbn7pHOdKNTHYKwIkG/B5VRI
DsYOWTOuPOgqCuT67r1en1ZavSSR6kGMyrmuyxrJcVJVRdcQBruYWuK+esJqEq4K
JH0XK9YCMhglMOJy1QcvtHcdsNIhujydzqSf88eASD3WaD3jqhoEmg==
=AfFn
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
