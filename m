Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUJGTCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUJGTCU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUJGTA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:00:58 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39307 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267804AbUJGSzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:55:02 -0400
Message-Id: <200410071854.i97IsvU5031703@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill a sparse warning in binfmt_elf.c 
In-Reply-To: Your message of "Thu, 07 Oct 2004 11:49:24 PDT."
             <41658FB4.5090402@intel.com> 
From: Valdis.Kletnieks@vt.edu
References: <4164756E.4010408@intel.com> <200410071811.i97IBQf0031262@turing-police.cc.vt.edu>
            <41658FB4.5090402@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_55520739P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 14:54:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_55520739P
Content-Type: text/plain; charset=us-ascii

On Thu, 07 Oct 2004 11:49:24 PDT, Arun Sharma said:

> >>  static int dump_write(struct file *file, const void *addr, int nr)
> >>  {
> >> -	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
> >> +	return file->f_op->write(file, (const char __user *) addr, nr, &file->f
_pos) == nr;
> >>  }
> > 
> > wouldn't it be more useful to put the annotation into the *prototype* for
> > the dump_write() function, so that we get sparse typechecking for the
> > caller(s) of this function?  Your fix just kills the warning - when the *re
al*
> > problem is that we're called with a 'void *' that we then cast to something
> > without any real double check on what it is....
> 
> dump_write() is a static function without a prototype.

static int dump_write(struct file *file, const char __user *addr, int nr)
{
	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
}

And then go find the callers and make sure what they're passing is a
'const char __user *' rather than a 'const void *'....

--==_Exmh_55520739P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZZEBcC3lWbTT17ARAhSnAKCLTlNBhEGuFiGHDIxJjQLnqNoY6gCgjge5
A4e8WvQ1FzUIIHzXUlzzrFc=
=QodB
-----END PGP SIGNATURE-----

--==_Exmh_55520739P--
