Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135321AbRECWgt>; Thu, 3 May 2001 18:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135284AbRECWgj>; Thu, 3 May 2001 18:36:39 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:34820 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S135321AbRECWgf>; Thu, 3 May 2001 18:36:35 -0400
To: linux-kernel@vger.kernel.org
Subject: skb->truesize > sk->rcvbuf == Dropped packets
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OFE81E1255.065B9900-ON84256A41.007639FA@urscorp.com>
Date: Thu, 3 May 2001 19:29:16 -0300
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 05/03/2001 06:32:17 PM,
	Serialize complete at 05/03/2001 06:32:17 PM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under certain conditions (e.g. nfs) the socket receive buffer is set to 
2048, but in the dma token ring drivers we have the receive skb's set to 
mtu size, i.e. anything up to 18200. The default for these drivers is 
4096. 

So, when any packets are received, even though the skb->len is less than 
sk->rcvbuf, these packets are getting dropping in sock_queue_rcv_skb 
causing massive timeout problems with nfs. 

I can implement one solution by copying the received packets into skb's 
with the correct length, but that eliminates the performance gains from 
simply swapping buffers around (and would definately mean no zero-copy). 

Is there a better way to do this, or can any changes be made in the socket 
handling functions ?

Mike

