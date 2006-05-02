Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWEBWbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWEBWbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWEBWbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:31:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:31173 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965027AbWEBWbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:31:49 -0400
Date: Tue, 2 May 2006 15:30:12 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.13
Message-ID: <20060502223012.GB29287@kroah.com>
References: <20060502222827.GA29287@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502222827.GA29287@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 2f8e9d8..d4cc824 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .12
+EXTRAVERSION = .13
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
index be602e8..df67679 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
@@ -235,12 +235,15 @@ static int do_basic_checks(struct ip_con
 			flag = 1;
 		}
 
-		/* Cookie Ack/Echo chunks not the first OR 
-		   Init / Init Ack / Shutdown compl chunks not the only chunks */
-		if ((sch->type == SCTP_CID_COOKIE_ACK 
+		/*
+		 * Cookie Ack/Echo chunks not the first OR
+		 * Init / Init Ack / Shutdown compl chunks not the only chunks
+		 * OR zero-length.
+		 */
+		if (((sch->type == SCTP_CID_COOKIE_ACK
 			|| sch->type == SCTP_CID_COOKIE_ECHO
 			|| flag)
-		     && count !=0 ) {
+		      && count !=0) || !sch->length) {
 			DEBUGP("Basic checks failed\n");
 			return 1;
 		}
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index cf798e6..cd2326d 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -240,12 +240,15 @@ static int do_basic_checks(struct nf_con
 			flag = 1;
 		}
 
-		/* Cookie Ack/Echo chunks not the first OR 
-		   Init / Init Ack / Shutdown compl chunks not the only chunks */
-		if ((sch->type == SCTP_CID_COOKIE_ACK 
+		/*
+		 * Cookie Ack/Echo chunks not the first OR
+		 * Init / Init Ack / Shutdown compl chunks not the only chunks
+		 * OR zero-length.
+		 */
+		if (((sch->type == SCTP_CID_COOKIE_ACK
 			|| sch->type == SCTP_CID_COOKIE_ECHO
 			|| flag)
-		     && count !=0 ) {
+		      && count !=0) || !sch->length) {
 			DEBUGP("Basic checks failed\n");
 			return 1;
 		}
