Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265818AbSKAXVT>; Fri, 1 Nov 2002 18:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbSKAXVT>; Fri, 1 Nov 2002 18:21:19 -0500
Received: from mtao-m01.ehs.aol.com ([64.12.52.73]:52874 "EHLO
	mtao-m01.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S265818AbSKAXVQ>; Fri, 1 Nov 2002 18:21:16 -0500
Date: Fri, 01 Nov 2002 15:27:41 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
In-reply-to: <20021031230215.GA29671@bjl1.asuk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Message-id: <3DC30DED.6040207@netscape.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b)
 Gecko/20021016
References: <20021031230215.GA29671@bjl1.asuk.net>
 <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com>
 <20021101020119.GC30865@bjl1.asuk.net>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>You avoid the extra CPU cycles like this:
>
>    1. EP_CTL_ADD adds the listener to the file's wait queue using
>       ->poll(), and gets a free test of the object readiness [;)]
>
>    2. When the transition happens, the wakeup will call your function,
>       epoll_wakeup_function.  That removes the listener from the file's
>       wait queue.  Note, you won't see any more wakeups from that file.
>
>    3. When you report the event user space, _then_ you automatically
>       add the listener back to the file's wait queue by calling ->poll().
>  
>
The cost of removing and readding the listener to the file's wait queue 
is part of what epoll is amortizing.

There's also the oddity that I noticed this week: pipes don't report 
POLLOUT readiness through the classic poll interface until the pipe's 
buffer is completely empty.  Changing this to report POLLOUT readiness 
when the pipe's buffer is not full apparently causes NIS to break.


