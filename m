Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTFPBRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 21:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTFPBRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 21:17:23 -0400
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:52193 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S263201AbTFPBRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 21:17:22 -0400
Date: Sun, 15 Jun 2003 21:30:47 -0400
From: Jeff <jeffpc@optonline.net>
Subject: 64-bit fields in struct net_device_stats
To: linux-kernel@vger.kernel.org
Message-id: <200306152131.09983.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,
	I was looking for a project that would take some time to finish, and I think 
I found it - converting all code in the kernel to use u_int64_t (or similar) 
instead of unsigned long in struct net_device_stats.
	Now, I have an idea on my mind about how to do this:

I'd move the structure to a new file in linux/include/asm 
(linux/include/asm-{arch}/netdevice.h, for example) and implement there 
couple of functions that would change the counters in the structure 
(something like: static inline void net_stats_txbytes_add(struct 
net_device_stats* stats, unsigned long len)). These would lock (if necessary 
- - 32-bit architectures), add, unlock (if necessary.) The only thing is, that 
all the NIC drivers in the kernel up to date would have to be changed to use 
this new interface.

	Now, my question: Is there a better way of accomplishing this?

Thanks,
Jeff.

- -- 
A CRAY is the only computer that runs an endless loop in just 4 hours...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7R3XwFP0+seVj/4RAolgAJ9QE4eLfKqrVhR9tktoZCHjcfarfgCcDb1A
HELhBfYleUbTSaTymmTsRJM=
=xu4t
-----END PGP SIGNATURE-----

