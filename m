Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132441AbQLJVlL>; Sun, 10 Dec 2000 16:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131251AbQLJVlB>; Sun, 10 Dec 2000 16:41:01 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:45070 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S130895AbQLJVkx>; Sun, 10 Dec 2000 16:40:53 -0500
Date: Sun, 10 Dec 2000 23:23:13 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.21.0012101708270.1350-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0012102258270.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Dec 2000, Tigran Aivazian wrote:

> problem (e.g. you mentioned something about allocating more than NR_FILES
> on SMP -- what do you mean?) which you are not explaining clearly.

E.g. situation, only one file struct left for allocation. One CPU goes
into get_empty_filp and before kmem_cache_alloc unlocks file_list,
another CPU gets also into get_empty_filp and locks file_list at the
top and goes on the same path, the end result potentially can be both
will increase nr_files instead of only one. But I don't think it's a
big issue at *present* that could cause any problems ...

> You just say "it is broken and here is the patch" but that, imho, is not
> enough. (ok, one could overcome the laziness and actually _read_ your
> patch to see what you _think_ is broken but surely it is better if you
> explain it yourself?).

Sorry I didn't explain, I thought it's short enough and significantly
faster to understand reading the code then my poor English ;)

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
