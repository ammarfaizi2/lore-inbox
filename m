Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSKKFWl>; Mon, 11 Nov 2002 00:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265551AbSKKFWl>; Mon, 11 Nov 2002 00:22:41 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:5831 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP
	id <S265543AbSKKFWk>; Mon, 11 Nov 2002 00:22:40 -0500
Message-ID: <3DCF2332.2050004@terra.com.br>
Date: Mon, 11 Nov 2002 03:25:38 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 ipv4 netfilter compile time error
References: <1036990568.24251.4.camel@flat41>
Content-Type: multipart/mixed;
 boundary="------------000503020203090607090106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503020203090607090106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Grzegorz Jaskiewicz wrote:
> Hello !
> 
> 
> i've discovered this error during compilation:
> 
> net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
> net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
> make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
> make[2]: *** [net/ipv4/netfilter] Error 2
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2

	Try this patch.

Felipe



--------------000503020203090607090106
Content-Type: text/plain;
 name="tcpmss.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcpmss.diff"

--- linux-2.5.47/net/ipv4/netfilter/ipt_TCPMSS.c.orig	Mon Nov 11 03:23:43 2002
+++ linux-2.5.47/net/ipv4/netfilter/ipt_TCPMSS.c	Mon Nov 11 03:23:51 2002
@@ -92,7 +92,7 @@
 			return NF_DROP; /* or IPT_CONTINUE ?? */
 		}
 
-		newmss = dst_pmtu((*pskb)->dst->pmtu) - sizeof(struct iphdr) - sizeof(struct tcphdr);
+		newmss = dst_pmtu((*pskb)->dst) - sizeof(struct iphdr) - sizeof(struct tcphdr);
 	} else
 		newmss = tcpmssinfo->mss;
 

--------------000503020203090607090106--

