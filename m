Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbUCBNAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 08:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUCBNAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 08:00:19 -0500
Received: from [195.23.16.24] ([195.23.16.24]:65501 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261633AbUCBNAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 08:00:10 -0500
Message-ID: <404484F2.5020706@grupopie.com>
Date: Tue, 02 Mar 2004 12:58:26 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: johnny zhao <filamoon2@hotmail.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: udp packet loss even with large socket buffer
References: <BAY14-F15j87cUL2cZ00000613e@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johnny zhao wrote:

> hi,
> 
> Since my program is coping with MSN, it's not easy to post a small 
> example. But I will try :)
> 
> I use the following code to initialize the socket:
> 
> *****************************
>     session->rtp.loc_addr.sin_family = AF_INET;
>     session->rtp.loc_addr.sin_addr.s_addr = INADDR_ANY;
>     session->rtp.loc_addr.sin_port = htons (port);
>     session->rtp.socket = socket (PF_INET, SOCK_DGRAM, 0);

                                                         ^^^
This should really be IPPROTO_UDP as defined in <netinet/in.h>


>     g_return_val_if_fail (session->rtp.socket > 0, -1);
>     err = bind (session->rtp.socket,
>             (struct sockaddr *) &session->rtp.loc_addr,
>             sizeof (struct sockaddr_in));
>     /* set the address reusable */
>     err = setsockopt (session->rtp.socket, SOL_SOCKET, SO_REUSEADDR,
>               (void*)&optval, sizeof (optval));
> 
>     optval = 8388608;


You are right, this is really a huuuuuge buffer. If you are getting a 1.5kb 
packet every 80 ms on average, this is about 20kb/second. Even a 64kb buffer 
should be much more than enough.

My advice is just request a 64kb buffer, and stop messing with the rmem_default 
and rmem_max parameters.


-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

