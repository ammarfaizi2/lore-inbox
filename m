Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUKQQMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUKQQMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbUKQQMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:12:18 -0500
Received: from alog0333.analogic.com ([208.224.222.109]:23680 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262361AbUKQQKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:10:36 -0500
Date: Wed, 17 Nov 2004 11:09:56 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Catalin Drula <Catalin.Drula@imag.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: AF_UNIX sockets: strange behaviour
In-Reply-To: <Pine.GSO.4.33.0411171618260.8987-100000@horus.imag.fr>
Message-ID: <Pine.LNX.4.61.0411171101270.7880@chaos.analogic.com>
References: <Pine.GSO.4.33.0411171618260.8987-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Catalin Drula wrote:

> Hi,
>
> I have a small application that communicates over Bluetooth. I use
> connection-oriented UNIX domain sockets (AF_UNIX, SOCK_STREAM) to
> communicate between the applications's threads. When reading from
> one of these sockets, I get a strange behaviour: if I read all the
> bytes that are available (13, in this case) all at once, it's fine;
> however, if I try to read in two smaller batches (say, first time
> 6, and second time 7), the first read returns (with the 6 bytes), but
> the second read never returns.
>
> As far as I know, this is not expected behaviour for SOCK_STREAM sockets.
> I tried looking into the problem so I instrumented net/unix/af_unix.c to
> see what is going on. More specifically, I was focusing on the function
> unix_stream_recvmsg. Here is what I noticed:
>
>  - there is a skb in the sk_receive_queue with a len of 13
>  - 6 bytes are read from it
>  - a skb with the remaining 7 bytes is requeued in sk_receive_queue
>  - on the next call to unix_stream_recvmsg, the sk_receive_queue is
> empty (!)
>
> Thus, this confirms the behaviour observed from userspace. Is this a bug?
> Who could be removing the skb from the receive_queue?
>
> Thanks for any ideas/suggestions,
>
> Catalin
>
> ps Please cc: your replies to me.

If you need STREAM behavior I think you need to use recv(), recvfrom(),
or read().

If you use recvmsg(), the "message" will be removed even it you haven't 
read it all. Note in the 'man' page description:
"If the a message is too long to fit in the supplied buffer, excess bytes
may be discarded depending upon the type of socket the message is being
received from..."


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
