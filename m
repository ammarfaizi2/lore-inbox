Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUCUTgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 14:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUCUTgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 14:36:11 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:29636 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261204AbUCUTgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 14:36:03 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.4 Hang in utime() on swap file
Date: Sun, 21 Mar 2004 10:52:33 +0100
User-Agent: KMail/1.6
References: <20040320181630.27185.qmail@web10401.mail.yahoo.com> <20040320135530.7f06a7b8.akpm@osdl.org>
In-Reply-To: <20040320135530.7f06a7b8.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403211052.34611.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 20 March 2004 22:55, Andrew Morton wrote:
> ho hum.  We do this to prevent anyone from ftruncate()ing the swapfile
> while it is in use.  That can destroy filesystems.  Let me think about it a
> bit.

Maybe you can deny to open such files with proxy file ops and proxy
block dev ops.

So you implement all file operations and just give back errors.
This has no speed penalty for the hot path and implements correct error
handling.

Only penalty is code bloat, but this is normal for additional error
handling ;-)


But maybe I'm totally wrong here and this is just another case of
"doctor it hurts...".


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAXWXhU56oYWuOrkARAtRAAKDjjyxyXbuH1LS+cJjGIduWYvEc7gCg4Cy2
wfjw7RtJtABR0MtvL07UPGw=
=rB7n
-----END PGP SIGNATURE-----

