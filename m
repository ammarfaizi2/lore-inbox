Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTI2QvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTI2QvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:51:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:62444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263763AbTI2QvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:51:12 -0400
Date: Mon, 29 Sep 2003 09:50:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat sparse fixes
In-Reply-To: <UTC200309282329.h8SNT5I29917.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0309290946070.23520-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Sep 2003 Andries.Brouwer@cwi.nl wrote:
>
> --- a/fs/fat/dir.c	Mon Sep 29 01:05:41 2003
> +++ b/fs/fat/dir.c	Mon Sep 29 01:11:39 2003
> @@ -630,7 +630,7 @@
>  		    put_user(slen, &d1->d_reclen))
>  			goto efault;
>  	} else {
> -		if (put_user(0, d2->d_name)			||
> +		if (put_user(0, d2->d_name+0)			||
>  		    put_user(0, &d2->d_reclen)			||
>  		    copy_to_user(d1->d_name, name, len)		||
>  		    put_user(0, d1->d_name+len)			||

The above seems to just work around a sparse bug. Please don't - I'd 
rather have regular code and try to fix the sparse problem.

Hmm.. I wonder why sparse doesn't get the address space right on arrays. 
It should see that "d2" is a user pointer , so d2->d_name is one too.

It gets it right if you add the "+0", or if you add a "&" in front. So 
it looks like the sparse array->pointer degeneration misses something.

		Linus

