Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131204AbQL1SSL>; Thu, 28 Dec 2000 13:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131183AbQL1SSB>; Thu, 28 Dec 2000 13:18:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131141AbQL1SRu>; Thu, 28 Dec 2000 13:17:50 -0500
Date: Thu, 28 Dec 2000 09:47:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Dan Aloni <karrde@callisto.yi.org>, Zlatko Calusic <zlatko@iskon.hr>,
        "Marco d'Itri" <md@Linux.IT>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012281227570.14052-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10012280946020.12064-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Rik van Riel wrote:
> 
> I've made a small debugging patch that simply checks
> for this illegal state in add_page_to_active_list and
> add_page_to_inactive_dirty_list.

I bet it won't catch the real bad guy, which almost certainly is the
"remove_from_swap_cache()" thing (it should do a ClearPageDirty() before
it removes it from the swapper_inode mapping).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
