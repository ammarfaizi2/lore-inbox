Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262269AbREZAbY>; Fri, 25 May 2001 20:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262268AbREZAbI>; Fri, 25 May 2001 20:31:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:7688 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262265AbREZAat>; Fri, 25 May 2001 20:30:49 -0400
Date: Fri, 25 May 2001 17:30:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.33.0105252124470.10469-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0105251728530.1105-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 May 2001, Rik van Riel wrote:
>
> The function do_try_to_free_pages() also gets called when we're
> only short on inactive pages, but we still have TONS of free
> memory. In that case, I don't think we'd actually want to steal
> free memory from anyone.

Well, kmem_cache_reap() doesn't even steal memory from anybody: it just
makes this "tagged for xxx" memory be available to "non-xxx" users too.

And the fact that we're calling do_try_to_free_pages() at all obviously
implies that even if we have memory free, it isn't in the right hands..

		Linus

