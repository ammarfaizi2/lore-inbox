Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUIEH1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUIEH1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 03:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUIEH1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 03:27:51 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:30670 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S266316AbUIEH1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 03:27:46 -0400
Date: Sun, 5 Sep 2004 17:27:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The argument for fs assistance in handling archives (was:
 silent semantic changes with reiser4)
Message-Id: <20040905172741.78aef274.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.58.0409021315111.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
	<200408282314.i7SNErYv003270@localhost.localdomain>
	<20040901200806.GC31934@mail.shareable.org>
	<Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	<1094118362.4847.23.camel@localhost.localdomain>
	<Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
	<1094150760.5809.30.camel@localhost.localdomain>
	<Pine.LNX.4.58.0409021315111.2295@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__5_Sep_2004_17_27_41_+1000_K5lqhE1xJJm+C6QO"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__5_Sep_2004_17_27_41_+1000_K5lqhE1xJJm+C6QO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 2 Sep 2004 13:22:41 -0700 (PDT) Linus Torvalds <torvalds@osdl.org> wrote:
>
> Well, dnotify() really _is_ inotify(), since it does actually work on 
> inodes, not dentries.

The "d" stands for directory not dentry :-)

> I think what they are really complaining about is that dnotify() only 
> notifies the _directory_ when a file is changed, and they'd like it to 
> notify the file itself too. Which is a one-liner, really.

I don't think so, since this notify will only happen if the process has
registered for the notification and there is no way to register unless the
file is a directory ...

> Does the following make sense? (Totally untested, use-at-your-own-risk, 
> I've-never-actually-used-dnotify-in-user-space, whatever).

I had intended to extend dnotify to do file notifies, but I think the
real killer is needing the keep the file open that you want to be
notified about when you want to be notified about lots of files ...

I think that is what inotify was trying to fix (but I haven't had a chance
to look at it recently).  It reminds me of omirr that we had many years
ago - I wonder what happened to it?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__5_Sep_2004_17_27_41_+1000_K5lqhE1xJJm+C6QO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBOr/t4CJfqux9a+8RAmFmAJ9bV83AgHi9BISVZegmZ+EXeC7RygCfRule
hyReitE+BU9zAjsiitp+5/E=
=U2d/
-----END PGP SIGNATURE-----

--Signature=_Sun__5_Sep_2004_17_27_41_+1000_K5lqhE1xJJm+C6QO--
