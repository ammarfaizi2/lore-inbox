Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270680AbTHFG1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 02:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274878AbTHFG1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 02:27:39 -0400
Received: from soft.uni-linz.ac.at ([140.78.95.99]:12465 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S270680AbTHFG1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 02:27:38 -0400
Message-ID: <3F309FD8.8090105@gibraltar.at>
Date: Wed, 06 Aug 2003 08:27:36 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-at, de-de, en-gb, en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jason Baron <jbaron@redhat.com>
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
References: <Pine.LNX.4.44.0308051506570.26542-100000@dhcp64-178.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0308051506570.26542-100000@dhcp64-178.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The problem with pivot_root that appeared in 2.4.21-ac4 and the 
2.4.22-pre kernels is now solved (at least for my case) by applying the 
trvial patch sent by Jason Baron.

Jason Baron wrote:
> right. so the semantics of how file tables are shared has changed a bit. I
> would think that for at least 'init', it'd be nice to preserve the
> original behavior, for situations such as you described. Something like
> the following would probably work, although i havent' tried the test
> script.
> 
> --- linux/kernel/fork.c.orig  2003-07-23 21:34:59.000000000 -0400
> +++ linux/kernel/fork.c       2003-07-23 21:35:45.000000000 -0400
> @@ -558,7 +558,7 @@ int unshare_files(void)
>  
>         /* This can race but the race causes us to copy when we don't
>            need to and drop the copy */
> -       if(atomic_read(&files->count) == 1)
> +       if(atomic_read(&files->count) == 1 || (current->pid == 1))
>         {
>                 atomic_inc(&files->count);
>                 return 0;
>    



I tried that on my system and it works as expected. The kernel processes
close their fds and the old root fs can thus be unmounted after
pivot_root. Thanks for the hint !
So the problem is solved for me and it would be wonderful to get it into
2.4.22.

best regards,
Rene

