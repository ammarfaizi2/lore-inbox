Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUJGSTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUJGSTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUJGSQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:16:57 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8911 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267487AbUJGSLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:11:39 -0400
Message-Id: <200410071811.i97IBQf0031262@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill a sparse warning in binfmt_elf.c 
In-Reply-To: Your message of "Wed, 06 Oct 2004 15:45:02 PDT."
             <4164756E.4010408@intel.com> 
From: Valdis.Kletnieks@vt.edu
References: <4164756E.4010408@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_47677298P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 14:11:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_47677298P
Content-Type: text/plain; charset=us-ascii

On Wed, 06 Oct 2004 15:45:02 PDT, Arun Sharma said:

> The attached patch kills a sparse warning in binfmt_elf.c:dump_write() by
> adding a __user annotation.

>  static int dump_write(struct file *file, const void *addr, int nr)
>  {
> -	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
> +	return file->f_op->write(file, (const char __user *) addr, nr, &file->f_pos) == nr;
>  }

wouldn't it be more useful to put the annotation into the *prototype* for
the dump_write() function, so that we get sparse typechecking for the
caller(s) of this function?  Your fix just kills the warning - when the *real*
problem is that we're called with a 'void *' that we then cast to something
without any real double check on what it is....

--==_Exmh_47677298P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZYbOcC3lWbTT17ARAsm9AKDg9m7qq+/VdTUn60bg0dL248wlwgCcDL8/
vUlYnW2ccaLORlQsGqqwpyE=
=XQeX
-----END PGP SIGNATURE-----

--==_Exmh_47677298P--
