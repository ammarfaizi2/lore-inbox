Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVFXDb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVFXDb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVFXD3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:29:39 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:36813 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263029AbVFXD1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:27:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: spaminos-ker@yahoo.com
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
Date: Fri, 24 Jun 2005 13:27:28 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
References: <20050624023356.63888.qmail@web30705.mail.mud.yahoo.com>
In-Reply-To: <20050624023356.63888.qmail@web30705.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2063186.5mn2sRinXa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506241327.31043.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2063186.5mn2sRinXa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 24 Jun 2005 12:33, spaminos-ker@yahoo.com wrote:
> --- Con Kolivas <kernel@kolivas.org> wrote:
> > I found the same, and the effect was blunted by noatime and
> > journal_data_writeback (on ext3). Try them one at a time and see what y=
ou
> > get.
>
> I had to move to a different box, but get the same kind of results (for
> ext3 default mount options).
>
> Here are the latencies (all cfq) I get with different values for the mount
> parameters
>
> ext2 default
> 0.1s
>
> ext3 default
> 52.6s avg
>
> reiser defaults
> 29s avg 5 minutes
> then,
> 12.9s avg
>
> ext3 rw,noatime,data=3Dwriteback
> 0.1s avg
>
> reiser rw,noatime,data=3Dwriteback
> 4s avg for 20 seconds
> then 0.1 seconds avg
>
>
> So, indeed adding noatime,data=3Dwriteback to the mount options improves
> things a lot.
> I also tried without the noatime, and that doesn't make much difference to
> me.
>
> That looks like a good workaround, I'll now try with the actual server and
> see how things go.

That's more or less what I found, although I found noatime also helped my t=
est=20
cases, but also less than the journal options. Coincidentally I only=20
discovered this recently and hadn't gotten around to telling anyone how=20
dramatic this was and this seemed as good a time as any. I am suspicious th=
at=20
it wasn't this bad in past kernels but haven't been able to instrument=20
earlier kernels to check.

Cheers,
Con

--nextPart2063186.5mn2sRinXa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCu32jZUg7+tp6mRURAjqFAJ4tr7YKNG88xQE6xQnw7efyzz5UogCeMYUt
uJlcD963LOcgu/PMKylFERg=
=f5ke
-----END PGP SIGNATURE-----

--nextPart2063186.5mn2sRinXa--
