Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWAIAfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWAIAfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965364AbWAIAfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:35:38 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:63156 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S965145AbWAIAfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:35:38 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 8 Jan 2006 16:35:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: "David S. Miller" <davem@davemloft.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] POLLHUP tinkering ...
In-Reply-To: <20060108.162017.97708180.davem@davemloft.net>
Message-ID: <Pine.LNX.4.63.0601081627340.6925@localhost.localdomain>
References: <Pine.LNX.4.63.0601081528170.6925@localhost.localdomain>
 <20060108.160802.103497642.davem@davemloft.net>
 <Pine.LNX.4.63.0601081610130.6925@localhost.localdomain>
 <20060108.162017.97708180.davem@davemloft.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006, David S. Miller wrote:

> From: Davide Libenzi <davidel@xmailserver.org>
> Date: Sun, 8 Jan 2006 16:11:10 -0800 (PST)
>
>> On Sun, 8 Jan 2006, David S. Miller wrote:
>>
>>> The extra last read is always necessary, it's an error synchronization
>>> barrier.  Did you know that?
>>>
>>> If a partial read or write hits an error, the successful amount of
>>> bytes read or written before the error occurred is returned.  Then any
>>> subsequent read or write will report the error immediately.
>>
>> Sorry for the missing info, but I was clearly talking about O_NONBLOCK
>> here.
>
> What I said still applies to O_NONBLOCK.

I thought you said in _not_ necessary, sorry. The extra read() for error 
discovery is just bogus, w/out proper Linux poll reporting. The epoll 
interface will have wait queue heads dropped inside the monitored devices 
wait queue, so I assume that an error condition would trigger a wakeup -> 
epoll event. If this is not true (but I'm pretty much sure it is), look at 
the extra read() for error reporting:

1) Good

read_loop();
--> Error happen on device
if (read() == ERROR)
 	gotcha();

2)

read_loop();
if (read() == ERROR)
 	whoops();
--> Error happen on device




- Davide


