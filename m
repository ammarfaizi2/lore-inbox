Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADEa5>; Wed, 3 Jan 2001 23:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRADEar>; Wed, 3 Jan 2001 23:30:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:41477 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129324AbRADEa2>; Wed, 3 Jan 2001 23:30:28 -0500
Date: Thu, 4 Jan 2001 00:38:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bdflush synchronous IO on prerelease-diff 
In-Reply-To: <Pine.LNX.4.21.0101032241500.839-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101040016580.839-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Jan 2001, Marcelo Tosatti wrote:

> 
> Hi Linus, 
> 
> I've noticed you changed bdflush to do synchronous IO on page_launder().
> 
> That seems to be a performance problem, since kflushd will have to wait
> for dirty buffers to get synced instead looping on the inactive dirty
> list more often. 
> 
> Here is a patch to change this. 
> 
> --- linux.orig/fs/buffer.c      Wed Jan  3 22:43:24 2001
> +++ linux/fs/buffer.c   Thu Jan  4 00:28:50 2001
> @@ -2710,7 +2710,7 @@
>  
>                 flushed = flush_dirty_buffers(0);
>                 if (free_shortage())
> -                       flushed += page_launder(GFP_KERNEL, 1);
> +                       flushed += page_launder(GFP_KERNEL, 0);
>  
>                 /*
>                  * If there are still a lot of dirty buffers around,

And here are some dbench numbers:

12 clients / 64M ram
without the patch: 10.04 Mb/s  
with the patch: 14.47 Mb/s

48 clients / 256M ram 
without the patch: 14.40 Mb/s
with the patch: 15.69 Mb/s 




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
