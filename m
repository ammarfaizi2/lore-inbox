Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269169AbUJFPbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269169AbUJFPbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUJFPbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:31:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269169AbUJFP3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:29:39 -0400
Date: Wed, 6 Oct 2004 11:29:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "David S. Miller" <davem@davemloft.net>
cc: joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <20041006082145.7b765385.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
 <20041006082145.7b765385.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, David S. Miller wrote:

> On Wed, 6 Oct 2004 11:15:13 -0400 (EDT)
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
>
>> On Wed, 6 Oct 2004, David S. Miller wrote:
>>
>>> On Wed, 6 Oct 2004 16:52:27 +0200 (CEST)
>>> Joris van Rantwijk <joris@eljakim.nl> wrote:
>>>
>>>> My understanding of POSIX is limited, but it seems to me that a read call
>>>> must never block after select just said that it's ok to read from the
>>>> descriptor. So any such behaviour would be a kernel bug.
>>>
>>> There is no such guarentee.
>>
>> Huh?  Then why would anybody use select()?  It can't return a
>> 'guess" or it's broken. When select() or poll() claims that
>> there are data available, there damn well better be data available
>> or software becomes a crap-game.
>
> So if select returns true, and another one of your threads
> reads all the data from the file descriptor, what would you
> like the behavior to be for the current thread when it calls
> read?
>
> So like I said, there is no such guarentee.
>

Any code that uses select() on the same file-descriptor
for several threads is broken. You can't explain away
a select() problem with a bad-coding example. Somebody
else responded that a bad checksum could do the same
thing --not. Select must return correct information.
The user-code doesn't know about, doesn't care, and
in many cases can't find out about, the inner workings
of an operating system.

When a function call like select() says there are data
available, there must be data available, period. If
not, it's broken and needs to be fixed. Requiring
one to set sockets to non-blocking is a poor work-
around for an otherwise fatal flaw.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

