Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275312AbTHMSN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275313AbTHMSNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:13:55 -0400
Received: from webmail25.rediffmail.com ([203.199.83.147]:5287 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id S275312AbTHMSNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:13:51 -0400
Date: 13 Aug 2003 18:12:51 -0000
Message-ID: <20030813181251.10860.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
From: "Steven  Mickovski" <knet31@rediffmail.com>
Reply-To: "Steven  Mickovski" <knet31@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Questions on tcp_send
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i have some problems understanding the tcp_send routine in 
net/ipv4/tcp.c:

1)
  if (skb_tailroom(skb) > 0) {
                                 /* We have some space in skb 
head.
 				Superb! */
                                 ...
 				...
                         } else {
                                 int merge = 0;
                                 int i = 
skb_shinfo(skb)->nr_frags;
                                 struct page *page = 
TCP_PAGE(sk);
                                 int off = TCP_OFF(sk);
 				if (can_coalesce(skb, i, page, off) && off != PAGE_SIZE) 
{merge=1;}

My understanding of the skb_tailroom condition is that it's for 
the
case when the previous sk_buff can accomodate the new buffer to 
be
sent, and it checks if this can be done in the space allocated to 
it,
or if it should stuff it into the page where the space is 
allocated.

Is this correct?

2) If so, then why does "can_coalesce" check if:
   (page == frag->page && off == frag->page_offset+frag->size)
    to decide if the data can be merged with that in the 
previous
     sk_buff?

Thanks in advance! Help appreciated...

Steve
___________________________________________________
Meet your old school or college friends from
1 Million + database...
Click here to reunite www.batchmates.com/rediff.asp


