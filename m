Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274305AbRJYOFG>; Thu, 25 Oct 2001 10:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRJYOE6>; Thu, 25 Oct 2001 10:04:58 -0400
Received: from [195.100.32.90] ([195.100.32.90]:58868 "EHLO al.pantor.com")
	by vger.kernel.org with ESMTP id <S274305AbRJYOEm>;
	Thu, 25 Oct 2001 10:04:42 -0400
Message-ID: <3BD81C1C.5040005@pantor.com>
Date: Thu, 25 Oct 2001 16:05:16 +0200
From: Anders Furuhed <anders.furuhed@pantor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Intra-host socket write fails after 1024s if write size <= 970 (in 2.2, not 2.4)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A simple server [ignore SIGPIPE,socket(PF_INET,SOCK_STREAM,0),
setsockopt/REUSEADDR,bind,listen,accept] ignores connecting clients
after accepting them. It just loops over accept.

A simple client [ignore SIGPIPE,socket,connect,write] connects to the
simple server and tries to write blocks of size x forever. A write
call blocks eventually.

In 2.4, the write remains blocking, but in 2.2 (2.2.19, 2.2.20pre11)
the outcome depends on the size x and whether a network is involved.

If (x <= 970 && within a host && using 2.2), the final blocking
write returns after exactly 1024 seconds with errno set to EPIPE
(or sometimes ETIMEDOUT). After this, netstat says that the client
is in 'CLOSE' and that the server is in 'ESTABLISHED'.
Using 2.4, larger block sizes or over a network, the client as we
expect blocks until we get tired of waiting and stop the test (~1h)

The test hosts are RH7.1 or 7.2-based and use the standard
2.2.19-7.0.8 from RH7.0. We have also tried with a basic 2.2.20pre11.
We don't believe that we have modified any tcp parameters etc.

Is there a reason that the write call returns?
I'm on the list if someone has a clue!
The code is available on request (188 lines).

Cheers,
Anders Furuhed, Pantor Engineering

