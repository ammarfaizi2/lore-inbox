Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUITWcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUITWcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUITWcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:32:12 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:53168 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263806AbUITWcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:32:07 -0400
Subject: [PATCH] Another ip_conntrack seq fix: ip_conntrack_expect
From: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: netfilter-devel@lists.netfilter.org,
       "David S. Miller" <davem@davemloft.net>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1095719191.1940.86.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 08:26:31 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Fix /proc/net/ip_conntrack_expect output
Status: Tested under nfsum on 2.6.9-rc1-bk16
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Depends: Netfilter/conntrack-seq-fix.patch.gz

/proc/net/ip_conntrack_expect was changed over to seq_file, but a \n
is missing.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19747-linux-2.6.9-rc2-bk4/net/ipv4/netfilter/ip_conntrack_standalone.c .19747-linux-2.6.9-rc2-bk4.updated/net/ipv4/netfilter/ip_conntrack_standalone.c
--- .19747-linux-2.6.9-rc2-bk4/net/ipv4/netfilter/ip_conntrack_standalone.c	2004-09-16 00:17:16.000000000 +1000
+++ .19747-linux-2.6.9-rc2-bk4.updated/net/ipv4/netfilter/ip_conntrack_standalone.c	2004-09-20 06:03:50.000000000 +1000
@@ -241,8 +241,9 @@ static int exp_seq_show(struct seq_file 
 	seq_printf(s, "use=%u proto=%u ", atomic_read(&expect->use),
 		   expect->tuple.dst.protonum);
 
-	return print_tuple(s, &expect->tuple,
-			   __ip_ct_find_proto(expect->tuple.dst.protonum));
+	print_tuple(s, &expect->tuple,
+		    __ip_ct_find_proto(expect->tuple.dst.protonum));
+	return seq_putc(s, '\n');
 }
 
 static struct seq_operations exp_seq_ops = {


