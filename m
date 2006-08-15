Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752092AbWHODsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbWHODsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbWHODsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:48:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752092AbWHODsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:48:20 -0400
Date: Mon, 14 Aug 2006 20:48:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop second arg of unregister_chrdev()
Message-Id: <20060814204817.d9365586.akpm@osdl.org>
In-Reply-To: <20060815033522.GA5163@martell.zuzino.mipt.ru>
References: <20060815033522.GA5163@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 07:35:22 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> * "name" is trivially unused.

OK.

> * Requirement to pass to unregister function anything but cookie you've
>   got from register counterpart is wrong. It creates opportunity to
>   diverge, it create opportunity for bugs if enforced:
> 
> 	/*
> 	 * XXX(hch): bp->b_count_desired might be incorrect (see
> 	 * xfs_buf_associate_memory for details),
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> 	 *                                        but fortunately
> 	 * the Linux version of kmem_free ignores the len argument..
> 	 */
> 	 kmem_free(bp->b_addr, bp->b_count_desired);

I don't understand that.

>  64 files changed, 97 insertions(+), 97 deletions(-)

I do understand that.  This'll cause some grief.  I'd suggest that we add a
new unregister_char_dev() or something, and do

static inline unregister_chrdev(unsigned int major, const char *name)
{
	return unregister_char_dev(major);
}

then migrate callers over to unregister_char_dev() in an organised fashion,
via maintainers where poss.

Then mark unregister_chrdev() deprecated for a while.

Then nuke it.

