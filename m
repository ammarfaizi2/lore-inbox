Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbUKQQpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUKQQpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbUKQQna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:43:30 -0500
Received: from alog0333.analogic.com ([208.224.222.109]:24960 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262401AbUKQQmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:42:00 -0500
Date: Wed, 17 Nov 2004 11:41:47 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Catalin Drula <Catalin.Drula@imag.fr>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: AF_UNIX sockets: strange behaviour
In-Reply-To: <Pine.GSO.4.33.0411171717530.8987-100000@horus.imag.fr>
Message-ID: <Pine.LNX.4.61.0411171133260.8191@chaos.analogic.com>
References: <Pine.GSO.4.33.0411171717530.8987-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Catalin Drula wrote:

>> Dick Johnson wrote:
>>
>>> Catalin Drula wrote:
>>>
>>> - there is a skb in the sk_receive_queue with a len of 13
>>> - 6 bytes are read from it
>>> - a skb with the remaining 7 bytes is requeued in sk_receive_queue
>>> - on the next call to unix_stream_recvmsg, the sk_receive_queue is
>>>  empty (!)
>>>
>>> Thus, this confirms the behaviour observed from userspace. Is this a
>>> bug? Who could be removing the skb from the receive_queue?
>>
>> If you need STREAM behavior I think you need to use recv(),
>> recvfrom(),or read().
>>
>> If you use recvmsg(), the "message" will be removed even it you
>> haven't read it all. Note in the 'man' page description:
>> "If the a message is too long to fit in the supplied buffer, excess
>> bytes may be discarded depending upon the type of socket the message
>> is being received from...
>
> At first I used read() and then I tried recv() as well.
>
> Catalin

My reading of the specs is that read() damn-well never throw
away anything that hasn't been read yet. If it does, then
it's a bug. That said, the bug may never be fixed because
(1) people may deny it's a bug, or (2) programs may rely
on it.

FYI, it the first condition, I've seen these kinds of bugs
mysteriously fixed later on even though many people denied they
were bugs.

I suggest you supply a big enough buffer to read the hole thing
and then tear it apart at the application level.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
