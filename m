Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289000AbSAUByW>; Sun, 20 Jan 2002 20:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSAUByL>; Sun, 20 Jan 2002 20:54:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289000AbSAUBxy> convert rfc822-to-8bit;
	Sun, 20 Jan 2002 20:53:54 -0500
Date: Sun, 20 Jan 2002 17:52:04 -0800 (PST)
Message-Id: <20020120.175204.18636524.davem@redhat.com>
To: martin.macok@underground.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: [andrewg@tasmail.com: remote memory reading through tcp/icmp]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020121015209.A26413@sarah.kolej.mff.cuni.cz>
In-Reply-To: <20020121015209.A26413@sarah.kolej.mff.cuni.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Martin Maèok <martin.macok@underground.cz>
   Date: Mon, 21 Jan 2002 01:52:09 +0100

   Any comments on this?
   
Pretty simple to fix, from Andi Kleen:

--- linux-work/net/ipv4/icmp.c-o	Tue Jan 15 11:05:17 2002
+++ linux-work/net/ipv4/icmp.c	Sun Jan 20 23:31:29 2002
@@ -495,7 +495,7 @@
 	icmp_param.data.icmph.checksum=0;
 	icmp_param.csum=0;
 	icmp_param.skb=skb_in;
-	icmp_param.offset=skb_in->nh.raw - skb_in->data;
+	icmp_param.offset=skb_in->data - skb_in->nh.raw;
 	icmp_out_count(icmp_param.data.icmph.type);
 	icmp_socket->sk->protinfo.af_inet.tos = tos;
 	ipc.addr = iph->saddr;
--- linux-work/net/ipv6/icmp.c-o	Thu Sep 20 23:12:56 2001
+++ linux-work/net/ipv6/icmp.c	Sun Jan 20 23:40:03 2002
@@ -361,7 +361,7 @@
 	msg.icmph.icmp6_pointer = htonl(info);
 
 	msg.skb = skb;
-	msg.offset = skb->nh.raw - skb->data;
+	msg.offset = skb->data - skb->nh.raw; 
 	msg.csum = 0;
 	msg.daddr = &hdr->saddr;
