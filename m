Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264204AbRFRPSq>; Mon, 18 Jun 2001 11:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264174AbRFRPSg>; Mon, 18 Jun 2001 11:18:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264215AbRFRPSa>; Mon, 18 Jun 2001 11:18:30 -0400
Date: Mon, 18 Jun 2001 11:18:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: oliver.kowalke@t-online.de
cc: linux-kernel@vger.kernel.org
Subject: Re: problem with write() to a socket and EPIPE
In-Reply-To: <992874658.3b2e10a2ef441@webmail.t-online.de>
Message-ID: <Pine.LNX.3.95.1010618110539.132A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001 oliver.kowalke@t-online.de wrote:

> Hello,
> 
> I've the following problem.
> If the peer has closed its socket connection the second write to this 
> socket should return -1 and errno should be set to EPIPE (if SIGPIPE is 
> set  
> to be ignored). This never happens with my code. Why?
> 

So what errno does it return? Writing to a closed socket can
return several things, based upon what was detected first. I
don't think you can count on a specific errno value. Successful
socket handlers use the following heuristics:

If the returned value was -1, the error is temporary, try again.
If the returned value was 0, the error is permanent.

The first write to a closed socket may return -1, with an errno
of something representative of local buffers being full. It takes
some time for a FIN or a RST to show up as the reason why there
is so much data queued. So, if you follow the above heuristic,
the last reason why you got the previous errors will likely be
what you expect.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


