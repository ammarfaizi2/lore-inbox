Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbULNVkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbULNVkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbULNVkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:40:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261671AbULNVkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:40:16 -0500
Message-ID: <41BF5D41.6030001@redhat.com>
Date: Tue, 14 Dec 2004 13:38:09 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Roland McGrath <roland@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
References: <200412140355.iBE3t7KL008040@magilla.sf.frob.com> <Pine.LNX.4.58.0412140939010.1546@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0412140939010.1546@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4DC89F830BDC64559FFE7C2E"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4DC89F830BDC64559FFE7C2E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Christoph Lameter wrote:

> Posix does not prescribe any access limitations for those clocks and as
> far as I understand the standard, access to all process clocks needs to
> be possible.

And how exactly do you plan to address clocks of various threads in 
another process?  Threads are only identified by the pthread_t 
descriptor.  These values have no meaning outside the process the 
threads are in.  The TIDs we use in the implementation cannot be used. 
They are an implementation detail and a thread might very well have 
different TIDs over time in future versions of the thread library.

The pthread_getcpuclockid() and similar uses return clock IDs which are 
only meaningful in the calling process.  Using the value in another 
process has undefined results.  I.e., what Roland says is correct, the 
limitation is needed.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

--------------enig4DC89F830BDC64559FFE7C2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBv11B2ijCOnn/RHQRArFrAJ47rmmDMVZTkDayHcMrJY5Ey2xigACfarbF
ceaYYCRSdI8dAsCy63kq48E=
=FcSX
-----END PGP SIGNATURE-----

--------------enig4DC89F830BDC64559FFE7C2E--
