Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135785AbRAHSBf>; Mon, 8 Jan 2001 13:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135990AbRAHSBP>; Mon, 8 Jan 2001 13:01:15 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:41972 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S135785AbRAHSBI>; Mon, 8 Jan 2001 13:01:08 -0500
Date: Mon, 8 Jan 2001 16:00:45 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "Sergey E. Volkov" <sve@raiden.bancorp.ru>
cc: linux-kernel@vger.kernel.org, Christoph Rohland <cr@sap.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <3A597E77.FF3011DD@raiden.bancorp.ru>
Message-ID: <Pine.LNX.4.21.0101081550590.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Sergey E. Volkov wrote:

> I have a problem with 2.4.0
> 
> I'm testing Informix IIF-2000 database server running on dual
> Intel Pentium II - 233. When I run 'make -j30 bzImage' in the
> kernel source, my Linux box hangs without any messages.

> Informix allocate about to 50% of memory as LOCKED shared memory
> segments.  I'm thinking the reason in this. Kernel wants, but
> can't to swap out locked shm's segments.

You are right. I have seen this bug before with the kernel
moving unswappable pages from the active list to the
inactive_dirty list and back.

We need a check in deactivate_page() to prevent the kernel
from moving pages from locked shared memory segments to the
inactive_dirty list.

Christoph?  Linus?

regards,

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
