Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135413AbRECXb6>; Thu, 3 May 2001 19:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbRECXbr>; Thu, 3 May 2001 19:31:47 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:54034 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S135413AbRECXb1>; Thu, 3 May 2001 19:31:27 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: skb->truesize > sk->rcvbuf == Dropped packets
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OFB60DB560.B716D10F-ON84256A41.007A7A73@urscorp.com>
Date: Thu, 3 May 2001 20:24:07 -0300
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 05/03/2001 07:27:09 PM,
	Serialize complete at 05/03/2001 07:27:09 PM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I can implement one solution by copying the received packets into skb's 

>> with the correct length, but that eliminates the performance gains from 

>> simply swapping buffers around (and would definately mean no 
zero-copy). 

> Generally it is a win to copy rather than swap buffers when the frame 
does
> not occupy most of the buffer. Most traffic is very small or MTU sized
> frames (and on TR of course ethernet not TR mtu frames are popular)

Any suggestions on heuristics for this ? 
Say maybe copy if skb->len <= eth_max_mtu, skb->len <= skb->truesize * .5, 
or just copy the packets no matter what size. 

Mike

