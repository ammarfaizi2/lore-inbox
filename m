Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTH1QBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTH1QBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:01:00 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:37771
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S264099AbTH1QAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:00:52 -0400
Message-ID: <3F4E2772.8050104@trash.net>
Date: Thu, 28 Aug 2003 18:01:54 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       "David S. Miller" <davem@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-bk2 and 2.4.23-pre1 broke routing
References: <Pine.LNX.4.55L.0308281134120.9167@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0308281134120.9167@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------070104040709070809070004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070104040709070809070004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It's fixed by this patch. (tested by Hans Lambrechts).

Best regards,
Patrick

Marcelo Tosatti wrote:

>David?
>
>
>---------------------------
>
>I'm running 2.4.22 now and have a NAT behind my firewall as well as IPv6
>happily run through unixcore.com.  I upgraded to 2.4.22-bk2 last night
>to fix an odd problem where I can't ssh-6 to one host.  All of a sudden
>it all works within the nat but nothing behind the firewall can get out
>from behind to the real work though the firewall still can.  Recompiled
>trying 2.4.23-pre1 and I get the exact same behavior.  All 3 use the
>same .config file.
>
>The only noticable change I can see is a bunch of messages:
>
>Aug 27 22:09:10 wally kernel: MASQUERADE: No route: Rusty's brain broke!
>Aug 27 22:09:16 wally kernel: MASQUERADE: No route: Rusty's brain broke!
>Aug 27 22:09:16 wally kernel: MASQUERADE: No route: Rusty's brain broke!
>
>  
>

--------------070104040709070809070004
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

--------------070104040709070809070004--

