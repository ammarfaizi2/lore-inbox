Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUJEPIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUJEPIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUJEPIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:08:24 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:32328 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S269028AbUJEPIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:08:20 -0400
Date: Tue, 5 Oct 2004 11:08:19 -0400
From: Jeffrey Mahoney <jeffm@novell.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] I/O Error Handling for ReiserFS v3
Message-ID: <20041005150819.GA30046@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.108-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey all -

One of the most common complaints I've heard about ReiserFS is how
graceless it is in handling critical I/O errors.

ext[23] can handle I/O errors anywhere, with the results being up to the
system admin to determine: continue, go read only, or panic.

ReiserFS doesn't offer the admin any such choice, instead panicking on
any I/O error in the journal.

The available options are read only or panic, since ReiserFS does not
currently support operations without the journal.

In the four messages that follow, you'll find:
* reiserfs-cleanup-buffer-heads.diff
        - Cleans up handling of buffer head bitfields - uses
          the kernel supplied FNS_BUFFER macros instead.
* reiserfs-cleanup-sb-journal.diff
        - Cleans up accessing of the journal structure, prefering
          to create a temporary variable in functions that access
          the journal structure non-trivially. Should make 0 difference
          at compile time.
* reiserfs-io-error-handling.diff
        - Allows ReiserFS to gracefully handle I/O errors in critical
          code paths. The admin has the option to go read-only or panic.
          Since ReiserFS has no option to ignore the use of the journal,
          the "continue" method is not enabled.
* reiserfs-write-lock.diff
        - Fixes two missing reiserfs_write_unlock() calls on error paths
          that are unrelated to reiserfs-io-error-handling.diff

These patches have seen a lot of testing in the SuSE Linux Enterprise
Server 9 kernel, and are considered ready for mainline.

They've received approval[1] from the ReiserFS maintainers also.

Andrew - Apologies for the previous format; Please apply.

Thanks.

-Jeff

[1] http://marc.theaimsgroup.com/?l=reiserfs&m=109587254714180

--
Jeff Mahoney
SuSE Labs

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBYrjiLPWxlyuTD7IRAqKmAJwLabACpwYwoWQ/OZS11fWmzg45pgCggo1m
RI/aTID7yA29/g0Yp+Oq5cU=
=98hG
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
