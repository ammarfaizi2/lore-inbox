Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269537AbUICRHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269537AbUICRHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269533AbUICRHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:07:39 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.75]:17186 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S269537AbUICRHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:07:06 -0400
Date: Fri, 03 Sep 2004 13:06:55 -0400
From: josef Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH/RFC 2.6] NET: 64-bit network statistics
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Message-id: <200409031307.01240.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've created a patch that monitors changes to the network statistics variables 
and keeps internal 64-bit counter. I decided to split it into two parts 
(patches are to follow in next emails):
 1) generic variable monitoring system (watch64)

The watch64 system allows the programmer to specify the approximate interval 
at which he wants his variables checked. If he tries to specify shorter 
interval than the minimum a default value of HZ/10 is used. To minimize 
locking, RCU and seqlock are used. On 64-bit systems, all is optimized away. 

 2) network statistics specific patch (64network)

Upon registration of a network device, all the statistics variables are 
registered with watch64. Additionally, a new proc file is 
created /proc/net/dev64 displays the 64-bit values as supposed 
to /proc/net/dev which is left to display the original 32-bit variables for 
backward compatibility. The sysfs interface 
(/sys/class/net/<interface>/statistics/*) displays the 64-bit values only. On 
64-bit systems, all is optimized away through watch64.

Josef "Jeff" Sipek.

- -- 
*NOTE: This message is ROT-13 encrypted twice for extra protection*
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBOKSzwFP0+seVj/4RAkz7AJ0Ut21nPMkHGKv1dXK17yoA5hQ1+ACglpMq
IHh+tYW3innmwjlA7EU2x78=
=LnHg
-----END PGP SIGNATURE-----
