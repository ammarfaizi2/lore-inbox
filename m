Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTH1SrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbTH1SrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:47:22 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:12454
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264181AbTH1SrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:47:20 -0400
Message-ID: <3F4E4E13.1000301@redhat.com>
Date: Thu, 28 Aug 2003 11:46:43 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: ->pid in dnotify
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000806070101070905030904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000806070101070905030904
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm not entirely sure about this change.  But it seems to be necessary.
 The dnotify code stores the PID in the file structure.  The entire
process shares the file and any signal (is it used for that?) should be
sent to the process (thread group), not the individual thread.  Also
keep in mind that threads can go away while the process (and therefore
file descriptor) remain.  And the ID of the thread can be reused.

Somebody who knows this code should take a good look.

- --
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Tk4T2ijCOnn/RHQRAh5cAJkBTNx7g9pj+naBm5fyftI9LatRTACfaPkg
t/ZzWXPAjlaqRJc+wIRP8AU=
=x8G3
-----END PGP SIGNATURE-----

--------------000806070101070905030904
Content-Type: text/plain;
 name="d-dnotify-pid"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-dnotify-pid"

LS0tIGxpbnV4L2ZzL2Rub3RpZnkuYy1zYXZlCTIwMDMtMDQtMDMgMTA6MDQ6MDMuMDAwMDAw
MDAwIC0wODAwCisrKyBsaW51eC9mcy9kbm90aWZ5LmMJMjAwMy0wOC0yOCAxMTo0MToyMy4w
MDAwMDAwMDAgLTA3MDAKQEAgLTk0LDcgKzk0LDcgQEAKIAkJcHJldiA9ICZvZG4tPmRuX25l
eHQ7CiAJfQogCi0JZXJyb3IgPSBmX3NldG93bihmaWxwLCBjdXJyZW50LT5waWQsIDEpOwor
CWVycm9yID0gZl9zZXRvd24oZmlscCwgY3VycmVudC0+dGdpZCwgMSk7CiAJaWYgKGVycm9y
KQogCQlnb3RvIG91dF9mcmVlOwogCg==
--------------000806070101070905030904--

