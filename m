Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUDNR7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUDNR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:59:47 -0400
Received: from [63.107.13.101] ([63.107.13.101]:23216 "EHLO mail.metavize.com")
	by vger.kernel.org with ESMTP id S261497AbUDNR7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:59:45 -0400
Message-ID: <407D7BFF.4010700@metavize.com>
Date: Wed, 14 Apr 2004 10:59:27 -0700
From: Dirk Morris <dmorris@metavize.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Ben Mansell <ben@zeus.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll reporting events when it hasn't been asked to
References: <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>On Fri, 2 Apr 2004, Ben Mansell wrote:
>  
>
>>>If an exception occurs (example a socket is disconnected) the socket
>>>should be removed from the fd list.  There is really no point in passing
>>>in an excepted fd.
>>>      
>>>
>>Is there any difference, speed-wise, between turning off all events to
>>listen to with EPOLL_MOD, and removing the file descriptor with
>>EPOLL_DEL? I had vaguely assumed that the former would be faster
>>(especially if you might later want to resume listening for events),
>>although that was just a guess.
>>    
>>

I'd like to weigh in on this issue as I'm having the same issue as Ben.
My application doesnt consider these to be exceptional events, but 
normal expected events, and thus
I need them to be handled like normal events. (I can explain more off 
list if you'd like)
So I just want to ignore all events for some time and then deal with any 
HUP's or ERR's at the appropriate time.
When I used poll(), I always accomplished this by leaving this fd out of 
the poll fd set.
This wasnt a huge hit because I basically had to rebuild the poll fd set 
at every iteration anyway as it changes rapidly.

Now I'm switching to epoll, and the great thing about the epoll 
interface is I don't have to rebuild the entire fd set at every iteration.
Like Ben, I'd prefer to be able to disable ALL events on a fd descriptor 
for some time, instead of removing it entirely.
Since with poll I had to rebuild the set anyway, this 'disable' feature 
wasnt really useful, but would be a nice-to-have for epoll.
:))






