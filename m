Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSHHWNU>; Thu, 8 Aug 2002 18:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318046AbSHHWNU>; Thu, 8 Aug 2002 18:13:20 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:50137 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S318040AbSHHWNT>; Thu, 8 Aug 2002 18:13:19 -0400
Message-ID: <3D52EDD6.75150466@nortelnetworks.com>
Date: Thu, 08 Aug 2002 18:16:54 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: flushing arp buffer -- why __skb_dequeue rather than __skb_dequeue_tail 
 ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As part of one of our test cases we ran into a scenario where we were sending
out messages while waiting on an arp reply.  As expected they were buffered, but
we noticed that after the reply was received the packets were sent out in LIFO
order.

In neigh_update() in neighbor.c, we're looping through the list calling
__skb_dequeue().  Is there any particular reason why this was chosen rather than
__skb_dequeue_tail()?  The latter would result in FIFO flushing of the buffer
which could have some benefits to udp applications that retry on out-of-order
message receipt, and it doesn't seem to be many more instructions, if any. 
Besides, this isn't the fast path so a few extra instructions shouldn't matter.

Would you anticipate any odd side effects if we did change to FIFO flushing?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
