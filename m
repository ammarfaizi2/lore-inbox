Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUDRNuF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 09:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264167AbUDRNuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 09:50:05 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:39698 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S264160AbUDRNuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 09:50:01 -0400
Date: Sun, 18 Apr 2004 14:49:58 +0100 (BST)
From: chris@scary.beasts.org
X-X-Sender: cevans@sphinx.mythic-beasts.com
To: Linus Torvalds <torvalds@osdl.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Nasty 2.6 sendfile() bug / regression; affects vsftpd
In-Reply-To: <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0404181447270.5600@sphinx.mythic-beasts.com>
References: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com>
 <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Apr 2004, Linus Torvalds wrote:

> Your patch is horribly ugly. How about this (much simpler) patch instead?

Hey, it's a guaranteed way to get your attention ;-)

> Can you test that this one-liner fixes the issue for you?

It certainly does.

Cheers
Chris

> ----
> --- 1.37/fs/read_write.c	Mon Apr 12 10:54:20 2004
> +++ edited/fs/read_write.c	Sat Apr 17 20:09:41 2004
> @@ -635,7 +635,7 @@
>  		return ret;
>  	}
>
> -	return do_sendfile(out_fd, in_fd, NULL, count, MAX_NON_LFS);
> +	return do_sendfile(out_fd, in_fd, NULL, count, 0);
>  }
>
>  asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t __user *offset, size_t count)
>
