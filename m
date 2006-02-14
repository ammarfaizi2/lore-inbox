Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWBNLgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWBNLgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWBNLgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:36:33 -0500
Received: from mivlgu.ru ([81.18.140.87]:18112 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1161013AbWBNLgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:36:32 -0500
Date: Tue, 14 Feb 2006 14:36:17 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Phillip Susi <psusi@cfl.rr.com>, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org, bfennema@falcon.csc.calpoly.edu,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
Message-Id: <20060214143617.3c0719b0.vsu@altlinux.ru>
In-Reply-To: <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>
References: <m3lkwg4f25.fsf@telia.com>
	<84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>
	<43F0B8FC.6020605@cfl.rr.com>
	<Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__14_Feb_2006_14_36_17_+0300_lm2RuYYm1NF.uDHL"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__14_Feb_2006_14_36_17_+0300_lm2RuYYm1NF.uDHL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 14 Feb 2006 09:28:30 +0200 (EET) Pekka J Enberg wrote:

> Yes, I agree that the current code is broken. I was talking about what the 
> semantics should be and that your patch doesn't quite get us there. Do you 
> disagree with that? The UDF specification I am looking at [1] says that -1 
> is used by operating systems that do not support uid/gid to denote an 
> invalid id (although ECMA-167 doesn't seem to have such rule), which is  
> why I think it's an bad idea for Linux to ever write it on disk. Instead, 
> we should always write the proper id on disk unless it was invalid in the 
> first place and we did not explicity change it (via chown, for example).

Storing uid/gid values on the filesystem is not always good.  Imagine
that you need to work with the same removable media on different
machines, where you have accounts with different uids; in this case
uid/gid values stored on one machine have no meaning everywhere else.
It would be good to have a mount option for UDF which turns off the
uid/gid handling completely and shows all files on the filesystem with
uid/gid specified by mount options.

See also the recent thread "Filesystem for mobile hard drive":

http://lkml.org/lkml/2006/2/12/64

>   1. http://www.osta.org/specs/pdf/udf260.pdf

--Signature=_Tue__14_Feb_2006_14_36_17_+0300_lm2RuYYm1NF.uDHL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFD8cC0W82GfkQfsqIRAj4lAJ9ClyRuXTcEQf66uiRSCmoLIvFgHQCgiDDv
uhAHnz+lxJqbVhcAa0fomqI=
=A3yh
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Feb_2006_14_36_17_+0300_lm2RuYYm1NF.uDHL--
