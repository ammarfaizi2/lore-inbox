Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132937AbRDJFot>; Tue, 10 Apr 2001 01:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132935AbRDJFoa>; Tue, 10 Apr 2001 01:44:30 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:65285 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132934AbRDJFo1>; Tue, 10 Apr 2001 01:44:27 -0400
Date: Mon, 9 Apr 2001 22:43:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
cc: Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
In-Reply-To: <y9t9easn.wl@frostrubin.open.nm.fujitsu.co.jp>
Message-ID: <Pine.LNX.4.31.0104092242320.11520-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Apr 2001, Tachino Nobuhiro wrote:
>
>   I am not familiar with semaphore or x86, so this may not be correct,
> but if the following sequence is possible, the writer can call wake_up()
> before the reader calls add_wait_queue() and reader may sleep forever.
> Is it possible?

The ordering is certainly possible, but if it happens,
__down_read_failed() won't actually sleep, because it will notice that the
value is positive and just return immediately. So it will do some
unnecessary work (add itself to the wait-queue only to remove itself
immediately again), but it will do the right thing.

		Linus

