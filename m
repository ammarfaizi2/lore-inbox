Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268514AbTGRPMh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271785AbTGRPJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:09:57 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:37592 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271847AbTGRPHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:07:34 -0400
Date: Fri, 18 Jul 2003 17:22:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-ID: <20030718152205.GA407@elf.ucw.cz>
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz> <20030717130906.0717b30d.akpm@osdl.org> <m2d6g8cg06.fsf@telia.com> <20030718032433.4b6b9281.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718032433.4b6b9281.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If this patch is an acceptable approach to fix the problem,
> 
> Seems reasonable.
> 
> > the balance_pgdat function should probably be cleaned up.
> 
> Well it was rather bolted on the side of the kswapd code.  But from an API
> perspective, being able to tell it how many page to free is a bit more
> flexible.  Minor point.
> 
> However I'm trying to remember why the code exists at all.  Why doesn't
> swsusp just allocate lots of pages then free them again?

Because that either

a) does not free enough pages or

b) triggers OOM killer.

It was actually your idea, IIRC ;-).

Ahha, you seem to be addressing that in your code. Peter, perhaps you
want to test that one?
								Pavel


> Something like:
> 
> 	LIST_HEAD(list);
> 	int sleep_count = 0;
> 
> 	while (sleep_count < 10) {
> 		page = __alloc_pages(0, GFP_ATOMIC);
> 		if (page) {
> 			list_add(&page->list, &list);
> 		} else {
> 			blk_congestion_wait(WRITE, HZ/20);
> 			sleep_count++;
> 		}
> 	}
> 	<free all the pages on `list'>

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
