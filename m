Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270552AbRHITAn>; Thu, 9 Aug 2001 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270554AbRHITAd>; Thu, 9 Aug 2001 15:00:33 -0400
Received: from [206.166.249.112] ([206.166.249.112]:44038 "EHLO
	srv-exchange2.adtran.com") by vger.kernel.org with ESMTP
	id <S270552AbRHITAW>; Thu, 9 Aug 2001 15:00:22 -0400
Message-ID: <3B72DD74.199F31B7@adtran.com>
Date: Thu, 09 Aug 2001 13:59:00 -0500
From: Ron Flory <ron.flory@adtran.com>
Organization: Adtran
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.6 & 2.4.7 networking performance: seeing serious delays 
 inTCP layer depending upon packet length
In-Reply-To: <OF867C5EBC.F320CE04-ON87256AA3.00608124@boulder.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shirley Ma wrote:
> 
> Hi, Ron,
> 
>      I am interested the problem you posted. I tried to reproduce
> this problem on my machine and failed. Would you please point your 
> programs to me, so I can reproduce this problem and do more 
> investigation? If not, please let me know whether it is reproducible,
> and please collect both client/server ethereal log.

 OK, will follow-on in a private email (to minimize lkml traffic)
 
 I can easily reproduce the problem by performing a socket 'write' as
two separate operations:

   write(sock, buf1..)
   write(sock, buf2..)

 If on the other hand I combine the buffers then issue a single
'write':

   write(sock, both_bufs...)

 the problem magically disappears (because the inter-block handshaking 
requirements change, which is where I think the problem actually lies).

 Since the problem is also present using the loopback device, both 
client/server sides would be present in a Ethereal long of LO.

 I would imagine anybody running a large Linux ftp/http server would be
interested in this...

ron
