Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277616AbRJHXiw>; Mon, 8 Oct 2001 19:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277618AbRJHXic>; Mon, 8 Oct 2001 19:38:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:18959 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277616AbRJHXiW>; Mon, 8 Oct 2001 19:38:22 -0400
Date: Mon, 8 Oct 2001 20:38:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <linux-mm@kvack.org>
Cc: <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
Subject: [CFT][PATCH *] faster cache reclaim
Message-ID: <Pine.LNX.4.33L.0110082032070.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[WANTED: testers]

Hi,

after looking at some other things for a while, I made a patch to
get 2.4.10-ac* to correctly eat pages from the cache when it is
about pages belonging to files which aren't currently in use. This
should also give some of the benefits of use-once, but without the
flaw of not putting pressure on the working set when a streaming IO
load is going on.

It also reduces the distance between inactive_shortage and
inactive_plenty, so kswapd should spend much less time rolling
over pages from zones we're not interested in.

This patch is meant to fix the problems where heavy cache
activity flushes out pages from the working set, while still
allowing the cache to put some pressure on the working set.

I've only done a few tests with this patch, reports on how
different workloads are handled are very much welcome:

http://www.surriel.com/patches/2.4/2.4.10-ac9-eatcache

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

