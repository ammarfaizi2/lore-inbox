Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbQKPWBj>; Thu, 16 Nov 2000 17:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130753AbQKPWB3>; Thu, 16 Nov 2000 17:01:29 -0500
Received: from [213.8.185.152] ([213.8.185.152]:45583 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129222AbQKPWBZ>;
	Thu, 16 Nov 2000 17:01:25 -0500
Date: Thu, 16 Nov 2000 23:31:00 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
In-Reply-To: <Pine.LNX.4.10.10011161313060.2661-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011162320230.17038-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Linus Torvalds wrote:

> On Thu, 16 Nov 2000, Dan Aloni wrote:
> > 
> > Makes procfs use an atomic use count for dir entries, to avoid using 
> > the Big kernel lock. Axboe says it looks ok.
> 
> There's a race there. Look at what happens if de_put() races with
> remove_proc_entry(): we'd do free_proc_entry() twice. Not good.
> 
> Leave the kernel lock for now.

Is this particular kernel lock helps anyway? We could have been half way
through remove_proc_entry(), line 569, for example, while in the same time
another thread enters de_put when the use count is 1 and frees the entry
while the other thread is locked just before dereferencing the entry.

So, maybe a spinlock could be used here?

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
