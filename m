Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289527AbSAJQXR>; Thu, 10 Jan 2002 11:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289528AbSAJQXJ>; Thu, 10 Jan 2002 11:23:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2688 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289527AbSAJQWx>;
	Thu, 10 Jan 2002 11:22:53 -0500
Date: Thu, 10 Jan 2002 08:21:41 -0800 (PST)
Message-Id: <20020110.082141.74749837.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] s/TCP_ESTABLISHED/PROTO_ESTABLISHED/g
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020110161629.GF1010@conectiva.com.br>
In-Reply-To: <20020110161629.GF1010@conectiva.com.br>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Thu, 10 Jan 2002 14:16:29 -0200

   	Part of the sock cleanup made me remove the #include <linux/tcp.h> from
   include/linux/ip.h and from include/net/sock.h, i.e., it is not needed in
   those headers, but then I had to go to udp.c, ipx.c, decnet, etc, and add a
   #include <linux/tcp.h> because it needs TCP_ESTABLISHED, TCP_CLOSE, etc,
   this is a pet peeve to me, as a janitor :-) Can I change this to
   PROTO_ESTABLISHED, PROTO_CLOSE, etc, and have it on a different header, say
   include/net/protocol.h?  Its strange to have IPX, DecNET, etc having to
   include net/tcp.h (that in turn includes ip.h, etc).
   
   	If this is ok I can bundle it in the sock cleanup or send it
   separately, your call.

These other protocols are just borrowing state machine states from
TCP.  I really see no reason to rename them, because then if you did
the TCP usage wouldn't make look right anymore. :-)

I don't mind moving the header include from sock.h to the protocols
though.

Franks a lot,
David S. Miller
davem@redhat.com
