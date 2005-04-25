Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVDYWYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVDYWYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVDYWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:24:46 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:32933 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261259AbVDYWYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:24:20 -0400
Date: Mon, 25 Apr 2005 16:24:16 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: [2.6 patch] fs/jbd/: possible cleanups
Message-ID: <20050425222416.GX4752@schnapps.adilger.int>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, sct@redhat.com,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
References: <20050422235717.GI4355@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <20050422235717.GI4355@stusta.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Apr 23, 2005  01:57 +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global functions static
> - #if 0 the following unused global functions:
>   - journal.c: __journal_internal_check

>  /* Static check for data structure consistency.  There's no code
>   * invoked --- we'll just get a linker failure if things aren't right.

The comment above this function specifically says no code is generated
here - the purpose of this function is to generate an error if the
journal superblock is the wrong size (e.g. someone adds fields without
updating the padding).

> - remove the following write-only global variable:
>   - journal.c: current_journal

Looks to be debugging only, seems OK to remove.

>   - journal.c: journal_check_used_features

I'm not aware of any current users of journal_check_used_features(), but
the complementary function journal_check_available_features() IS used by
ext3 and I can imagine that if we ever need to add some more journaling
features it would be useful instead of mucking in the journal internals.

>   - journal.c: journal_recover

Looks like the correct API is actually journal_load() so it seems OK to
unexport.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCbW4QpIg59Q01vtYRApPqAKCsRkcpuO9aO2hDFgDGsrkJmK4mXgCgjUNt
6BkQYtGCxmAnlOClyeCAzTg=
=AFJA
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
