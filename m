Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293750AbSCKOCD>; Mon, 11 Mar 2002 09:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293751AbSCKOBy>; Mon, 11 Mar 2002 09:01:54 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:50185 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293750AbSCKOBj>; Mon, 11 Mar 2002 09:01:39 -0500
Message-Id: <200203111359.g2BDx1q05409@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
Subject: [PATCH] KERN_INFO 2.4.19-pre2 IP/TCP hash table size printks
Date: Mon, 11 Mar 2002 15:58:15 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
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

diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/net/ipv4/route.c 
linux-new/net/ipv4/route.c
--- linux-2.4.19-pre2/net/ipv4/route.c	Mon Feb 25 17:38:14 2002
+++ linux-new/net/ipv4/route.c	Mon Mar 11 12:26:37 2002
@@ -2487,9 +2487,10 @@
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
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/net/ipv4/tcp.c 
linux-new/net/ipv4/tcp.c
--- linux-2.4.19-pre2/net/ipv4/tcp.c	Fri Dec 21 15:42:05 2001
+++ linux-new/net/ipv4/tcp.c	Mon Mar 11 12:28:10 2002
@@ -2552,8 +2552,9 @@
 		sysctl_tcp_rmem[2] = 2*43689;
 	}

-	printk("TCP: Hash tables configured (established %d bind %d)\n",
-	       tcp_ehash_size<<1, tcp_bhash_size);
+	printk(KERN_INFO "TCP: Hash tables configured"
+		" (established %d bind %d)\n",
+	        tcp_ehash_size<<1, tcp_bhash_size);

 	tcpdiag_init();
 }
