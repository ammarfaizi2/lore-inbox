Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSHZTXy>; Mon, 26 Aug 2002 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSHZTXy>; Mon, 26 Aug 2002 15:23:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:32896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317624AbSHZTXx>; Mon, 26 Aug 2002 15:23:53 -0400
Date: Mon, 26 Aug 2002 15:29:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Aleksandar Kacanski <kacanski@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak
In-Reply-To: <20020826190106.42208.qmail@web12706.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020826152100.6296B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, Aleksandar Kacanski wrote:

> Hello,
> I am running 2.4.18-3 version of the kernel on smp dual
> processor and 1GB of RAM. My memory usage is increasing and
> I can't find what exactly is eating memory. Top and proc
> are reporting increases, but I would like to know of a
> better way of tracing usage of memory and possible leak in
> application(s).
> 
> Please reply to kacanski@yahoo.com
> thanks                Sasha
> 
> 

Applications that use malloc() and friends, get more memory from
the kernel by resetting the break address. It's called "morecore()".
You can put a procedure, perhaps off SIGALRM, that periodically
checks the break address and writes it to a log. Applications
that end up with an ever-increasing break address have memory
leaks. Note that the break address is almost never set back.
This is not an error; malloc() assumes that if you used a lot
of memory once, you'll probably use it again. Check out sbrk()
and brk() in the man pages.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

