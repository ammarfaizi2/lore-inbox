Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286289AbRLTQa3>; Thu, 20 Dec 2001 11:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286290AbRLTQaT>; Thu, 20 Dec 2001 11:30:19 -0500
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:20955 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S286287AbRLTQaE>; Thu, 20 Dec 2001 11:30:04 -0500
Message-ID: <3C22129C.4A4E2269@kegel.com>
Date: Thu, 20 Dec 2001 08:32:28 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: "David S. Miller" <davem@redhat.com>, bcrl <bcrl@redhat.com>,
        billh <billh@tierra.ucsd.edu>, torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <Pine.LNX.4.33.0112201127400.2656-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> it's not a fair comparison. The system was set up to not exhibit any async
> IO load. So a pure, atomic sendfile() outperformed TUX slightly, where TUX
> did something slightly more complex (and more RFC-conform as well - see
> Date: caching in X12 for example). Not something i'd call a proof - this
> simply works around the async IO interface. (which RT-signal driven,
> fasync-helped async IO interface, as phttpd has proven, is not only hard
> to program and is unrobust, it also performs *very badly*.)

Proper wrapper code can make them (almost) easy to program with.
See http://www.kegel.com/dkftpbench/doc/Poller_sigio.html for an example
of a wrapper that automatically handles the fallback to poll() on overflow.
Using this wrapper I wrote ftp clients and servers which use a thin wrapper
api that lets the user choose from select, poll, /dev/poll, kqueue/kevent, and RT signals
at runtime.

That said, I think that using the RT signal queue is just plain the
wrong way to go, and I can't wait for better approaches to make it
into the standard kernel someday.

- Dan
