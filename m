Return-Path: <linux-kernel-owner+w=401wt.eu-S932321AbXAISIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbXAISIr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbXAISIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:08:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:47332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932321AbXAISIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:08:46 -0500
X-Authenticated: #815327
From: Malte =?iso-8859-15?q?Schr=F6der?= <MalteSch@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc4: known unfixed regressions (v2)
Date: Tue, 9 Jan 2007 19:08:40 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       reiserfs-dev@namesys.com
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <20070109052510.GG25007@stusta.de> <Pine.LNX.4.64.0701090944070.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701090944070.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1567743.4G1ty5onrD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701091908.44576.MalteSch@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1567743.4G1ty5onrD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 09 January 2007 18:58, Linus Torvalds wrote:
> On Tue, 9 Jan 2007, Adrian Bunk wrote:
> > Subject : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs)
> > References : http://lkml.org/lkml/2007/1/7/117
> > Submitter : Malte Schr=F6der <MalteSch@gmx.de>
> > Status : unknown
>
> Adrian, this is also available as
>
> 	http://lkml.org/lkml/2007/1/5/308
>
> But, at worst, I don't think this is a show-stopper (oh, well: I actually
> liked it better when "WARN_ON()" said _warning_, not BUG, since it
> separates out the two cases visually much better, but others disagreed.
> Crud).

=2D-8<--

> So something interesting is definitely going on, but I don't know exactly
> what it is. Why does reiserfs do the truncate as part of a close, if the
> same inode is actually mapped somewhere else? And if it's a race with two
> different CPU's (one doing a "munmap()" and the other doing a "close()",
> then the unmap should _still_ have actually unmapped the pages before it
> actually did _its_ "release()" call.

This was on a single core. But with CONFIG_PREEMPT_VOLUNTARY=3Dy.
It didn't happen again since then.=20

>
> In general, a filesystem should never do a truncate at "release()" time
> _anyway_. It should do it at "drop_inode" time.
>
> So I think this does show some confusion in reiserfs, but it's not
> anything new. The only new thing is that the _message_ happens.
>
> So I don't personally consider this a regression. Just a sign of old and
> preexisting confusion that is now uncovered by new code (and it will print
> out the scary message at most four times, and then stop complaining about
> it. So apart from the scary message, nothing new and bad has really
> happened).

I also didn't reboot the machine afterwards and did not notice any problems=
=20
beside that one message.

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--nextPart1567743.4G1ty5onrD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFo9os4q3E2oMjYtURAkSZAJ9Il7806Vk5C3c81kjVra4MYBKvsQCgooF5
rdRRxcOgHLIeoEzBxQVRUDA=
=QxGe
-----END PGP SIGNATURE-----

--nextPart1567743.4G1ty5onrD--
