Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129437AbQLILBm>; Sat, 9 Dec 2000 06:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbQLILBb>; Sat, 9 Dec 2000 06:01:31 -0500
Received: from isolaweb.it ([213.82.132.2]:62471 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S129437AbQLILBS>;
	Sat, 9 Dec 2000 06:01:18 -0500
Message-Id: <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 09 Dec 2000 11:25:09 +0100
To: Rasmus Andersen <rasmus@jaquet.dk>, torvalds@transmeta.com
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001208212910.E599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21.29 08/12/00 +0100, Rasmus Andersen wrote:

>Hi.
>
>The following patch moves the page_table_lock in mm/* to cover the
>modification of mm->rss in 240-test12-pre7. It was inspired by a
>similar patch from davej(?) which covered too much, AFAIR. The item
>is on Tytso's ToDo list.

[...snip...]

>@@ -1076,7 +1076,9 @@
>                 flush_icache_page(vma, page);
>         }
>
>+       spin_lock(&mm->page_table_lock);
>         mm->rss++;
>+       spin_unlock(&mm->page_table_lock);
>

[...snip...]

Why we couldn't use atomic_inc(&mm->rss) here and below, avoiding to wrap
the inc with a spin_lock()/spin_unlock() ?



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
