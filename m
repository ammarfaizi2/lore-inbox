Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbTBICNj>; Sat, 8 Feb 2003 21:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbTBICNj>; Sat, 8 Feb 2003 21:13:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48399 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267143AbTBICNj>; Sat, 8 Feb 2003 21:13:39 -0500
Date: Sat, 8 Feb 2003 18:19:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <200302090217.h192Hqi04174@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302081817001.7675-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Feb 2003, Roland McGrath wrote:
> 
> As I said above, I think this race is possible in other uses of
> wake_up_process.

I don't think you have any other users (other than signals)  that wake up
processes that aren't on some wait-queue.

And by the time we exit, we have better had removed outselves from all the
wait-queues, so I suspect signals are really the only thing that can wake
up a process after it died but before it's truly gone.

Anyway, I'll code up the SIGKILL changes that should make this a non-issue 
(along with the bad SIGKILL/kernel-thread interaction).

		Linus

