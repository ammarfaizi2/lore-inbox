Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTJTJX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTJTJX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:23:26 -0400
Received: from web11103.mail.yahoo.com ([216.136.131.150]:43656 "HELO
	web11103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262456AbTJTJXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:23:24 -0400
Message-ID: <20031020092323.82601.qmail@web11103.mail.yahoo.com>
Date: Mon, 20 Oct 2003 11:23:23 +0200 (CEST)
From: =?iso-8859-1?q?an7?= <an3h0ny@yahoo.fr>
Subject: Network implementation
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, i am a french engineer who has some work to do on
TCP/IP implementation in the linux kernel.

I have three questions on it :

1) What are the advantages of using a ring buffer for
receiving and queuing packets ?

2) in tcp_minisocks.c in linux i get, in the function
which handles segment arrival in FIN_WAIT_2 state : 

if (th->syn && !before(TCP_SKB_CB(skb)->seq,
tw->rcv_nxt))
                         goto kill_with_rst;

Just to confirm : in the state FIN_WAIT_2 a SYN
segment is automatically killed by a RST, unless its
sequence number is superior to the waited sequence
number. But in this case , what happens ? I think the
RFC tells to send a ACK. Am i right ?

3) the function tcp_recv_skb() (tcp.c)

struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq,
u32 *off)
1383 {
1384         struct sk_buff *skb;
1385         u32 offset;
1386 
1387         skb_queue_walk(&sk->receive_queue, skb) {
1388                 offset = seq -
TCP_SKB_CB(skb)->seq;
1389                 if (skb->h.th->syn)
1390                         offset--;
1391                 if (offset < skb->len ||
skb->h.th->fin) {
1392                         *off = offset;
1393                         return skb;
1394                 }
1395         }
1396         return NULL;
1397 }

 
I just can't understand the role of offset (and thus,
i can't undersand why it is decremented with a syn
segment, and why we can return the skb structure when
we have an offset inferior to the skb len, or a FIN
segment)

Could you help please ?

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
