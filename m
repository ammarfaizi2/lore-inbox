Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266478AbTGEUXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266483AbTGEUXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:23:44 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:59110 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S266478AbTGEUXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:23:42 -0400
Date: Sat, 05 Jul 2003 16:37:43 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
In-reply-to: <E19YtAq-0006Xf-00@calista.inka.de>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com,
       Jeff Garzik <jgarzik@pobox.com>
Message-id: <200307051637.52252.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <E19YtAq-0006Xf-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 05 July 2003 15:58, Bernd Eckenfels wrote:
> a reader like ifconfig can easyly work around this with multiple tries, but
> incremeting those variables wont work that easy, and therefore needs a
> lock, which will be a major pita.
>
> 64bit counters should be a result of lockless per-cpu network counters
> (32bit) with some kind of async merging.

This is going to make the structure huge - not only you have the 32-bit 
variables for every CPU, but you have one global set of 64-bit variables 
(possibly you will need a lock for the 64-bit vars.)

Also another thing to consider is portability across architectures - we don't 
need all this code on 64-bit arches.

On the other hand, per-cpu stats may possibly make up for the extra code - no 
cache bouncing, etc.

> Or we wait till 64bit hardware is more common :)

Hehe, the thing is, that when 64bits beecome more common you will have this 
huge number of unused x86 computers that people will:

- - throw out
- - donate
- - convert to all sorts of "embedded" systems which need stable OS (read: 
Linux) (these include routers)

So, x86 is here to stay for some time.

Jeff.

- -- 
The Moon is Waxing Crescent (36% of Full)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BzcbwFP0+seVj/4RAuMHAJ9sN0E4OgsPeM09D6hbgM3boECLDwCbBDTP
6u8SSobW0+Y0oWq3H4koHd0=
=Z89A
-----END PGP SIGNATURE-----

