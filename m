Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTFTOdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTFTOdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:33:37 -0400
Received: from camus.xss.co.at ([194.152.162.19]:59154 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S262328AbTFTOdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:33:36 -0400
Message-ID: <3EF31E87.6050804@xss.co.at>
Date: Fri, 20 Jun 2003 16:47:35 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tobias Reinhard <T.Reinhard@losekann.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem unmounting initrd-romfs in 2.4.21
References: <BDB86409B697CB4DBB8A5BF487B9D61A3933@srv01.losekann.local>
In-Reply-To: <BDB86409B697CB4DBB8A5BF487B9D61A3933@srv01.losekann.local>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Tobias Reinhard wrote:
> Hi all!
>
> I'm booting up with a initrd in a romfs. After loading all needed
> modules and pivoting root I unmount the initrd and flush the used
> buffers.
>
> Since I updated to 2.4.21 I can't unmount the initrd - it says it's
> busy, but it's no (or at least lsof does say so).
>
> I use kernel 2.4.21 with /drivers/Makefile , /drivers/ide and
> /include/linux/ide.h from ac1 to reenable ide-modules.
>
> Anyone know the problem?
>
Hm, just a guess: do you have devfs mounted to /dev
on the initial ramdisk (probably automounted by the
kernel, with config option CONFIG_DEVFS_MOUNT=y)?

Check the output of "mount", it'll show you if there's
still something mounted under the "old" root.

We use initrd + devfs for ages now (we even use romfs for
initrd like you do), and it works fine with 2.4.21 too.

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+8x6CxJmyeGcXPhERAs7RAKCWiPn2qnLvI9v6GdVj3djPeBcPvQCeP1X2
Fd/GfnFm7tWiCGpp6A6zO6c=
=V9df
-----END PGP SIGNATURE-----

