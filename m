Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVGEQvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVGEQvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVGEQuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:50:44 -0400
Received: from alog0326.analogic.com ([208.224.222.102]:23687 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261838AbVGEQtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:49:19 -0400
Date: Tue, 5 Jul 2005 12:48:03 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Sending ethernet frames one after another
In-Reply-To: <20050705155249.GA11451@kestrel>
Message-ID: <Pine.LNX.4.61.0507051239330.6413@chaos.analogic.com>
References: <20050705155249.GA11451@kestrel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005, Karel Kulhavy wrote:

> Hello
>
> I have written a software to test connected optical datalink in loopback
> mode which works by sending a burst of e. g. 1024 raw Ethernet frames
> directly to that interface, then waiting a little bit, and counting from
> ifconfig how many were received.
>
> Some people report a problem that on their eepro100 in IBM Thinkpad, the
> program (probably sendto) is returning error "No buffer space available".
>
> Why doesn't the sendto block instead? Does it mean that I cannot use
> this testing mode with that card? I need to send as fast as possible,
> because it's necessary to constantly transmit, as the link must be
> tested in load going in both directions simultaneously, to catch
> possible crosstalks.
>

If sendto is used on a data-gram socket, it may just dump
extra packets on the floor. If you have a connected socket,
sendto will return an error when no buffers are available.

If you want RELIABLE communication, then you use a connected
stream socket and send() or write(). These handle transmission
problems transparently.

> Or is that an error that should be handled by the application? In which
> way, then?
>

Generally, it is least expensive as far as performance is concerned
if you let the kernel handle errors, retries, duplicate packets, etc.
That's what you get with a connected stream socket. However, since
every packet is ACKed, the round-trip time can be a performance
killer. So, a private protocol for talking through satellites which
have awful round-trip time might be to number packets at the application
level, send everything, then query the receiver software about the
missing packets. This continues until all the packets have been
received.

> Regards,
>
> CL<
>




Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
