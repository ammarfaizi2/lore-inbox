Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263600AbTCUM6V>; Fri, 21 Mar 2003 07:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263603AbTCUM6V>; Fri, 21 Mar 2003 07:58:21 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:40065 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S263600AbTCUM6U>; Fri, 21 Mar 2003 07:58:20 -0500
Message-ID: <7A5D4FEED80CD61192F2001083FC1CF906513D@CHARLY>
From: "Filipau, Ihar" <ifilipau@sussdd.de>
To: "'David Schwartz'" <davids@webmaster.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: read() & close()
Date: Fri, 21 Mar 2003 14:07:34 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: David Schwartz Sent: Freitag, 21. Marz 2003 13:36
> On Thu, 20 Mar 2003 15:14:52 +0100, Filipau, Ihar wrote:
> 
> >I have/had a simple issue with multi-threaded programs:
> >
> >one thread is doing blocking read(fd) or poll({fd}) on file/socket.
> >
> >another thread is doing close(fd).
> >
> >I expected first thread will unblock with some kind
> >of error - but nope! It is blocked!
> >
> >Is it expected behaviour?
> 
> 	It is impossible to make this work reliably, so 
> *please* don't do 
> that. For example, how can you possibly assure that the first thread 
> is actually in 'poll' when call 'close'? There is no atomic 'release 
> mutex and poll' function.
> 
> 	So what happens if the system pre-empts the thread 
> right before it 
> calls 'poll'. Then you call 'close'. Perhaps next a thread started by 
> some library function calls 'socket' and gets the file descriptor you 
> just 'close'd. Now your call to 'poll' polls on the *wrong* socket!
> 
> 	You simply must accept the fact that you cannot free a 
> resource in  one thread while another thread is or might be using it.
> 

    In my case I was actually trying to use pipe/socket handle
    as a synchronisation point. to signal threads to wake-up at
    programme shut-down.

    But yes - you are right. This approach is prone to errors.

    It looks like in this kind of situations /dev/epoll should be used - 
    when set of fds is defined before. and all operations on this set 
    can be easily synchronized.
    Sure if /dev/epoll can handle closing of fd correctly - and will
    remove it from set.
