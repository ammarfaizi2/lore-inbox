Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKPVo7>; Thu, 16 Nov 2000 16:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129591AbQKPVoj>; Thu, 16 Nov 2000 16:44:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:49928 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129069AbQKPVod>; Thu, 16 Nov 2000 16:44:33 -0500
Date: Thu, 16 Nov 2000 13:14:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dan Aloni <karrde@callisto.yi.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
In-Reply-To: <Pine.LNX.4.21.0011162237040.16415-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.10.10011161313060.2661-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Dan Aloni wrote:
> 
> Makes procfs use an atomic use count for dir entries, to avoid using 
> the Big kernel lock. Axboe says it looks ok.

There's a race there. Look at what happens if de_put() races with
remove_proc_entry(): we'd do free_proc_entry() twice. Not good.

Leave the kernel lock for now.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
