Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSI3QW6>; Mon, 30 Sep 2002 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262451AbSI3QW5>; Mon, 30 Sep 2002 12:22:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13290 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262450AbSI3QWz>;
	Mon, 30 Sep 2002 12:22:55 -0400
Date: Mon, 30 Sep 2002 18:38:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@sgi.com>
Cc: lord@sgi.com, Arjan van de Ven <arjanv@redhat.com>, <cw@f00f.org>,
       <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
In-Reply-To: <20020930193713.A13195@sgi.com>
Message-ID: <Pine.LNX.4.44.0209301835190.18614-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Sep 2002, Christoph Hellwig wrote:

> But it breaks XFS.  Chris Wedgwood fixed it to use schedule_task()
> instead (and I cleaned it up a littler more, see patch below), but this
> does effectively simgle-thead XFS I/O completion.

see the workqueues patch i posted a couple of minutes ago. Does this solve
XFS's problems?

> Altennatively we could allow kernel code to create it's own kevends with
> associated task-queues, but that sounds rather ugly..

why is it ugly? I can add a simple interface to the workqueues subsystem
that will bind the XFS worker threads to given sets of CPUs. That should
give you per-CPU workqueues, with separate per-CPU locking.

	Ingo

