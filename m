Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSKSAXC>; Mon, 18 Nov 2002 19:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265308AbSKSAXB>; Mon, 18 Nov 2002 19:23:01 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:33279 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S265305AbSKSAXB>; Mon, 18 Nov 2002 19:23:01 -0500
Message-ID: <3DD98B79.20102@kegel.com>
Date: Mon, 18 Nov 2002 16:53:13 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
References: <Pine.LNX.4.44.0211181533501.979-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
>>I'd be happy to contribute better doc... has the man page
>>for sys_epoll been written yet?
> 
> http://www.xmailserver.org/linux-patches/epoll.2
> http://www.xmailserver.org/linux-patches/epoll_create.2
> http://www.xmailserver.org/linux-patches/epoll_ctl.2
> http://www.xmailserver.org/linux-patches/epoll_wait.2
> 
> it is going to change though with the latest talks about the interface.

Hmm.  Right off the bat, I see a terminology problem.
The man page says

.SH NAME
epoll \- edge triggered asynchronous I/O facility

That's going to confuse some users.  They might think
epoll can actually initiate I/O.  Better to say

epoll \- edge triggered I/O readiness notification facility

Second, epoll_ctl(2) doesn't define the meaning of the
event mask.  It should give the allowed bits and define
their meanings.  If we use the traditional POLLIN etc, we
can say
   POLLIN - the fd has become ready for reading
   POLLOUT - the fd has become ready for writing
   Note: If epoll tells you e.g. POLLIN, it means that
            poll will tell you the same thing,
            since poll gives the current status,
            and epoll gives changes in status.

- Dan


