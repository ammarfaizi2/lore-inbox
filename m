Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTJaH3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 02:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTJaH3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 02:29:25 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:36035 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263051AbTJaH3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 02:29:02 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Nick Piggin <piggin@cyberone.com.au>, Ivan Gyurdiev <ivg2@cornell.edu>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Fri, 31 Oct 2003 08:28:33 +0100
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200310301601.55588.schlicht@uni-mannheim.de> <3FA1943A.7010300@cornell.edu> <3FA1A171.3040807@cyberone.com.au>
In-Reply-To: <3FA1A171.3040807@cyberone.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_p8go/CmIP8D38GM";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200310310828.41598.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_p8go/CmIP8D38GM
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Friday 31 October 2003 00:40, Nick Piggin wrote:
> Hi,
> If you're testing IDE TCQ, please try the following patch and use the
> default io scheduler. It won't fix anything, but it poisons requests
> so we can sometimes tell if they are being used in the wrong places.
> I have seen warnings that lead me to believe this might be happening.
> Its against 2.6.0-test9-mm1. Report any stack traces you see. Thanks.

OK, I tested 2.6.0-test9-mm1 + your patch, but it seems not to print any=20
messages or stack traces, even if many processes are killed after setting T=
CQ=20
depth to 1.

Today, however, I got reiserfs corruption messages in the logs, but=20
fsck.reiserfs could not find any corruption on the next boot, so I think th=
is=20
is not a real corruption but just reading the wrong data...

The messages are something like:

Oct 31 07:57:53 bigboss kernel: is_tree_node: node level 2120 does not matc=
h=20
to the expected one 1
Oct 31 07:57:53 bigboss kernel: vs-5150: search_by_key: invalid format foun=
d=20
in block 642544. Fsck?
Oct 31 07:57:53 bigboss kernel: vs-13070: reiserfs_read_locked_inode: i/o=20
failure occurred trying to find stat data of [4767268 4767269 0x0 SD]
Oct 31 07:57:53 bigboss kernel: is_tree_node: node level 2120 does not matc=
h=20
to the expected one 1
Oct 31 07:57:53 bigboss kernel: vs-5150: search_by_key: invalid format foun=
d=20
in block 642544. Fsck?
Oct 31 07:57:53 bigboss kernel: vs-13070: reiserfs_read_locked_inode: i/o=20
failure occurred trying to find stat data of [4767268 4767269 0x0 SD]

> Nick

  Thomas

--Boundary-02=_p8go/CmIP8D38GM
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/og8pYAiN+WRIZzQRAjU9AKDWqZ9uHgvlRB5wup+92aWgHkC8ygCgv2Wf
l48zXb3Z5NmOROg9LtNRLQ8=
=TrB2
-----END PGP SIGNATURE-----

--Boundary-02=_p8go/CmIP8D38GM--
