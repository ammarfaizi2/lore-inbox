Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbREWPj5>; Wed, 23 May 2001 11:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbREWPjr>; Wed, 23 May 2001 11:39:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3339 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263129AbREWPjf>; Wed, 23 May 2001 11:39:35 -0400
Date: Wed, 23 May 2001 12:39:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: write drop behind effect on active scanning 
In-Reply-To: <Pine.LNX.4.21.0105221910361.864-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0105231237510.311-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001, Marcelo Tosatti wrote:

> I just noticed a "bad" effect of write drop behind yesterday during some
> tests.
>
> The problem is that we deactivate written pages, thus making the inactive
> list become pretty big (full of unfreeable pages) under write intensive IO
> workloads.
>
> So what happens is that we don't do _any_ aging on the active list, and in
> the meantime the inactive list (which should have "easily" freeable
> pages) is full of locked pages.
>
> I'm going to fix this one by replacing "deactivate_page(page)" to
> "ClearPageReferenced(page)" in generic_file_write(). This way the written
> pages are aged faster but we avoid the bad effect just described.
>
> Any comments on the fix ?

1) I agree with it, drop-behind should make the pages we write
   very likely for eviction, but we don't want that to stop the
   eviction of other not-used pages ...

2) OTOH, if writeout of dirty pages is a problem for the system,
   I guess we will want to fix that problem somehow ;)
   (but that's another issue)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

