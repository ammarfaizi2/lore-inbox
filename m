Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286231AbRLJLYf>; Mon, 10 Dec 2001 06:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286229AbRLJLYZ>; Mon, 10 Dec 2001 06:24:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14976 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286231AbRLJLYJ>;
	Mon, 10 Dec 2001 06:24:09 -0500
Date: Mon, 10 Dec 2001 11:14:34 -0800 (PST)
Message-Id: <20011210.111434.41640378.davem@redhat.com>
To: ido@the.linux-dude.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_irc bug?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112101251010.4615-100000@the.linux-dude.net>
In-Reply-To: <Pine.LNX.4.33.0112101251010.4615-100000@the.linux-dude.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ido Diamant <ido@the.linux-dude.net>
   Date: Mon, 10 Dec 2001 12:52:11 +0200 (IST)

    After compiling kernel 2.4.16, I'v seen that I can't dcc chat bots
   running on my local computer. I tried to see why its happening, and
   couldn't get into any reasonable idea.
   Yesterday I remembered that I compiled the 2.4.16 with the ip_nat_irc
   module, and loaded it by default with my firewall. I rmmod ip_nat_irc and
   suddenly I could dcc chat my local bots.
   Q. Why is it happening?
   Q. Am I using this module correctly? as far as I know, I just need to load
   the module, and thats it, am I wrong? should I create some kind of rule
   for it?
   Q. Is it bug?

This patch fixes the bug:

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore ../vanilla/2.4/linux/net/ipv4/netfilter/ip_nat_irc.c linux/net/ipv4/netfilter/ip_nat_irc.c
--- ../vanilla/2.4/linux/net/ipv4/netfilter/ip_nat_irc.c	Tue Oct 30 15:08:12 2001
+++ linux/net/ipv4/netfilter/ip_nat_irc.c	Sat Dec  8 19:23:27 2001
@@ -1,8 +1,8 @@
 /* IRC extension for TCP NAT alteration.
- * (C) 2000 by Harald Welte <laforge@gnumonks.org>
+ * (C) 2000-2001 by Harald Welte <laforge@gnumonks.org>
  * based on a copy of RR's ip_nat_ftp.c
  *
- * ip_nat_irc.c,v 1.15 2001/10/22 10:43:53 laforge Exp
+ * ip_nat_irc.c,v 1.16 2001/12/06 07:42:10 laforge Exp
  *
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
@@ -81,7 +81,7 @@
 	}
 
 	newdstip = master->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip;
-	newsrcip = master->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.ip;
+	newsrcip = ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip;
 	DEBUGP("nat_expected: DCC cmd. %u.%u.%u.%u->%u.%u.%u.%u\n",
 	       NIPQUAD(newsrcip), NIPQUAD(newdstip));
 
