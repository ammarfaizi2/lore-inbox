Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264295AbRFGD0Y>; Wed, 6 Jun 2001 23:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264296AbRFGD0P>; Wed, 6 Jun 2001 23:26:15 -0400
Received: from paperboy.noris.net ([62.128.1.27]:20948 "EHLO mail2.noris.net")
	by vger.kernel.org with ESMTP id <S264295AbRFGDZ5>;
	Wed, 6 Jun 2001 23:25:57 -0400
Mime-Version: 1.0
Message-Id: <p05100310b744a22f02a6@[192.109.102.42]>
In-Reply-To: <E157kxf-0000UE-00@the-village.bc.nu>
In-Reply-To: <E157kxf-0000UE-00@the-village.bc.nu>
Date: Thu, 7 Jun 2001 05:25:30 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, thierry.lelegard@canal-plus.fr
From: Matthias Urlichs <smurf@noris.de>
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed
 in the
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:35 +0100 2001-06-06, Alan Cox wrote:
>  > This report describes a problem in the usage of file descriptors across
>>  multiple threads. When one thread closes a file descriptor, another
>>  thread which waits for an I/O on that file descriptor is not notified
>>  and blocks forever.
>
>THe I/O does not block forever, it blocks until completed.

That's still "forever" if you don't specify a timeout in the select.

>The actual final
>closure of the object occurs when the last operation on it exits

Select is defined as to return, with the appropriate bit set, if/when 
a nonblocking read/write on the file descriptor won't block. You'd 
get EBADF in this case, therefore causing the select to return would 
be a Good Thing.

A related problem is that the second thread my be inside a blocking 
read() instead of a select() call. It'd never continue.  :-(

HOWEVER: IMHO it's bad design to distribute the responsibility for 
file descriptors between threads.
Therefore I think that this behavior is a bug, but it's not one that 
needs to be fixed yesterday.
-- 
Matthias Urlichs
