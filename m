Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130555AbQL1Pno>; Thu, 28 Dec 2000 10:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbQL1Pnf>; Thu, 28 Dec 2000 10:43:35 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:39669 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130555AbQL1PnR>; Thu, 28 Dec 2000 10:43:17 -0500
Date: Thu, 28 Dec 2000 13:12:37 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Phillips <phillips@innominate.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <3A4B563C.DAE31010@innominate.de>
Message-ID: <Pine.LNX.4.21.0012281310530.14052-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Daniel Phillips wrote:

> It's logical that PageDirty should never be get for ramfs,

No. Not setting PageDirty will cause the system to move the
page to the inactive_clean list and happily reclaim your data.

We _have to_ use something like PageDirty for this, and
checking for the ->writepage method will even allow us to
do stuff like dynamically switching swapping support for
ramfs on/off (or other funny things).

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
