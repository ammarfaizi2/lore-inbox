Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266658AbUF3MlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266658AbUF3MlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUF3MlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:41:12 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:51613 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266658AbUF3Mk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:40:57 -0400
Message-ID: <40E2B4D0.90100@kolivas.org>
Date: Wed, 30 Jun 2004 22:40:48 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ck kernel mailing list <ck@vds.kolivas.org>
Subject: [PATCH] Staircase scheduler v7.8
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is a scheduler policy rewrite designed to be interactive by design
without tweaks or tuning and be lean and extensible for all sorts of
settings. (see previous announcements for more detail).


Patches (including incrementals from previous versions) against 2.6.7
can be downloaded from:
http://ck.kolivas.org/patches/2.6/2.6.7

For those with -ck kernels, the ck patchset was updated to 2.6.7-ck4
with no other changes to remain in sync with the staircase scheduler:
http://kernel.kolivas.org


Version 7.7 proved to be very stable so this version introduces some
planned improvements. So far no issues have shown up in testing, and
performance appears better.


Changes:
- - Yield logic made robust. Tasks that yield go after everything else,
but once scheduled are seen as their normal priority - lots of
applications use yield and this makes them behave a lot better.
- - Uninterruptible sleep has no effect on burst during interactive mode -
this improves the responsiveness under I/O load
- - The 'non-interactive' and 'compute' mode is now much stricter about
cpu distribution
- - Code cleanups


Patch not attached for brevity of email size.
7 files changed, 283 insertions(+), 610 deletions(-)
Signed-off-by: Con Kolivas <kernel@kolivas.org>

Comments, questions, patches and testing welcome,
Con

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4rTQZUg7+tp6mRURAi+tAJ9ZvacG1YlZPqLZP2qkwx1L3lTGGgCgkvkE
ekatU5O6OGH7r7Y8ID42SUE=
=HVc4
-----END PGP SIGNATURE-----
