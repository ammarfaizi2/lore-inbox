Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131415AbQLIMO1>; Sat, 9 Dec 2000 07:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131530AbQLIMOR>; Sat, 9 Dec 2000 07:14:17 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:50798
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131415AbQLIMOG>; Sat, 9 Dec 2000 07:14:06 -0500
Date: Sat, 9 Dec 2000 13:43:27 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
Message-ID: <20001209134327.C599@jaquet.dk>
In-Reply-To: <20001208212910.E599@jaquet.dk> <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>; from kernel@tekno-soft.it on Sat, Dec 09, 2000 at 11:25:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 11:25:09AM +0100, Roberto Fichera wrote:
[...]
> >+       spin_lock(&mm->page_table_lock);
> >         mm->rss++;
> >+       spin_unlock(&mm->page_table_lock);
> >
> 
> [...snip...]
> 
> Why we couldn't use atomic_inc(&mm->rss) here and below, avoiding to wrap
> the inc with a spin_lock()/spin_unlock() ?
> 

AFAIR, because for some architectures we can't rely on mm->rss fitting in
an atomic_t. See davem's (somewhat short) post in this thread. Otherwise
search the archives for the original thread treating this problem.
-- 
        Rasmus(rasmus@jaquet.dk)

Television is called a medium because it is neither rare nor well-done. 
  -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
