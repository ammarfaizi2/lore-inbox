Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUTKk>; Wed, 21 Feb 2001 14:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129249AbRBUTKb>; Wed, 21 Feb 2001 14:10:31 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:37384 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129181AbRBUTKT>; Wed, 21 Feb 2001 14:10:19 -0500
From: "Vibol Hou" <vibol@khmer.cc>
To: "David S. Miller" <davem@redhat.com>, <ookhoi@dds.nl>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>, <sim@stormix.com>
Subject: RE: 2.4 tcp very slow under certain circumstances (Re: netdev issues (3c905B))
Date: Wed, 21 Feb 2001 11:06:49 -0800
Message-ID: <HDEBKHLDKIDOBMHPKDDKOEKMEFAA.vibol@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <14995.40701.818777.181432@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Win2K here, I'll apply the patch and let you know what happens.

-Vibol

-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com]
Sent: Wednesday, February 21, 2001 2:57 AM
To: ookhoi@dds.nl
Cc: Vibol Hou; Linux-Kernel; sim@stormix.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev
issues (3c905B))



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

 static inline void ip_select_ident(struct iphdr *iph, struct dst_entry
*dst)
 {
+#if 0
 	if (iph->frag_off&__constant_htons(IP_DF))
 		iph->id = 0;
 	else
+#endif
 		__ip_select_ident(iph, dst);
 }



