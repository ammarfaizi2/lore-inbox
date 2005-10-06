Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVJFIEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVJFIEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVJFIEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:04:24 -0400
Received: from h80ad2531.async.vt.edu ([128.173.37.49]:28573 "EHLO
	h80ad2531.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750720AbVJFIEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:04:22 -0400
Message-Id: <200510060803.j9683aXK026732@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Your message of "Thu, 06 Oct 2005 00:03:09 BST."
             <20051005230309.GO10538@lkcl.net> 
From: Valdis.Kletnieks@vt.edu
References: <20051005095653.GK10538@lkcl.net> <200510051847.j95IlRTS012444@laptop11.inf.utfsm.cl>
            <20051005230309.GO10538@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128585815_4102P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Oct 2005 04:03:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128585815_4102P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Oct 2005 00:03:09 BST, Luke Kenneth Casson Leighton said:
> On Wed, Oct 05, 2005 at 02:47:27PM -0400, Horst von Brand wrote:

> > Nope. SELinux provides MAC, 
> 
>  yes.
> 
> > i.e., mechanisms by which system-wide policy
> > (not the random owner of an object) ultimately decides what operations to
> > allow. 
> 
>  yes.  the concept is not incompatible with what i said: the only bit
>  that is wrong with what you've said is the word "Nope".
> 
> > That is not "file permissions". 
> 
>  part of the coverage of the MAC is file and directory permissions, and
>  as i mentioned earlier, it so happens that each selinux permission
>  corresponds, i believe one-to-one, with a function in the dnode and
>  inode vfs higher-order-function tables in the linux kernel.
> 
>  example permissions (from postfix.te, policy source version 18):
> 
> 	allow postfix_$1_t { sbin_t bin_t }:dir r_dir_perms;
> 	allow postfix_$1_t { bin_t usr_t }:lnk_file { getattr read };
> 	allow postfix_$1_t shell_exec_t:file rx_file_perms;
> 
>  i am confident enough with selinux to say that those are file
>  and directory permissions.

The part that you managed to miss is that this is MAC - *Mandatory*
Access Control.  This means that the *sysadmin* gets to say "this user
can't look at that file" - and there's nothing(*) either the owner of the
file or the user can do about it.  There's no chmod or chattr or chacl
command that the owner can issue to let somebody else read it - that's
the whole *point* of MAC.

(*) Well.. almost nothing.  The owner *may* be able to copy the contents
of the file to another file that the other user is allowed to read.  On the
other hand, the ability to do this would generally indicate a buggy policy....

--==_Exmh_1128585815_4102P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDRNpXcC3lWbTT17ARAjntAKCB7H70PMpxqKcvZmXbinxHMv7fbACfYZ8O
uD7iHdQpCrP9ppmGdI127mY=
=+eQf
-----END PGP SIGNATURE-----

--==_Exmh_1128585815_4102P--
