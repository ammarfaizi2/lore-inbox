Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVFWXed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVFWXed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVFWXeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:34:31 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:48056 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262883AbVFWXeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:34:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org, spaminos-ker@yahoo.com
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
Date: Fri, 24 Jun 2005 09:33:53 +1000
User-Agent: KMail/1.8.1
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
References: <20050623183051.98655.qmail@web30710.mail.mud.yahoo.com>
In-Reply-To: <20050623183051.98655.qmail@web30710.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1551494.juKB0KsZ6r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506240933.55951.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1551494.juKB0KsZ6r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 24 Jun 2005 04:30, spaminos-ker@yahoo.com wrote:
> --- Jens Axboe <axboe@suse.de> wrote:
> > Journalled file systems will behave worse for this, because it has to
> > tend to the journal as well. Can you try mounting that partition as ext2
> > and see what numbers that gives you?
>
> I did the tests again on a partition that I could mkfs/mount at will.
>
> On ext3, I get about 33 seconds average latency.
>
> And on ext2, as predicted, I have latencies in average of about 0.4
> seconds.
>
> I also tried reiserfs, and it gets about 22 seconds latency.
>
> As you pointed out, it seems that there is a flow in the way IO queues and
> journals (that are in some ways queues as well), interact in the presence
> of flushes.

I found the same, and the effect was blunted by noatime and=20
journal_data_writeback (on ext3). Try them one at a time and see what you=20
get.

Cheers,
Con

--nextPart1551494.juKB0KsZ6r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCu0bjZUg7+tp6mRURAhPPAJ46XcrflO3LSn5xaAAszUFsSYPS/QCfULLf
BS2wcpNz4XBAhdVdx/lAPZE=
=rCyR
-----END PGP SIGNATURE-----

--nextPart1551494.juKB0KsZ6r--
