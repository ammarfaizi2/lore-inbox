Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132239AbRCVXUB>; Thu, 22 Mar 2001 18:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132240AbRCVXTt>; Thu, 22 Mar 2001 18:19:49 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:15883 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132239AbRCVXTg>; Thu, 22 Mar 2001 18:19:36 -0500
Date: Thu, 22 Mar 2001 20:16:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Richard Jerrell <jerrell@missioncriticallinux.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
In-Reply-To: <Pine.LNX.4.21.0103221716460.20061-200000@jerrell.lowell.mclinux.com>
Message-ID: <Pine.LNX.4.33.0103222014510.24040-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0102151740301.1390@jerrell.lowell.mclinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Richard Jerrell wrote:

> 2.4.1 has a memory leak (temporary) where anonymous memory pages
> that have been moved into the swap cache will stick around after
> their vma has been unmapped by the owning process.

> free_pte in mm/memory.c has been modified to check to see if the
> page is only being referenced by the swap cache

Your idea is nice, but the patch lacks a few things:

- SMP locking, what if some other process faults in this page
  between the atomic_read of the page count and the test later?
- testing if our process is the _only_ user of this swap page,
  for eg. apache you'll have lots of COW-shared pages .. it would
  be good to keep the page in memory for our siblings

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

