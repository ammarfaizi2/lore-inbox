Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUAaLlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 06:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAaLlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 06:41:07 -0500
Received: from spc1-leed3-6-0-cust58.leed.broadband.ntl.com ([80.7.68.58]:3062
	"EHLO arthur.pjc.net") by vger.kernel.org with ESMTP
	id S264537AbUAaLlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 06:41:03 -0500
Date: Sat, 31 Jan 2004 11:41:01 +0000
From: Patrick Caulfield <pcaulfie@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steve@ChyGwyn.com
Subject: Re: [PATCH] 1/2 DECnet fix SDF_WILD
Message-ID: <20040131114101.GA3224@tykepenguin.com>
References: <20040126113106.GB21366@tykepenguin.com> <20040130124348.40c5c014.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20040130124348.40c5c014.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

On Fri, Jan 30, 2004 at 12:43:48PM -0800, David S. Miller wrote:
> On Mon, 26 Jan 2004 11:31:06 +0000
> Patrick Caulfield <patrick@tykepenguin.com> wrote:
> 
> > This patch fixes the operation of SDF_WILD sockets on Linux 2.6.0/1
> > (they don't currently work at all).
> 
> Please resubmit your patches as attachments or somehow otherwise
> teach your email client not to turn tabs into spaces as this corrupts
> your patches.

Sorry about that. Here are both patches attached (and in -p1 format this time
too)

patrick


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=decnet-patch1

diff -u linux-2.6.1.orig/net/decnet/af_decnet.c linux-2.6.1/net/decnet/af_decnet.c
--- linux-2.6.1.orig/net/decnet/af_decnet.c	2004-01-31 11:33:22.000000000 +0000
+++ linux-2.6.1/net/decnet/af_decnet.c	2004-01-31 11:34:30.000000000 +0000
@@ -163,7 +163,7 @@
 	struct dn_scp *scp = DN_SK(sk);
 
 	if (scp->addr.sdn_flags & SDF_WILD)
-		return hlist_empty(&dn_wild_sk) ? NULL : &dn_wild_sk;
+		return hlist_empty(&dn_wild_sk) ? &dn_wild_sk : NULL;
 
 	return &dn_sk_hash[scp->addrloc & DN_SK_HASH_MASK];
 }

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=decnet-patch2

diff -u linux-2.6.1.orig/net/decnet/dn_route.c linux-2.6.1/net/decnet/dn_route.c
--- linux-2.6.1.orig/net/decnet/dn_route.c	2003-12-18 02:59:42.000000000 +0000
+++ linux-2.6.1/net/decnet/dn_route.c	2004-01-31 11:34:38.000000000 +0000
@@ -1720,7 +1720,8 @@
 
 static void dn_rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
-	rcu_read_unlock();
+	if (v)
+		rcu_read_unlock();
 }
 
 static int dn_rt_cache_seq_show(struct seq_file *seq, void *v)

--PNTmBPCT7hxwcZjr--
