Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUEaIrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUEaIrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 04:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUEaIrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 04:47:52 -0400
Received: from h52.dkm.cz ([62.24.73.52]:3975 "EHLO aquarius.doma")
	by vger.kernel.org with ESMTP id S264578AbUEaIru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 04:47:50 -0400
Message-ID: <40BAF132.5010907@ribosome.natur.cuni.cz>
Date: Mon, 31 May 2004 10:47:46 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040311
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: mikpe@csd.uu.se, marcelo.tosatti@cyclades.com, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH][2.4.27-pre4] tcp_input.c compile-time error
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has helped to me to compile teh kernel at least. Thanks.


net/ipv4/tcp_input.c in 2.4.27-pre4 fails to compile:

tcp_input.c: In function `tcp_rcv_space_adjust':
tcp_input.c:479: error: structure has no member named `sk_rcvbuf'
tcp_input.c:480: error: structure has no member named `sk_rcvbuf'
make[3]: *** [tcp_input.o] Error 1

The patch below appears to fix this problem, although some netdev
person should probably check it.

/Mikael

diff -ruN linux-2.4.27-pre4/net/ipv4/tcp_input.c linux-2.4.27-pre4.tcp_input-fix/net/ipv4/tcp_input.c
--- linux-2.4.27-pre4/net/ipv4/tcp_input.c	2004-05-30 23:18:16.000000000 +0200
+++ linux-2.4.27-pre4.tcp_input-fix/net/ipv4/tcp_input.c	2004-05-30 23:45:52.000000000 +0200
@@ -476,8 +476,8 @@
 				  16 + sizeof(struct sk_buff));
 			space *= rcvmem;
 			space = min(space, sysctl_tcp_rmem[2]);
-			if (space > sk->sk_rcvbuf)
-				sk->sk_rcvbuf = space;
+			if (space > sk->rcvbuf)
+				sk->rcvbuf = space;
 		}
 	}
