Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRBMDzP>; Mon, 12 Feb 2001 22:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRBMDzG>; Mon, 12 Feb 2001 22:55:06 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:5128 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129216AbRBMDyt>; Mon, 12 Feb 2001 22:54:49 -0500
Date: Tue, 13 Feb 2001 00:05:50 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: george anzinger <george@mvista.com>
cc: Rasmus Andersen <rasmus@jaquet.dk>, Rik van Riel <riel@conectiva.com.br>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11)
In-Reply-To: <3A88A6ED.6B51BCA9@mvista.com>
Message-ID: <Pine.LNX.4.21.0102122334240.29855-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Feb 2001, george anzinger wrote:

> Excuse me if I am off base here, but wouldn't an atomic operation be
> better here.  There are atomic inc/dec and add/sub macros for this.  It
> just seems that that is all that is needed here (from inspection of the
> patch).

Most functions which touch mm->rss already hold mm->page_table_lock (also
this functions are called more often and they use more CPU).

Making those functions use an atomic instruction just to optimize the
functions which do not lock mm->page_table_lock is not a good tradeoff.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
