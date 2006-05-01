Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWEAHCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWEAHCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWEAHCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:02:34 -0400
Received: from h80ad25b9.async.vt.edu ([128.173.37.185]:64466 "EHLO
	h80ad25b9.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751290AbWEAHCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:02:34 -0400
Message-Id: <200605010702.k4172Q5H006348@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Circuitsoft Development <circuitsoft.devel@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Extended Volume Manager API 
In-Reply-To: Your message of "Mon, 01 May 2006 00:26:05 CDT."
             <64b292120604302226i377f1c37qd33db36693ea1871@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <64b292120604302226i377f1c37qd33db36693ea1871@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146466945_20203P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 01 May 2006 03:02:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146466945_20203P
Content-Type: text/plain; charset=us-ascii

On Mon, 01 May 2006 00:26:05 CDT, Circuitsoft Development said:

> Having done my own tests, I've determined that a 5msec timeout to
> determine if a host has crashed would be appropriate. (My test was
> basically looking at ping time over a saturated network - averaged
> about 600 microseconds, topped at 3msec over 10 minutes) I figure that
> 5msec timeout won't add any noticeable lag to the volume manager, as
> most disk seek times are in that range.W

Note that if you're setting 5ms as your timeout for detecting a *crash*,
and your *ping* takes 3ms, that leaves you a whole whopping 2ms.  If you
have 1ms scheduler latency at *each* end (remember - you're in userspace
at both ends, right?) you have approximately 0ms left for the remote end to
actually *do* anything, and for the local end to process the reply.

And if the remote end has to issue a syscall during processing the request,
you're basically screwed.

You need to be adding at least 1 zero to that timeout value.

--==_Exmh_1146466945_20203P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEVbKBcC3lWbTT17ARAtZ0AJ9/aYLH0OFTb+xNx/CWtEh3ZNiZeACaAtPO
v6NGgj4LCtq67vTBLd5NIUo=
=LHIe
-----END PGP SIGNATURE-----

--==_Exmh_1146466945_20203P--
