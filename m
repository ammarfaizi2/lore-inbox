Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbSJNJsT>; Mon, 14 Oct 2002 05:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264164AbSJNJsT>; Mon, 14 Oct 2002 05:48:19 -0400
Received: from internet.prism.co.za ([196.41.175.253]:41093 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id <S264146AbSJNJsS>; Mon, 14 Oct 2002 05:48:18 -0400
Date: Mon, 14 Oct 2002 11:53:42 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: linux-kernel@vger.kernel.org
Subject: What is "recvmsg bug: copied 870A11AD seq 0"?  (2.2.19)
Message-ID: <20021014115341.A22933@prism.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

What does it mean if the last 9 items in dmesg from a 2.2.19 kernel say
"recvmsg bug: copied 870A11AD seq 0"?  Same sequence number each time.

A kernel (known) bug?  Some bogus TCP segments?

Somehow this has something (dunno how much) to do with INN and pullnews.
This morning I had 43 inews's stuck in tcp_recvmsg at the schedule() just
before found_ok_skb and news.daily was stuck.  telnet to localhost port 119
didn't produce the banner as it normally does.

Weird thing too is that inews would have been connected to 127.0.0.1, out
of harm's way.

Unfortunately I very much doubt I can reproduce this - it's the first time
I've seen it (INN has been running since last year, but not continuously).

linux/net/ipv4/tcp.c <tcp_recvmsg>:
	skb = skb_peek(&sk->receive_queue);
	do {
		if (!skb)
			break;

		/* Now that we have two receive queues this 
		 * shouldn't happen.
		 */
		if (before(*seq, TCP_SKB_CB(skb)->seq)) {
			printk(KERN_INFO "recvmsg bug: copied %X seq %X\n",
			       *seq, TCP_SKB_CB(skb)->seq);
			break;
		}

[I'd greatly appreciate Cc'ed replies.]

-- 
berndfoobar@users.sourceforge.net is probably better to bookmark than any
employer-specific email address I may have appearing in the headers.
  Vanity page: http://www.tsct.co.za/~berndj/  Hmm, appears to be down.
