Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWEaO5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWEaO5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWEaO5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:57:33 -0400
Received: from stinky.trash.net ([213.144.137.162]:12258 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S965051AbWEaO5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:57:32 -0400
Message-ID: <447DAEC9.3050003@trash.net>
Date: Wed, 31 May 2006 16:57:13 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
Subject: Re: 2.6.17-rc4: netfilter LOG messages truncated via NETCONSOLE
References: <20060531094626.GA23156@janus>
In-Reply-To: <20060531094626.GA23156@janus>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------080405030508060800050202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080405030508060800050202
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Frank van Maarseveen wrote:
> I have two machines named "porvoo" and "espoo". The first one
> has netconsole configured to send kernel messages to UDP port 514
> (a.k.a. syslog) on the other machine.
> 
> Somewhere between 2.6.13.2 and 2.6.17-rc4 there is a regression causing
> the netconsole messages which originate from netfilter to be truncated
> right after the MAC addresses. For example, /var/log/messages on the
> sending machine says:
> 
> May 31 09:28:11 porvoo kernel: IN=eth0 OUT= MAC=00:12:3f:85:9f:92:00:04:9a:a0:1d:d1:08:00 SRC=192.168.100.30 DST=172.17.1.113 LEN=60 TOS=0x00 PREC=0x00 TTL=54 ID=51496 DF PROTO=TCP SPT=50868 DPT=22 WINDOW=5840 RES=0x00 SYN URGP=0 
> 
> but netconsole messages captured in /var/log/messages on the receiving
> machine:
> 
> May 31 09:28:11 porvoo IN=eth0 OUT= 
> May 31 09:28:11 porvoo MAC=
> May 31 09:28:11 porvoo 00:
> May 31 09:28:11 porvoo 12:
> May 31 09:28:11 porvoo 3f:
> May 31 09:28:11 porvoo 85:
> May 31 09:28:11 porvoo 9f:
> May 31 09:28:11 porvoo 92:
> May 31 09:28:11 porvoo 00:
> May 31 09:28:11 porvoo 04:
> May 31 09:28:11 porvoo 9a:
> May 31 09:28:11 porvoo a0:
> May 31 09:28:11 porvoo 1d:
> May 31 09:28:11 porvoo d1:
> May 31 09:28:11 porvoo 08:
> May 31 09:28:11 porvoo 00 
> May 31 09:49:06 espoo -- MARK --
> 
> I ran a tcpdump on the sending machine to verify(?) what goes out but in
> that case the 2.6.17-rc4 kernel starts to report "protocol 0000 is buggy":
> 
> May 31 11:00:49 porvoo kernel: device eth0 entered promiscuous mode
> May 31 11:03:31 porvoo kernel: IN=eth0 OUT= MAC=00:12:3f:85:9f:92:00:12:3f:85:17:52:08:00 SRC=172.17.1.64 DST=172.17.1.113 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=60618 DF PROTO=TCP SPT=34984 DPT=21212 WINDOW=5840 RES=0x00 SYN URGP=0
> May 31 11:03:31 porvoo kernel: protocol 0000 is buggy, dev eth0
> May 31 11:03:31 porvoo last message repeated 9 times
> 
> the netconsole output captured on the receiving machine:
> 
> May 31 11:00:49 porvoo device eth0 entered promiscuous mode 
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo IN=eth0 OUT= 
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo MAC=
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo 00:
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo 12:
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo 3f:
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo 85:
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo 9f:
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo 92:
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo 00:
> May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
> May 31 11:03:31 porvoo 12:
> May 31 11:03:31 porvoo 3f:
> May 31 11:03:31 porvoo 85:
> May 31 11:03:31 porvoo 17:
> May 31 11:03:31 porvoo 52:
> May 31 11:03:31 porvoo 08:
> May 31 11:03:31 porvoo 00 
> 
> again 9 packets are missing and there are 9 "protocol 0000 is buggy"
> messages. Netfilter has almost everything configured. IPv6 is left out
> everywhere. Above has been produced using this rule on the netconsole
> sending machine:
> 
> iptables -I INPUT -p tcp -s espoo --dport 21212 -j LOG


The message means that there was recursion and netpoll fell back
to dev_queue_xmit This patch should fix the "protocol is buggy"
messages, netpoll didn't set skb->nh.raw. Please try if it also
makes the other problem go away.

--------------080405030508060800050202
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e8e05ce..7a4787c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -329,7 +329,7 @@ void netpoll_send_udp(struct netpoll *np
 	udph->len = htons(udp_len);
 	udph->check = 0;
 
-	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
+	skb->nh.iph = iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
 
 	/* iph->version = 4; iph->ihl = 5; */
 	put_unaligned(0x45, (unsigned char *)iph);

--------------080405030508060800050202--
