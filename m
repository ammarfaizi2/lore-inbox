Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUDLHYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 03:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUDLHYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 03:24:07 -0400
Received: from [203.197.196.2] ([203.197.196.2]:60091 "EHLO mail2.iitk.ac.in")
	by vger.kernel.org with ESMTP id S261170AbUDLHX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 03:23:59 -0400
Date: Mon, 12 Apr 2004 12:54:17 +0530 (IST)
From: "K.Anantha Kiran" <ananth@cse.iitk.ac.in>
To: linux-kernel@vger.kernel.org
cc: linux-net@vger.kernel.org, <linux-c-programming@vger.kernel.org>
Subject: Can i use dev_queue_xmit()
In-Reply-To: <Pine.LNX.4.44.0404121223250.5450-100000@csews104.cse.iitk.ac.in>
Message-ID: <Pine.LNX.4.44.0404121246040.5450-100000@csews104.cse.iitk.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,
 
 	We are printing the return value of dev_queue_xmit() and we 
 confirm that this will be NET_XMIT_DROP for dropped pkts.
 
 	in *dev_queue_xmit()* function , there is a call to  *enqueue()* 
 which is function pointer pointing to, /net/sched/sch_generic.c 
 pfifo_fast_enqueue() function. In this if the length of queue is greater 
 that the txqueuelen( a parameter of NIC ) then the packet is not queued 
 and DROPPED.
  
 static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc* qdisc)
     {
 	
 		struct sk_buff_head *list;
    
             list = ((struct sk_buff_head*)qdisc->data) +
                    prio2band[skb->priority&TC_PRIO_MAX];
    
             if (list->qlen <= qdisc->dev->tx_queue_len) {
                     __skb_queue_tail(list, skb);
                     qdisc->q.qlen++;
                     return 0;
             }
             qdisc->stats.drops++;
             kfree_skb(skb);
             return NET_XMIT_DROP;
    }
 
 	We have tested this by printing the values of list->qlen and 
 checking for different values of txqueuelen ( def-100 upto 100000). still 
 the packets are being dropped after some time when the condition fails. 
 and this is continuing until the whole queue is empty, after this it is 
 again resuming to Xmit properly, this phenomenon is repeated.Actually we 
sending 10 lakh pkts at 500 Mbps speed.  
 
 	The problem is that " is there any flag that tell the queue is 
 full and once it is full it will not take any pkts in and drops all 
 till the queue is empty". If so can u plz suggest a solution to this 
 problem.
 
 
 thanks,
 Ananth.

