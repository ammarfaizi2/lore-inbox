Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRLDQo1>; Tue, 4 Dec 2001 11:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281047AbRLDQn6>; Tue, 4 Dec 2001 11:43:58 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:25353 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281129AbRLDQmv>;
	Tue, 4 Dec 2001 11:42:51 -0500
Date: Tue, 4 Dec 2001 14:42:28 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Peter Zaitsev <pz@spylog.ru>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <theowl@freemail.c3.hu>, <theowl@freemail.hu>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re[2]: your mail on mmap() to the kernel list
In-Reply-To: <16498470022.20011204183624@spylog.ru>
Message-ID: <Pine.LNX.4.33L.0112041439210.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, Peter Zaitsev wrote:
> Tuesday, December 04, 2001, 5:15:49 PM, you wrote:

> AA> You can fix the problem in userspace by using a meaningful 'addr' as
> AA> hint to mmap(2), or by using MAP_FIXED from userspace, then the kernel
> AA> won't waste time searching the first available mapping over
> AA> TASK_UNMAPPED_BASE.

> Well. Really you can't do this, because you can not really track all of
> the mappings in user program as glibc and probably other libraries
> use mmap for their purposes.

There's no reason we couldn't do this hint in kernel space.

In arch_get_unmapped_area we can simply keep track of the
lowest address where we found free space, while on munmap()
we can adjust this hint if needed.

OTOH, I doubt it would help real-world workloads where the
application maps and unmaps areas of different sizes and
actually does something with the memory instead of just
mapping and unmapping it ;)))

kind regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/


