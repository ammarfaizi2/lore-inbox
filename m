Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLAVST>; Fri, 1 Dec 2000 16:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129449AbQLAVSK>; Fri, 1 Dec 2000 16:18:10 -0500
Received: from ja.ssi.bg ([193.68.177.189]:8964 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129383AbQLAVSB>;
	Fri, 1 Dec 2000 16:18:01 -0500
Date: Fri, 1 Dec 2000 22:45:34 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Ben McCann <bmccann@indusriver.com>
cc: Mike Perry <mikepery@fscked.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.17 IP masq bug
In-Reply-To: <3A277808.153AFC0C@indusriver.com>
Message-ID: <Pine.LNX.4.21.0012012230480.904-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Fri, 1 Dec 2000, Ben McCann wrote:

> I'm curious about how ICMP redirect is causing this problem.
> Would you elaborate on how ICMP is involved?

	The masq box sends ICMP redirects to the internal host
when the destination host is on the same shared media, i.e.
"please, go directly to the destination". When the internal host
accepts these redirects it reroutes the packets directly to the
destination which is on the same LAN. The packets reach the destination
with saddr=10/8 because they are not masqueraded. It seems the
destination does not use direct route to 10/8 and the traffic
is not replied. The connection is not established when it is not
masqueraded. When we block these redirects the internal hosts
continue to forward the packets to the masq box without knowing
the destination is directly connected.

> -Ben McCann

Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
