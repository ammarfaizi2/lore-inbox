Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUIQRB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUIQRB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUIQRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:01:09 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:1711 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268235AbUIQQ7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:59:12 -0400
Subject: Re: nproc: So?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rl@hellgate.ch
Content-Type: text/plain
Organization: 
Message-Id: <1095440131.3874.4626.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Sep 2004 12:55:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:
> I have received some constructive criticism and suggestions,
> but I didn't see any comments on the desirability of nproc in
> mainline. Initially meant to be a proof-of-concept, nproc has
> become an interface that is much cleaner and faster than procfs
> can ever hope to be (it takes some reading of procps or libgtop
> code to appreciate the complexity that is /proc file parsing today),

You spotted the perfect hash lookup? :-)

> and every change in /proc files widens the gap. I presented
> source code, benchmarks, and design documentation to substantiate
> my claims; I can post the user-space code somewhere if there's
> interest.
>
> So I'm wondering if everybody's waiting for me to answer some
> important question I overlooked, or if there is a general
> sentiment that this project is not worth pursuing.

I'm very glad to see numerical proof that /proc is crap.
If nproc does nothing else, it's still been useful.

The funny varargs/vsprintf/whatever encoding is useless to me,
as are the labels.

The nicest think about netlink is, i think, that it might make
a practical interface for incremental update. As processes run
or get modified, monitoring apps might get notified. I did not
see mention of this being implemented, and I would take quite 
some time to support it, so it's a long-term goal. (of course,
people can always submit procps patches to support this)

I doubt that it is good to break down the data into so many
different items. It seems sensible to break down the data by 
locking requirements. 

I could use an opaque per-process cookie for process identification.
This would protect from PID reuse, and might allow for faster
lookup. Perhaps it contains: PID, address of task_struct, and the
system-wide or per-cpu fork count from process creation.

Something like the stat() syscall would be pretty decent.

Well, whatever... In any case, I'd need to see some working code
for the libproc library. My net connection dies for hours at a
time, so don't expect speedy anything right now.

BTW, I have a 32-bit big-endian system with char being unsigned
by default. The varargs stuff is odd too.


