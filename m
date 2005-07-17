Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVGQUWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVGQUWv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVGQUWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:22:51 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:6441 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261386AbVGQUWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:22:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jJC/635dk//cXA7orr7H1ydXVncl7Tobh9TRGT9FuN25qfp6eyqUQEUOO7MJ6EDkDfLfuMUEp8KOaYThFtm7224MSuexkA7JRjHDixUQ8jDJpXm8Oc/DqHj7jY08kxSU/BvFZtT2qQbSWzrUGzi4TlrVUi8PtU+OCfAWmQNy92A=
Message-ID: <9e473391050717132233347d25@mail.gmail.com>
Date: Sun, 17 Jul 2005 16:22:50 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <200507172043.41473.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507172043.41473.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Resource freeing functions should generally be safe to call with NULL pointers.
> Why?
>  - there is some precedence in the kernel for this for deallocation functions.
>  - removes the need for callers to check pointers for NULL.
>  - space is saved overall by less code to test pointers for NULL all over the place.
>  - removes possible NULL pointer dereferences when a caller forgot to check.
> 
> This patch makes  fb_dealloc_cmap()  safe to call with a NULL pointer argument.

The fb cmap copde would be a lot simpler if it did everything with a
single allocation instead of five. Make a super cmap struct:

struct fb_super_cmap {
   struct fb_cmap cmap;
   __u16 red[255];
   __u16 blue[255];
   __u16 green[255];
   __u16 transp[255];
}

Then adjust the code as need. Have the embedded cmap struct point to
the fields in the super_cmap and the drivers don't have to be changed.




-- 
Jon Smirl
jonsmirl@gmail.com
