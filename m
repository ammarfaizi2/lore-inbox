Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280958AbRKORc0>; Thu, 15 Nov 2001 12:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280959AbRKORcS>; Thu, 15 Nov 2001 12:32:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19208 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280958AbRKORb7>; Thu, 15 Nov 2001 12:31:59 -0500
Date: Thu, 15 Nov 2001 18:14:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [kernel] kiobuf question
Message-ID: <20011115181445.B1381@athlon.random>
In-Reply-To: <20011115093209.A3898@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011115093209.A3898@bytesex.org>; from kraxel@suse.de on Thu, Nov 15, 2001 at 09:32:09AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 09:32:09AM +0100, Gerd Knorr wrote:
>      83         if (PageLRU(page))
>      84                 BUG();			<<================

this is a VM bug, not a bttv bug.

One simple fix is to replace __free_page(page) in unmap_kiobuf with
page_cache_release(page). that will cure it.

But a better fix that I probably prefer for robusteness is to change in
page_alloc.c __free_pages with page_cache_release, so that we always do
this:

		if (PageLRU(page))
			lru_cache_del(page);

while freeing pages.

Andrea
