Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVBUF2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVBUF2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 00:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVBUF2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 00:28:41 -0500
Received: from h80ad25e9.async.vt.edu ([128.173.37.233]:60425 "EHLO
	h80ad25e9.async.vt.edu") by vger.kernel.org with ESMTP
	id S261870AbVBUF2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 00:28:01 -0500
Message-Id: <200502210527.j1L5RX44032376@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ian Kent <raven@themaw.net>
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [autofs] automount does not close file descriptors at start 
In-Reply-To: Your message of "Mon, 21 Feb 2005 12:57:22 +0800."
             <Pine.LNX.4.58.0502211244540.9892@wombat.indigo.net.au> 
From: Valdis.Kletnieks@vt.edu
References: <20050216125350.GA6031@uio.no>
            <Pine.LNX.4.58.0502211244540.9892@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108963650_4668P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Feb 2005 00:27:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108963650_4668P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Feb 2005 12:57:22 +0800, Ian Kent said:

> This is the first time I've heard this and the first time I wrote a Unix
> daemon was fifteen years ago.
> 
> As far as I'm concerned redirecting stdin, stdout and stderr to the null 
> device, then closing it and setting the process to a be the group leader 
> (as autofs does) should be all that's needed to daemonize a process.
> 
> So are we saying that we don't trust the kernel to reliably duplicate the 
> state of file handles when we fork?

No, you have it 180 degrees off. ;)

We *do* trust the kernel to reliably duplicate the state of file handles.
So if we're about to do the whole double-fork thing and all that, we want to
loop around and close all the file descriptors we don't want leaking to
the double-forked daemon.  Yes, we do something reasonable with fd 0,1,2 -
but we probably also want to do something with that unclosed fd 3 that's still
open on /etc/mydaemon.cf, and any other file descriptors we've left dangling
in the breeze after initialization.

And yes, this sort of error happens in Real Live - I need to go and figure out
why the /sbin/lvm.static on my initrd is throwing 'File descriptor 3 left open'
messages... 


--==_Exmh_1108963650_4668P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCGXFCcC3lWbTT17ARAvBrAJ9xqEbdN92RWECoLPPk378yIIiK9gCgxx+/
tSq+gNne87iTC6xB8QGxDwM=
=7M30
-----END PGP SIGNATURE-----

--==_Exmh_1108963650_4668P--
