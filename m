Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263221AbSJGU6K>; Mon, 7 Oct 2002 16:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263222AbSJGU6K>; Mon, 7 Oct 2002 16:58:10 -0400
Received: from adsl-xs4all.ds9a.nl ([213.84.159.51]:39428 "HELO spaans.ds9a.nl")
	by vger.kernel.org with SMTP id <S263221AbSJGU6I>;
	Mon, 7 Oct 2002 16:58:08 -0400
Date: Mon, 7 Oct 2002 23:03:43 +0200
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix IPv6 [was Re: Linux v2.5.41]
Message-ID: <20021007210343.GA1486@mayo.ds9a.tudelft.nl>
References: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2002 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 12:02:59PM -0700, Linus Torvalds wrote:

>   o [IPV4/IPV6]: General cleanups

Some part of this makes my tree noncompilable:

net/ipv6/addrconf.c: In function `ipv6_addr_type':
net/ipv6/addrconf.c:155: case label does not reduce to an integer constant
net/ipv6/addrconf.c:159: case label does not reduce to an integer constant
etc.

Please apply this (undo-) patch... 

(using gcc 2.95.4 this does compile)

Regards,

Jasper

--- linux-2.5.40/net/ipv6/addrconf.c~	2002-10-07 22:26:37.000000000 +0200
+++ linux-2.5.40/net/ipv6/addrconf.c	2002-10-07 22:27:43.000000000 +0200
@@ -151,16 +151,16 @@
 	if ((st & htonl(0xFF000000)) == htonl(0xFF000000)) {
 		int type = IPV6_ADDR_MULTICAST;
 
-		switch((st & htonl(0x00FF0000))) {
-			case htonl(0x00010000):
+		switch((st & __constant_htonl(0x00FF0000))) {
+			case __constant_htonl(0x00010000):
 				type |= IPV6_ADDR_LOOPBACK;
 				break;
 
-			case htonl(0x00020000):
+			case __constant_htonl(0x00020000):
 				type |= IPV6_ADDR_LINKLOCAL;
 				break;
 
-			case htonl(0x00050000):
+			case __constant_htonl(0x00050000):
 				type |= IPV6_ADDR_SITELOCAL;
 				break;
 		};


-- 
Jasper Spaans
http://jsp.ds9a.nl/contact/
Tel/Fax: +31-84-8749842
``Got no clue? Too bad for you.''
