Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288288AbSA1IGK>; Mon, 28 Jan 2002 03:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289139AbSA1IGA>; Mon, 28 Jan 2002 03:06:00 -0500
Received: from [195.66.192.167] ([195.66.192.167]:56075 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288288AbSA1IF4>; Mon, 28 Jan 2002 03:05:56 -0500
Message-Id: <200201280803.g0S83jE21811@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] KERN_INFO: IPv4 IP/TCP hash table size printks
Date: Mon, 28 Jan 2002 10:03:47 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

This patch is for IPv4 IP/TCP hash table size printks
--
vda

diff --recursive -u linux-2.4.13-orig/net/ipv4/route.c linux-2.4.13-new/net/ipv4/route.c
--- linux-2.4.13-orig/net/ipv4/route.c	Wed Oct 17 19:16:39 2001
+++ linux-2.4.13-new/net/ipv4/route.c	Thu Nov  8 23:42:11 2001
@@ -2494,9 +2494,10 @@
 	if (!rt_hash_table)
 		panic("Failed to allocate IP route cache hash table\n");

-	printk("IP: routing cache hash table of %u buckets, %ldKbytes\n",
-	       rt_hash_mask,
-	       (long) (rt_hash_mask * sizeof(struct rt_hash_bucket)) / 1024);
+	printk(KERN_INFO "IP: routing cache hash table of"
+		" %u buckets, %ldKbytes\n",
+		rt_hash_mask,
+		(long) (rt_hash_mask * sizeof(struct rt_hash_bucket)) / 1024);

 	for (rt_hash_log = 0; (1 << rt_hash_log) != rt_hash_mask; rt_hash_log++)
 		/* NOTHING */;
diff --recursive -u linux-2.4.13-orig/net/ipv4/tcp.c linux-2.4.13-new/net/ipv4/tcp.c
--- linux-2.4.13-orig/net/ipv4/tcp.c	Thu Oct 11 04:42:47 2001
+++ linux-2.4.13-new/net/ipv4/tcp.c	Thu Nov  8 23:42:11 2001
@@ -2553,6 +2553,7 @@
 		sysctl_tcp_rmem[2] = 2*43689;
 	}

-	printk("TCP: Hash tables configured (established %d bind %d)\n",
-	       tcp_ehash_size<<1, tcp_bhash_size);
+	printk(KERN_INFO "TCP: hash tables configured"
+		" (established %d bind %d)\n",
+		tcp_ehash_size<<1, tcp_bhash_size);
 }
