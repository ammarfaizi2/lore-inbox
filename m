Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbSIWUSr>; Mon, 23 Sep 2002 16:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSIWUSr>; Mon, 23 Sep 2002 16:18:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26289 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261358AbSIWUSq>;
	Mon, 23 Sep 2002 16:18:46 -0400
Date: Mon, 23 Sep 2002 22:32:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Larry McVoy <lm@bitmover.com>, Peter Waechtler <pwaechtler@mac.com>,
       <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <Pine.LNX.3.96.1020923152135.13351C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0209232218320.2118-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Bill Davidsen wrote:

> The programs which benefit from N:M are exactly those which don't behave
> the way you describe. [...]

90% of the programs that matter behave exactly like Larry has described.
IO is the main source of blocking. Go and profile a busy webserver or
mailserver or database server yourself if you dont believe it.

> [...] Think of programs using locking to access shared memory, or other
> fast resources which don't require a visit to the kernel. [...]

oh - actually, such things are quite rare it turns out. And even if it
happens, the 1:1 model is handling this perfectly fine via futexes, as
long as the contention of the shared resource is light. Which it better be
...

any application with heavy contention over some global shared resource is
serializing itself already and has much bigger problems than that of the
threading model ... Its performance will be bad both under M:N and 1:1
models - think about it.

so a threading abstraction must concentrate on what really matters:  
performing actual useful tasks - most of those tasks involve the use of
some resource, block IO, network IO, user IO - each of them involve entry
into the kernel - at which point the 1:1 design fits much better.

(and all your followup arguments are void due to this basic
misunderstanding.)

	Ingo

