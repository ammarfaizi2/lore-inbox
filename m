Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWEBOhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWEBOhT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWEBOhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:37:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10923 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964846AbWEBOhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:37:17 -0400
Date: Tue, 2 May 2006 16:42:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [netfilter-core] Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup in	sctp_new(), do_basic_checks()
Message-ID: <20060502144200.GA4233@elte.hu>
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu> <4457648C.6020100@trash.net> <20060502140102.GA31743@elte.hu> <4457654A.9040200@trash.net> <20060502141621.GA32284@elte.hu> <44576CD5.60603@trash.net> <20060502143814.GA3789@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502143814.GA3789@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > How about this patch (based on your patch, but typos fixed and also 
> > covers nf_conntrack)?
> 
> sure, fine with me!

find updated patch below - quilt complained about 3 cases of 
whitespace-at-end-of-line. (btw., this file at quite a distance from 
proper Documentation/CodingStyle.)

	Ingo

Index: linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
+++ linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
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
Index: linux/net/netfilter/nf_conntrack_proto_sctp.c
===================================================================
--- linux.orig/net/netfilter/nf_conntrack_proto_sctp.c
+++ linux/net/netfilter/nf_conntrack_proto_sctp.c
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
