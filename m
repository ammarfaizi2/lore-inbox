Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273203AbRJEUDH>; Fri, 5 Oct 2001 16:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRJEUC5>; Fri, 5 Oct 2001 16:02:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22792 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274305AbRJEUCp>; Fri, 5 Oct 2001 16:02:45 -0400
Date: Fri, 5 Oct 2001 13:02:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: pre4 oom too soon
In-Reply-To: <Pine.LNX.4.21.0110051518110.2744-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0110051300010.2044-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Oct 2001, Marcelo Tosatti wrote:
>
> Note that a full kswapd_balance_pgdat() is going to scan only a small
> portion of the lists. I'm pretty sure we have to guarantee kswapd
> scanned at least all lists (maybe scanned all lists twice), before
> checking for OOM.

Why not just say "if we have swap cache pages, we aren't oom".

If we've scanned all lists twice, we should have unmapped all users of
swap-cache pages, and we should have dropped them.

And make the test be not quite black-and-white: we're almost always going
to have a _few_ swap-cache pages around under heavy memory load, if only
because of read-ahead etc that pins the pages. But if the swap cache is a
noticeable fraction of memory, we're obviously not oom _regardless_ of
what the VM balancers say.

		Linus

