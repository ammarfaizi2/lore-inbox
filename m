Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265032AbSKAOf1>; Fri, 1 Nov 2002 09:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbSKAOf1>; Fri, 1 Nov 2002 09:35:27 -0500
Received: from nammta01.sugar-land.nam.slb.com ([163.188.150.130]:34269 "EHLO
	mail.slb.com") by vger.kernel.org with ESMTP id <S265032AbSKAOfZ>;
	Fri, 1 Nov 2002 09:35:25 -0500
Date: Fri, 01 Nov 2002 14:34:40 +0000
From: Loic Jaquemet <ljaquemet@gatwick.westerngeco.slb.com>
Subject: Re: Patch?: linux-2.5.45/net/ipv4/netfilter dst.pmtu compilation fixes
To: netfilter-devel@lists.netfilter.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3DC29100.FDA579A5@gatwick.westerngeco.slb.com>
Organization: WesternGeco
MIME-version: 1.0
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-21smp i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


also see
http://marc.theaimsgroup.com/?l=linux-kernel&m=103614599321384&w=1

linux-2.5.45 appears to have replaced dst_entry.pmtu with
dst_entry.metrics[RTAX_PMTU] and created a helper function
dst_pmtu(struct dst_entry*), presumably to simplify future changes
like this one.   Now the
files compile.  That is as much as I have tested.

 I am not currently familiar with this code, so I could easily
have misunderstood something in this patch.


--- linux-2.5.45.orig/net/ipv4/netfilter/ipt_TCPMSS.c   2002-10-31
01:42:56.000000000 +0100
+++ linux-2.5.45/net/ipv4/netfilter/ipt_TCPMSS.c        2002-11-01
15:18:12.000000000 +0100
@@ -85,14 +85,14 @@
                        return NF_DROP; /* or IPT_CONTINUE ?? */
                }

-               if((*pskb)->dst->pmtu <= (sizeof(struct iphdr) +
sizeof(struct tcphdr))) {
+               if( dst_pmtu( (*pskb)->dst ) <= (sizeof(struct iphdr) +
sizeof(struct tcphdr))) {
                        if (net_ratelimit())
                                printk(KERN_ERR
-                                       "ipt_tcpmss_target: unknown or
invalid path-MTU (%d)\n", (*pskb)->dst->pmtu);
+                                       "ipt_tcpmss_target: unknown or
invalid path-MTU (%d)\n", dst_pmtu( (*pskb)->dst ) );
                        return NF_DROP; /* or IPT_CONTINUE ?? */
                }

-               newmss = (*pskb)->dst->pmtu - sizeof(struct iphdr) -
sizeof(struct tcphdr);
+               newmss = dst_pmtu( (*pskb)->dst ) - sizeof(struct iphdr)
- sizeof(struct tcphdr);
        } else
                newmss = tcpmssinfo->mss;



--
+----------------------------------------------+
|Jaquemet Loic                                 |
|Intern in WesternGeco, Schlumberger in Gatwick|
|Phone: 44-(0)1293-55-6876                     |
|Eleve ingenieur en informatique FIIFO, ORSAY  |
+----------------------------------------------+
http://sourceforge.net/projects/ffss/
#wirelessfr @ irc.freenode.net



