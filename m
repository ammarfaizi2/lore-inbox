Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263100AbREWOcz>; Wed, 23 May 2001 10:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263103AbREWOcp>; Wed, 23 May 2001 10:32:45 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:31249 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263100AbREWOc3>; Wed, 23 May 2001 10:32:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: write drop behind effect on active scanning
Date: Wed, 23 May 2001 16:33:44 +0200
X-Mailer: KMail [version 1.2]
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.21.0105221910361.864-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0105221910361.864-100000@freak.distro.conectiva>
MIME-Version: 1.0
Message-Id: <0105231633440L.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 May 2001 09:33, Marcelo Tosatti wrote:
> Hi,
>
> I just noticed a "bad" effect of write drop behind yesterday during
> some tests.
>
> The problem is that we deactivate written pages, thus making the
> inactive list become pretty big (full of unfreeable pages) under
> write intensive IO workloads.
>
> So what happens is that we don't do _any_ aging on the active list,
> and in the meantime the inactive list (which should have "easily"
> freeable pages) is full of locked pages.
>
> I'm going to fix this one by replacing "deactivate_page(page)" to
> "ClearPageReferenced(page)" in generic_file_write(). This way the
> written pages are aged faster but we avoid the bad effect just
> described.
>
> Any comments on the fix ?

  page->age = 0 ?

--
Daniel
