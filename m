Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSFKTPn>; Tue, 11 Jun 2002 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSFKTPm>; Tue, 11 Jun 2002 15:15:42 -0400
Received: from imr2.ericy.com ([198.24.6.3]:3969 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id <S317515AbSFKTPl>;
	Tue, 11 Jun 2002 15:15:41 -0400
Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8303A070D4@eammlnt051.lmc.ericsson.se>
From: "Philippe Veillette (LMC)" <Philippe.Veillette@ericsson.ca>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-net@vger.kernel.org'" <linux-net@vger.kernel.org>
Subject: sk->socket is invalid in tcp stack
Date: Tue, 11 Jun 2002 15:15:31 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody

I've found what could be a problem in the tcp stack with linux-2.4.17 &
2.4.18.  When i run lmbench-2.0-patch2 and that i add the following line of
code in tcp_v4_rcv, it<s get added between the if (!ipsec_sk_policy(sk,skb))
... and if (sk->state == TCP_TIME_WAIT)

if (sk->socket) {	
	if (sk->socket->inode) {
		printk("Boum\n");
	}
}

I get a crash, i can give the dump later but for now, I am just wondering if
the sk->socket could be invalid when we are receiving a tcp packet.  Since
from the search i've done it seems to be initialized only when the sock
struct is initialized in sock_init_data that get called by inet_create.

But what is more frightening, is that it's alright for sometime and then
Boum, crash....

Bye

Philippe Veillette

