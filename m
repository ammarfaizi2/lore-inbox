Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSLMQ11>; Fri, 13 Dec 2002 11:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSLMQ11>; Fri, 13 Dec 2002 11:27:27 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:5760 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S265096AbSLMQ10>;
	Fri, 13 Dec 2002 11:27:26 -0500
Message-ID: <3DFA0C20.3020000@walrond.org>
Date: Fri, 13 Dec 2002 16:34:40 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Antill <james@and.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <Pine.LNX.3.95.1021213102838.2190B-100000@chaos.analogic.com> <m3bs3pao5m.fsf@code.and.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James.

Thanks for the info; my application is now entirely plausible :)
And apologies for asking an FAQ. (Google didn't throw up anything useful)

BTW is documented anywhere except the code?

Andrew

> 
>  The link count is for recursively following symlinks, as the original
> question wanted to know ... and has been discussed on lkml numerous
> times.
> 
>  Andrew, one extra piece of information you might not know is that the
> above value doesn't come into play when the new symlink is the last
> element in the new path, then you get a higher value.
>  The full code...
> 
>         if (current->link_count >= max_recursive_link)
>                 goto loop;
>         if (current->total_link_count >= 40)
>                 goto loop;
> [...]
>         current->link_count++;
>         current->total_link_count++;
>         UPDATE_ATIME(dentry->d_inode);
>         err = dentry->d_inode->i_op->follow_link(dentry, nd);
>         current->link_count--;
> 
> ...Ie. a link from /a -> /b/c where "b" is a symlink takes the
> "max_recursive_link" value (5 on vanilla kernels) but if "/b/c" was a
> symlink then you get to use the 40 value.
> 


