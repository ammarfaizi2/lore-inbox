Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276957AbRJIX2v>; Tue, 9 Oct 2001 19:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277020AbRJIX2e>; Tue, 9 Oct 2001 19:28:34 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:53272 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276957AbRJIX2S>; Tue, 9 Oct 2001 19:28:18 -0400
Subject: Re: [CFT][PATCH *] faster cache reclaim
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, kernelnewbies@nl.linux.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0110082032070.26495-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0110082032070.26495-100000@duckman.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 19:29:13 -0400
Message-Id: <1002670160.862.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-08 at 19:38, Rik van Riel wrote:

> This patch is meant to fix the problems where heavy cache
> activity flushes out pages from the working set, while still
> allowing the cache to put some pressure on the working set.

Running 2.4.10-ac10 + preempt-kernel + eatcache

System with 3 runnable processes and 2 with large working sets.  384MB
RAM, 768MB swap.  During heavy I/O the resulting cache activity did
"stall" the system as badly as without the patch.

I typically notice high system response time at the start of a heavy I/O
operation when the used memory is primarily taken by cache (ie after a
previous heavy I/O operation).  This was an issue for me because I don't
expect that sort of high latency with the preemption patch.

For example, starting a `dbench 16' would sometimes cause a brief stall
(especially if it is the second run of dbench).  It's better now, but
still not perfect.  The VM holds a lot of locks for a long time.

Good work.  I hope Alan sees it soon.

	Robert Love

