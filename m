Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUIYGJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUIYGJk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 02:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUIYGJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 02:09:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57552 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269251AbUIYGJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 02:09:34 -0400
Message-ID: <41550B77.1070604@redhat.com>
Date: Fri, 24 Sep 2004 23:08:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040923
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [time] add support for CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Lameter wrote:

> Then please sign off on the following patch:

Sorry, I fail to see the point.  The CPUTIME stuff will either way be
entire implemented at userlevel.  If we use TSC, we compute the
resolution from the CPU clock speed (no need to comment, I know it's not
reliable everywhere).  If we fall back on realtime, we will simply in
glibc map

   clock_getres (CLOCK_PROCESS_CPUTIME_ID, &ts)

to

   clock_getres (CLOCK_REALTIME, &ts)

The kernel knows nothing about this clock.

The comment changes are OK, of course.

If there is more to change this is in glibc.  So far I have not heard of
anybody wanting to use the clocks this way.  This is why we do not have
the fallback to realtime implemented.  If you say you need it I have no
problem adding appropriate patches.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBVQt32ijCOnn/RHQRAsWHAJ9q1Aztzf7/6TYQbu6X+DNQhFFW5wCfTP57
wbjQQe+iV/s1ODANFFYK+zs=
=JVgJ
-----END PGP SIGNATURE-----
