Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUJCHIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUJCHIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 03:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUJCHIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 03:08:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61359 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267739AbUJCHIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 03:08:50 -0400
Message-ID: <415FA561.2010804@redhat.com>
Date: Sun, 03 Oct 2004 00:08:17 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041001
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Avoid unnecessary copy for EPOLL_CTL_DEL
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000106030609090100000003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000106030609090100000003
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When epoll_ctl() is used with the EPOLL_CTL_DEL operation the event
structure pointed to by the fourth parameter is unnecessarily copied.
It is not used and userlevel would have to initialize some memory to
avoid passing down a pointer to some uninitialized memory.  The attached
patch should work just fine.

Signed-off-by: Ulrich Drepper <drepper@redhat.com>

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBX6Vh2ijCOnn/RHQRAo0HAJ0UyKipkrlhK6xiNgeoOBsoK7bxEgCgqCMK
xI430mMmGxi9Ce1jBTZFYK4=
=Gq3D
-----END PGP SIGNATURE-----

--------------000106030609090100000003
Content-Type: text/plain;
 name="d-epoll-del"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-epoll-del"

LS0tIGZzL2V2ZW50cG9sbC5jCTIwMDQtMDgtMjYgMTk6MTQ6NTEuMDAwMDAwMDAwIC0wNzAw
CisrKyBmcy9ldmVudHBvbGwuYy5uZXcJMjAwNC0xMC0wMyAwMDowNDozMy4wMDAwMDAwMDAg
LTA3MDAKQEAgLTUzMSw3ICs1MzEsOCBAQCBzeXNfZXBvbGxfY3RsKGludCBlcGZkLCBpbnQg
b3AsIGludCBmZCwgCiAJCSAgICAgY3VycmVudCwgZXBmZCwgb3AsIGZkLCBldmVudCkpOwog
CiAJZXJyb3IgPSAtRUZBVUxUOwotCWlmIChjb3B5X2Zyb21fdXNlcigmZXBkcywgZXZlbnQs
IHNpemVvZihzdHJ1Y3QgZXBvbGxfZXZlbnQpKSkKKwlpZiAob3AgIT0gRVBPTExfQ1RMX0RF
TCAmJgorCSAgICBjb3B5X2Zyb21fdXNlcigmZXBkcywgZXZlbnQsIHNpemVvZihzdHJ1Y3Qg
ZXBvbGxfZXZlbnQpKSkKIAkJZ290byBlZXhpdF8xOwogCiAJLyogR2V0IHRoZSAic3RydWN0
IGZpbGUgKiIgZm9yIHRoZSBldmVudHBvbGwgZmlsZSAqLwo=
--------------000106030609090100000003--
