Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269919AbTGVHJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 03:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269942AbTGVHJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 03:09:11 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:54149 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S269919AbTGVHJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 03:09:08 -0400
Message-ID: <3F1CE6B6.4020909@softhome.net>
Date: Tue, 22 Jul 2003 09:24:38 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: luciano@lsd.di.uminho.pt, root@chaos.analogic.com
Subject: Re: SVR4 STREAMS (for example LiS)
References: <bJGh.25l.15@gated-at.bofh.it> <bJZH.2jj.29@gated-at.bofh.it> <bKj0.2yr.3@gated-at.bofh.it>
In-Reply-To: <bKj0.2yr.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luciano Miguel Ferreira Rocha wrote:
> On Mon, Jul 21, 2003 at 10:38:38AM -0400, Richard B. Johnson wrote:
>>Streams are an extension of buffered I/O implimented by the 'C'
>>runtime library. Streams really have nothing to do with the
>>internal workings of kernel I/O. As far as kernel I/O goes,
>>one reads() and writes() from user-space.
> 
> Actually, SysV Streams do.
> 
> An ex, for openning a pty, on svr4:
> fds = open(pts_name, O_RDWR)
> ioctl(fds, I_PUSH, "ptem")
> ioctl(fds, I_PUSH, "ldterm")
> ioctl(fds, I_PUSH, "ttcompat")
> 
> Where ptem, ldterm, ttcompat work as independent modules converting the
> stream, resulting in a pseudo-terminal implementation.
> 
> New programs should just use openpty directly, and let libc take care
> of the actual implementation.
> 
> Also, BSD sockets were implemented using streams also, thus the compatibility
> libraries.
> 
> Anyway, I see no point in caring wether streams are used or not in normal
> programs.
> 

    Not every one has normal programmes and normal needs [1].
    Use of STREAMS allows you easily build up your own network protocol 
stack for example.

    Sun's autopush(1M) looks really cool.
    http://docs.sun.com/db/doc/805-3173/6j31cplrg?a=view

    Configure special device and just feed it your programme.
    Not more - not less.

    As of me I see not that much uses of STREAMS somewhere outside of 
terminal conversions and network stack manipulations. And some rare (but 
  nasty indeed) occasions of stupid binary programmes, which happend to 
be used and happend to need something special.

    On behalf of conclusion I would summarize: STREAMS are Ok, but 
potentially slow and hard to configure (I can easily imagine situation 
when app trying to manipulate already prepared by admin stream 
/something like this).

[1] <blatant rant on>I absolutely do not need to use 64GB of memory - 
but kernel includes HIGH_MEM support. Is it normal for 32bit PC to have 
that much memory? *No*. Do you run any normal programme which does need 
64GB of memory? I bet *No*.<blatant rant off> There are a lot of 
examples of _not_ normal features - read "bloat" - in kernel. And I'm 
not talking about user-land... ;-)

