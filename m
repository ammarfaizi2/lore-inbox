Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272423AbTHIPMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272427AbTHIPMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:12:50 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:16484 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272423AbTHIPMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:12:48 -0400
Date: Sat, 9 Aug 2003 16:12:18 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6test /proc/net/pnp oops.
Message-ID: <20030809151218.GA563@suse.de>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030809011901.GA16007@suse.de> <20030808184950.3b2bd6e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20030808184950.3b2bd6e2.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, that patch stopped the random addresses appearing
in /proc/net/pnp. There are also a bunch of other vars
we output in that file also marked as initdata which
look like they need fixing for the same reason.

The only remaining curious item for me..
With this fixed, the bootserver is 0.0.0.0, and there's
a check which skips printing it if its INADDR_NONE

There are similar checks for the nameserver entries, but
they still get printed out (as 0.0.0.0)

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ipconfig.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1064  -> 1.1065 
#	 net/ipv4/ipconfig.c	1.28    -> 1.29   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/09	davej@redhat.com	1.1065
# mustnt be __initdata
# --------------------------------------------
#
diff -Nru a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
--- a/net/ipv4/ipconfig.c	Sat Aug  9 16:11:51 2003
+++ b/net/ipv4/ipconfig.c	Sat Aug  9 16:11:51 2003
@@ -125,14 +125,14 @@
 
 int ic_host_name_set __initdata = 0;		/* Host name set by us? */
 
-u32 ic_myaddr __initdata = INADDR_NONE;		/* My IP address */
-u32 ic_netmask __initdata = INADDR_NONE;	/* Netmask for local subnet */
-u32 ic_gateway __initdata = INADDR_NONE;	/* Gateway IP address */
+u32 ic_myaddr = INADDR_NONE;		/* My IP address */
+u32 ic_netmask = INADDR_NONE;	/* Netmask for local subnet */
+u32 ic_gateway = INADDR_NONE;	/* Gateway IP address */
 
-u32 ic_servaddr __initdata = INADDR_NONE;	/* Boot server IP address */
+u32 ic_servaddr = INADDR_NONE;	/* Boot server IP address */
 
-u32 root_server_addr __initdata = INADDR_NONE;	/* Address of NFS server */
-u8 root_server_path[256] __initdata = { 0, };	/* Path to mount as root */
+u32 root_server_addr = INADDR_NONE;	/* Address of NFS server */
+u8 root_server_path[256] = { 0, };	/* Path to mount as root */
 
 /* Persistent data: */
 

--HlL+5n6rz5pIUxbD--
