Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVDGVtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVDGVtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVDGVtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:49:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30216 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262567AbVDGVrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:47:49 -0400
Date: Thu, 7 Apr 2005 23:47:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Message-ID: <20050407214747.GD4325@stusta.de>
References: <4252BC37.8030306@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4252BC37.8030306@grupopie.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 05:26:31PM +0100, Paulo Marques wrote:
> 
> Hi,

Hi Paulo,

> I noticed there are a number of places in the kernel that do:
> 
> 	ptr = kmalloc(n * size, ...)
> 	if (!ptr)
> 		goto out;
> 	memset(ptr, 0, n * size);
> 
> It seems that these could be replaced by:
> 
> 	ptr = kcalloc(n, size, ...)
> 	if (!ptr)
> 		goto out;
> 
> saving a few bytes.
>...
> A quick (and lame) grep through the tree shows about 1200 of these 
>cases. This means that about one quarter of all the kmallocs in the 
>kernel are actually zeroed right after allocation.
>...
> pros:
>   - smaller kernel image size
>   - smaller (and more readable) source code
>...

Which is better readable depends on what you are used to.

> cons:
>   - the NULL test is done twice
>   - memset will not be optimized for constant sizes
>...
> Would this be a good thing to clean up, or isn't it worth the effort at all?
>...

You do plan to patch 1200 places in the kernel for this 
micro-optimization? 

This sounds like a really big overhead for a pretty small gain.

There are tasks of higher value that can be done.

E.g. read my "Stack usage tasks" email. The benefits would only be 
present for people using GNU gcc 3.4 or SuSE gcc 3.3 on i386, but this 
is a reasonable subset of the kernel users - and it brings them a
2% kernel size improvement.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

