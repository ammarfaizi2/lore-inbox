Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271972AbRHVJ01>; Wed, 22 Aug 2001 05:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271974AbRHVJ0R>; Wed, 22 Aug 2001 05:26:17 -0400
Received: from mailrelay.inpharmatica.co.uk ([193.115.214.5]:42257 "EHLO
	gallions-reach.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S271972AbRHVJ0E>; Wed, 22 Aug 2001 05:26:04 -0400
Message-ID: <3B837AB3.40308@purplet.demon.co.uk>
Date: Wed, 22 Aug 2001 10:26:11 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() says closed socket readable
In-Reply-To: <NOEJJDACGOHCKNCOGFOMIEKBDFAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

> 	No, because 'select' is defined to work the same on both blocking and
> non-blocking sockets. Roughly, select should hit on read if a non-blocking
> read wouldn't return 'would block'.

Which may be the root of the problem. Linux seems to consider that
select indicates "would not block", whereas Solaris et. al. use
"ready to read". (The difference seems to exist in man pages too)
Clearly an unconnected socket "would not block" but is not
"ready to read".

> 	If you think about the cases where someone might actually do this, odds are
> you want the application's error handling code to launch. That won't happen
> if you never break out of select. However, if you do break out of select, do
> a read, and get an error, the problem will then be handled, rather than
> ignored.

No. If there is a correct behaviour defined in a standard we should
do that. Otherwise we should do what other systems do _unless_ there
is a clear benefit to doing something else. In this case doing
something else appears to create porting problems and confusion over
what select(2) means without any clear benefit.

So, we're back to the beginning: justify with reference or reason :-).

				Mike

