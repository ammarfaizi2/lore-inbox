Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266402AbTGESfP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 14:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266412AbTGESfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 14:35:15 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:41348 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S266402AbTGESfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 14:35:10 -0400
Date: Sat, 05 Jul 2003 14:49:20 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
In-reply-to: <Pine.LNX.4.44.0307032005340.8468-100000@home.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com
Message-id: <200307051449.32934.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0307032005340.8468-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 03 July 2003 23:08, you wrote:
> Please do this in user space. The "overflow every 2^32 packets" thing is
> _not_ a problem, if you just gather the statistics at any kind of
> reasonable interval.
<snip>

While discussing this patch on IRC, an interesting idea came up: why not make 
the counters count something different from bytes? "Less granular stats are 
every bit (bad pun intended) as useful." This would break userspace, but 
that's what everyone has to expect during odd releases (i.e. the modules in 
2.5.)

To avoid having to change all the code, we could have (in addition to what we 
currently have) something like tx_kbytes or tx_mbytes which would be updated 
via a timer every x milliseconds (I'd say maybe 350-500). The sysfs and 
procfs interfaces would have to be modified, however those are just couple of 
lines of code.

Using KB would give us additional 10 bits (making the overflow at 4 TB.) I 
don't really like the idea of using MB, but the underlying idea is the same - 
20 more bits, making the limit 4 PB.

What is the consensus on this way of solving the problem?

Jeff.

- -- 
Failure is not an option,
It comes bundled with your Microsoft product.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQE/Bx23wFP0+seVj/4RApsVAJUaKZG6px09U87j6tCakrQQebj6AKC52f55
xSuyYxe62N8kefAoxposfg==
=As/F
-----END PGP SIGNATURE-----

