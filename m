Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTH1Oz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 10:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTH1Oz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 10:55:29 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:10379
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S264022AbTH1OzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 10:55:19 -0400
Message-ID: <3F4E1823.7060600@trash.net>
Date: Thu, 28 Aug 2003 16:56:35 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Lambrechts <hans.lambrechts@skynet.be>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Linux 2.4.23-pre1
References: <pcKD.6BP.19@gated-at.bofh.it> <200308280850.h7S8oxGx001862@pc.skynet.be>
In-Reply-To: <200308280850.h7S8oxGx001862@pc.skynet.be>
Content-Type: multipart/mixed;
 boundary="------------010606010609010307090100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010606010609010307090100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Please try this patch.

Regards,
Patrick

Hans Lambrechts wrote:

>Greetings,
>
>  
>
>>Harald Welte:
>>  o [NETFILTER]: Backport iptables AH/ESP fixes from 2.6.x
>>  o [NETFILTER]: Fix uninitialized return in iptables tftp
>>  o [NETFILTER]: NAT optimization
>>  o [NETFILTER]: Conntrack optimization (LIST_DELETE)
>>
>>    
>>
>
>
>I see this in my log:
>
>Aug 28 10:45:44 pc kernel: MASQUERADE: No route: Rusty's brain broke!
>Aug 28 10:46:10 pc last message repeated 13 times
>Aug 28 10:48:42 pc kernel: NET: 1 messages suppressed.
>Aug 28 10:48:42 pc kernel: MASQUERADE: No route: Rusty's brain broke!
>Aug 28 10:48:43 pc kernel: MASQUERADE: Route sent us somewhere else.
>
>Forwarding and masquerading doesn't work anymore.
>
>Hans
>  
>

--------------010606010609010307090100
Content-Type: text/plain;
 name="x.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x.diff"

===== net/ipv4/netfilter/ipt_MASQUERADE.c 1.6 vs edited =====
--- 1.6/net/ipv4/netfilter/ipt_MASQUERADE.c	Tue Aug 12 11:30:12 2003
+++ edited/net/ipv4/netfilter/ipt_MASQUERADE.c	Thu Aug 28 16:54:15 2003
@@ -90,6 +90,7 @@
 #ifdef CONFIG_IP_ROUTE_FWMARK
 	key.fwmark = (*pskb)->nfmark;
 #endif
+	key.oif = 0;
 	if (ip_route_output_key(&rt, &key) != 0) {
                 /* Funky routing can do this. */
                 if (net_ratelimit())

--------------010606010609010307090100--

