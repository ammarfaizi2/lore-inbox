Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274055AbRJJCJh>; Tue, 9 Oct 2001 22:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274062AbRJJCJ3>; Tue, 9 Oct 2001 22:09:29 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:22547 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S274055AbRJJCJQ>; Tue, 9 Oct 2001 22:09:16 -0400
Subject: Re: 2.4.10-ac10-preempt lmbench output.
From: Robert Love <rml@ufl.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011010031803.F8384@athlon.random>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> 
	<20011010031803.F8384@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 22:10:26 -0400
Message-Id: <1002679828.866.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 21:18, Andrea Arcangeli wrote:
> xmms skips during I/O should have nothing to do with preemption.

Why does preemption patch make a difference for me, then?  I'm not doing
anything even remotely close to real-time processing.

> As Alan noted for the ring of dma fragments to expire you need a
> scheduler latency of the order of seconds, now (assuming the ll points
> in read/write paths) when we've bad latencies under writes it's of the
> order of 10msec and it can be turned down further by putting preemption
> checks in the buffer lru lists write paths.

Isn't mp3 decoding done `just in time' ie we decode x and buffer x,
decode y and buffer y...hopefully in a quick enough manner it sounds
like coherent sound?  Thus, if the task can not be scheduled as
required, there are noticeable latencies in the sound not because the
sound card buffer ran dry but because the mp3 couldn't even be decoded
to fill the buffer!

Anyhow, if we have latencies of 10ms (and in reality there are higher
latencies, too), these can cause the sort of system response scenerios
that are a problem.  Preemption makes these latencies effectively 0
(outside of locks).

	Robert Love

