Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTEGGr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTEGGr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:47:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61933 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262930AbTEGGrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:47:22 -0400
Date: Tue, 06 May 2003 22:52:23 -0700 (PDT)
Message-Id: <20030506.225223.116372228.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
Subject: Re: [2.5.69-mm1] kernel BUG at include/linux/module.h:284! 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507035148.31D332C117@lists.samba.org>
References: <1052227331.983.46.camel@rth.ninka.net>
	<20030507035148.31D332C117@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 07 May 2003 13:48:15 +1000

   In message <1052227331.983.46.camel@rth.ninka.net> you write:
   > Arnaldo, ipv6 creates a socket of it's own type during
   > module init, try_module_get() on the current module fails
   > during module load... do you see the problem?
   > 
   > Rusty, you said you were working on a solution for modules
   > that call themselves during their own init?
   
   In fact, it's backwards.

You're, of course, right.  I misread the bug report, and this
patch below ought to fix it.  It's untested, but I'll do that in
a bit and push upstream.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1083  -> 1.1084 
#	  net/ipv4/af_inet.c	1.44    -> 1.45   
#	 net/ipv6/af_inet6.c	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/06	davem@nuts.ninka.net	1.1084
# [IPV4/IPV6]: Set owner field in family ops.
# --------------------------------------------
#
diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Tue May  6 23:58:43 2003
+++ b/net/ipv4/af_inet.c	Tue May  6 23:58:43 2003
@@ -926,6 +926,7 @@
 struct net_proto_family inet_family_ops = {
 	.family = PF_INET,
 	.create = inet_create,
+	.owner	= THIS_MODULE,
 };
 
 
diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Tue May  6 23:58:43 2003
+++ b/net/ipv6/af_inet6.c	Tue May  6 23:58:43 2003
@@ -535,6 +535,7 @@
 struct net_proto_family inet6_family_ops = {
 	.family = PF_INET6,
 	.create = inet6_create,
+	.owner	= THIS_MODULE,
 };
 
 #ifdef MODULE
