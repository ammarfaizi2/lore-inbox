Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTGBUbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTGBUbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:31:45 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.23]:14649 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264328AbTGBUbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:31:44 -0400
Date: Wed, 02 Jul 2003 16:45:44 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: 64-bit network statistics (struct net_device_stats)
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>
Message-id: <200307021646.03601.jeffpc@optonline.net>
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

Hello everyone,
	I've been hacking for some time on those 64-bit statistics and I got to this 
question:

Does it make sense to make a new API layer to prevent network drivers from 
accessing struct net_device_stats directly? Yes, I know someone (we - I?) 
would have to check all the network drivers and change them accordingly.

My idea would be something like this:

	net_stats_add(<original field name>,<pointer to struct>,<number to be added>)	
	net_stats_inc(<original field name>,<pointer to struct>)	
	net_stats_set(<original field name>,<pointer to struct>,<number to set to>)	
	net_stats_get(<original field name>,<pointer to struct>)	

The point is that this new layer would enable us (me) to make changes to the 
type of the fields in the struct (with minimal breakage).

(I actually have done this [64-bit stats] - it appears to work ok, I'll hack 
on a bit more, and release it to the masses.)

Any thoughts?

Jeff.

- -- 
bad pun of the week: the formula 1 control computer suffered from a race 
condition
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/A0R/wFP0+seVj/4RAnqrAKCaNUwBGqgPHj1+Scq6C91bxo6nMACgle6h
vm1MXVm2c4Mr9zI+LuH43OM=
=uPyq
-----END PGP SIGNATURE-----

