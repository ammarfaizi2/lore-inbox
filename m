Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271359AbTHMDls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271362AbTHMDlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:41:47 -0400
Received: from h80ad263c.async.vt.edu ([128.173.38.60]:21632 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271359AbTHMDln (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:41:43 -0400
Message-Id: <200308130341.h7D3fbqe003559@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1 and rootflags 
In-Reply-To: Your message of "Tue, 12 Aug 2003 14:25:19 PDT."
             <20030812142519.69a04b7c.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200308121855.h7CIt6St002437@turing-police.cc.vt.edu>
            <20030812142519.69a04b7c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-385539919P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Aug 2003 23:41:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-385539919P
Content-Type: text/plain; charset=us-ascii

On Tue, 12 Aug 2003 14:25:19 PDT, Andrew Morton said:

> The fs-independent options are parsed in user space by mount(8), and are
> passed into the kernel as individual bits in a `flags' argument.

OK.. that's what I *thought* the code was doing.. ;)

> So we'd need a new `rootopts=0x0040' thingy to support this.  But given
> that most things can be set after boot with `mount / -o remount,noatime',
> it may not be necessary.

Can be reset with remount: rdonly, sync, mandlock, atime, diratime.

Can't be reset: nosuid, nodev, noexec, dirsync, and a few others.  Of those,
nosuid and noexec seem pointless for a root file system (though they may make
sense if you have a *really* minimal / and separate /bin /sbin /etc filesystems
- I seem to remember one minimalist config trying to get a r/o / so /etc was a
separate mount...), so at least for my current application, nodev is the only
thing I can't get with remounting....

If there's a consensus that a 'rootopts=' would be a Good Thing, I'll write a
patch.  If not, I'll just fix the initial value of root_mountflags in init/do_mount.c ;)


--==_Exmh_-385539919P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ObNxcC3lWbTT17ARAtemAKDtHocv1BG1cVMhqJs+WhMr+rHW0gCfTs+L
7B/NRkuwTX/Y9vHaOQcQrqI=
=dnKo
-----END PGP SIGNATURE-----

--==_Exmh_-385539919P--
