Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSJ3Mif>; Wed, 30 Oct 2002 07:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbSJ3Mif>; Wed, 30 Oct 2002 07:38:35 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:3853 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S262887AbSJ3Mie>;
	Wed, 30 Oct 2002 07:38:34 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: TCP hangs in 2.4 - blocking write() in wait_for_tcp_memory
Date: Wed, 30 Oct 2002 12:44:22 +0000 (UTC)
Organization: Cistron
Message-ID: <apok75$84t$2@ncc1701.cistron.net>
References: <apme9u$n2n$1@ncc1701.cistron.net> <apod64$sv5$1@ncc1701.cistron.net> <20021030122812.GA5182@outpost.ds9a.nl>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1035981862 8349 62.216.29.67 (30 Oct 2002 12:44:22 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021030122812.GA5182@outpost.ds9a.nl>,
bert hubert  <ahu@ds9a.nl> wrote:
>On Wed, Oct 30, 2002 at 10:44:20AM +0000, Miquel van Smoorenburg wrote:
>
>> This makes both socket programs hang in write(), in wait_for_tcp_memory.
>> Shouldn't the kernel return a short write, instead of hanging
>> both processes ? select() returned writeability.
>
>write(2) is allowed to do a short write on a blocking socket, but not
>mandated to do so. In fact I've only seen short writes under
>linux on non-blocking sockets.
>
>SuSv3 says:

Ah, that's interesting:

> Blocking/immediate: Blocking is only possible with O_NONBLOCK clear. If
> there is enough space for all the data requested to be written immediately,
> the implementation should do so. Otherwise, the process may block; that is,

Okay, _may_ block. That's what I needed to know. So it's not a kernel
bug, but a bug in applications like socket(1) and nc(1).

With squid I see corrupted downloads, that probably means squid does
use non-blocking sockets but doesn't handle short writes correctly.

> Partial and deferred writes are only possible with O_NONBLOCK set.

Thanks for the clarification.

Now I must go fix all those programs :/

Mike.

