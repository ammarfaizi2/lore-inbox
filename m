Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVACWdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVACWdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVACWaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:30:18 -0500
Received: from h80ad2549.async.vt.edu ([128.173.37.73]:9425 "EHLO
	h80ad2549.async.vt.edu") by vger.kernel.org with ESMTP
	id S261924AbVACW3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:29:01 -0500
Message-Id: <200501032227.j03MRocl008354@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: tony osborne <tonyosborne_a@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Main CPU- I/O CPU interaction 
In-Reply-To: Your message of "Mon, 03 Jan 2005 00:44:36 GMT."
             <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl> 
From: Valdis.Kletnieks@vt.edu
References: <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-798545078P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jan 2005 17:27:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-798545078P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Jan 2005 00:44:36 GMT, tony osborne said:

> The I/O devices are equipped with dedicated processor to free the  main CPU 
> from doing the low level I/O operations.

Even a "smart" RAID/SCS/ATA controller is pretty stupid - at best it can be
trusted to find block number N and either read or write it.  If you're *really*
lucky, the controller knows about partitions.  Any further intelligence is the
realm of IBM-style big iron (where the 'set extent' and 'search key high/low/
equal' CCW commands can offload a significant amount of work).  But even there,
the hardware has no filesystem awareness.

>                                          However, if i am editing and 
> updating a big size file and i want to save
> it afterwards, i  notice my PC getting blocked while saving the file which 
> theoritically should NOT happen as it is up to the I/O device processor and 
> not the main CPU to save the data into the disk;

What sort of I/O device processor is (a) supported by Linux *and* (b) filesystem
aware?  Unless it meets both criteria, the main CPU(s) will still have to do
all the work of block allocation, inode creation, and all the rest of that
stuff.

So what sort of hardware were you thinking of, where the "I/O processor" is
smart enough to handle saving a file (from within an application, no less)
without CPU interference?  (and if you're saving the file from within the
application, what API is used to tell the I/O processor whether to use an
"open and fseek to 0" style overwrite, or "rename, creat, write, close, unlink
old" style - all without CPU interference?)

--==_Exmh_-798545078P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB2cblcC3lWbTT17ARAmdpAJ96yt8wTA8Ar5aG9dMx8lEEfRjw0ACeJLX1
5zPEpeT2Dr3e6nN+KcE1AFk=
=qt56
-----END PGP SIGNATURE-----

--==_Exmh_-798545078P--
