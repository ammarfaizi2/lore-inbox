Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132356AbRA2QEv>; Mon, 29 Jan 2001 11:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132774AbRA2QEl>; Mon, 29 Jan 2001 11:04:41 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:62969 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132356AbRA2QEj>; Mon, 29 Jan 2001 11:04:39 -0500
Date: Mon, 29 Jan 2001 14:04:11 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Manfred <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] getting rid of tqueue_lock
In-Reply-To: <3A758DEA.832F605D@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0101291403460.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0101291403462.1321@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Manfred wrote:

> I noticed that the tasks queues still rely on the global tqueue_lock
> spinlock, instead of a per-taskqueue lock.
> 
> The patch is virtually transparent for task queue users: all users
> except ieee1394 use DECLARE_TASK_QUEUE.
> 
> I admit that the tqueue_lock isn't that often used (numbers from
> sgi's lockstat)
> 
> * 10000 users/min during 'find / -xdev -uid 4711' (1.2% of all spinlock
> calls)
> * 60000 users/min during 'dd if=/dev/hda of=/dev/null' (~1.1% of all
> spinlock calls).

If there's no contention and nothing else changes, what is this
task supposed to fix?

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
