Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUK7Y>; Wed, 21 Feb 2001 05:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBUK7P>; Wed, 21 Feb 2001 05:59:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49281 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129051AbRBUK66>;
	Wed, 21 Feb 2001 05:58:58 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14995.40701.818777.181432@pizda.ninka.net>
Date: Wed, 21 Feb 2001 02:57:01 -0800 (PST)
To: ookhoi@dds.nl
Cc: Vibol Hou <vibol@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>,
        sim@stormix.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues (3c905B))
In-Reply-To: <20010221104723.C1714@humilis>
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc>
	<20010221104723.C1714@humilis>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ookhoi writes:
 > We have exactly the same problem but in our case it depends on the
 > following three conditions: 1, kernel 2.4 (2.2 is fine), 2, windows ip
 > header compression turned on, 3, a free internet access provider in
 > Holland called 'Wish' (which seemes to stand for 'I Wish I had a faster
 > connection').
 > If we remove one of the three conditions, the connection is oke. It is
 > only tcp which is affected.
 > A packet on its way from linux server to windows client seems to get
 > dropped once and retransmitted. This makes the connection _very_ slow.

:-( I hate these buggy systems.

Does this patch below fix the performance problem and are the windows
clients win2000 or win95?

--- include/net/ip.h.~1~	Mon Feb 19 00:12:31 2001
+++ include/net/ip.h	Wed Feb 21 02:56:15 2001
@@ -190,9 +190,11 @@
 
 static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst)
 {
+#if 0
 	if (iph->frag_off&__constant_htons(IP_DF))
 		iph->id = 0;
 	else
+#endif
 		__ip_select_ident(iph, dst);
 }
 
