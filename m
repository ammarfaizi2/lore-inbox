Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVBGQxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVBGQxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVBGQxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:53:43 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12046 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261192AbVBGQxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:53:23 -0500
Message-Id: <200502071652.j17GqmJA010393@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux lover <linux_lover2004@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: How to read file in kernel module? 
In-Reply-To: Your message of "Mon, 07 Feb 2005 07:38:36 +0100."
             <1107758316.3886.58.camel@laptopd505.fenrus.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050207061718.47940.qmail@web52203.mail.yahoo.com>
            <1107758316.3886.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107795162_3249P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Feb 2005 11:52:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107795162_3249P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Feb 2005 07:38:36 +0100, Arjan van de Ven said:
> On Sun, 2005-02-06 at 22:17 -0800, linux lover wrote:

> > Now what i want is to use same bufproc_read &
> > bufproc_write  functions defined in /proc file
> > handling kernel module to be used in another kernel
> > module to read that /proc/file in kernel module.The
> > second kernel module only used to read /proc file in
> > kernel. I am not understanding how can i open that
> > /proc/file in second kenrel module to read in kernel?
> > regards,
> 
> the answer really is that you should not read files from kernel
> modules; /proc or otherwise.

As Arjan said - what you probably want to be doing instead is changing
the code in your first module that provides the bufproc_* functions so
that they're wrappers around some code that does the "real work", and
then call the real_work function from your second module.  Most likely,
what you *really* want to be passing around is some 'struct *foo', and
the bufproc_* functions are converting to/from a struct foo and a linear
byte stream.  (In the limiting case where it's just one variable, why not
just 'EXPORT_SYMBOL(variable)' in the first module and then just assign or
read the variable from the second module?)


--==_Exmh_1107795162_3249P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCB5zacC3lWbTT17ARAss+AKDYo32jRs9oVhUN7ARf4kf4akT+KACg90kb
mYYkZDK6vFucRQRf9swLVLo=
=oZSd
-----END PGP SIGNATURE-----

--==_Exmh_1107795162_3249P--
