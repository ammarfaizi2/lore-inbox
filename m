Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUB1WIS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 17:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbUB1WIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 17:08:17 -0500
Received: from bay14-f15.bay14.hotmail.com ([64.4.49.15]:4370 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261932AbUB1WIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 17:08:14 -0500
X-Originating-IP: [24.136.227.168]
X-Originating-Email: [filamoon2@hotmail.com]
From: "johnny zhao" <filamoon2@hotmail.com>
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: udp packet loss even with large socket buffer
Date: Sat, 28 Feb 2004 17:08:13 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F15j87cUL2cZ00000613e@hotmail.com>
X-OriginalArrivalTime: 28 Feb 2004 22:08:13.0363 (UTC) FILETIME=[5BD9A830:01C3FE47]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Since my program is coping with MSN, it's not easy to post a small example. 
But I will try :)

I use the following code to initialize the socket:

*****************************
	session->rtp.loc_addr.sin_family = AF_INET;
	session->rtp.loc_addr.sin_addr.s_addr = INADDR_ANY;
	session->rtp.loc_addr.sin_port = htons (port);
	session->rtp.socket = socket (PF_INET, SOCK_DGRAM, 0);
	g_return_val_if_fail (session->rtp.socket > 0, -1);
	err = bind (session->rtp.socket,
		    (struct sockaddr *) &session->rtp.loc_addr,
		    sizeof (struct sockaddr_in));
	/* set the address reusable */
	err = setsockopt (session->rtp.socket, SOL_SOCKET, SO_REUSEADDR,
			  (void*)&optval, sizeof (optval));

	optval = 8388608;
	int optlen;
	err = setsockopt (session->rtp.socket, SOL_SOCKET, SO_RCVBUF,
	      (void*)&optval, sizeof (optval));
	err = getsockopt (session->rtp.socket, SOL_SOCKET, SO_RCVBUF,
	      (void*)&optval, &optlen);
**************************

the following code is used to receive data:
**************************

      while ( ( error = recvfrom (session->rtp.socket, mp->b_wptr,
					  1500, 0,
					  (struct sockaddr *) &remaddr,
					  &addrlen) ) > 0 )
      {
        mp->b_wptr = mp->b_rptr + error;
        rtp_parse(session, mp);    //this function parses and enqueues the 
received packet
        mp = allocb (1500/*session->max_buf_size*/, 0);   //wang
      }
**************************

These codes are executed in a thread with the highest priority.
Thank you in advance!

Best regards,
Johnny

>From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
>To: "johnny zhao" <filamoon2@hotmail.com>, linux-kernel@vger.kernel.org
>Subject: Re: udp packet loss even with large socket buffer
>Date: Sat, 28 Feb 2004 23:22:50 +0200
>
>On Saturday 28 February 2004 03:09, johnny zhao wrote:
> > Hi,
> >
> > I have a problem when trying to receive udp packets containing video 
>data
> > sent by Microsoft Windows Messenger. Here is a detailed description:
> >
> > Linux box:
> >     Linux-2.4.21-0.13mdksmp, P4 2.6G HT
> > socket mode:
> >     blocked mode
> > code used:
> >     while ( recvfrom(...) )
> > socket buffer size:
> >     8388608, set by using sysctl -w net.core.rmem_default and rmem_max
> >
> > I used ethereal(using libpcap) to monitor the network traffic. All the
> > packets were transferred and captured by libpcap. But my program 
>constantly
> > suffers from packet loss. According to ethereal, the average time 
>interval
> > between 2 packets  is 70-80ms, and the minimum interval can go down to
> > ~1ms. Each packet is smaller than 1500 bytes (ethernet MTU).
> >
> > Can anybody help me? I googled and found a similar case that had been
> > solved by increasing the socket buffer size. But it doesn't work for me. 
>I
> > think 8M is a crazily large size :(
>
>Post a small program demonstrating your problem.
>(I'd test udp receive with netcat too)
>--
>vda
>

_________________________________________________________________
Find and compare great deals on Broadband access at the MSN High-Speed 
Marketplace. http://click.atdmt.com/AVE/go/onm00200360ave/direct/01/

