Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbTLVWNn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264599AbTLVWNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:13:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:24469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264600AbTLVWNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:13:38 -0500
Date: Mon, 22 Dec 2003 14:14:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rob Love <rml@ximian.com>
Cc: joe.korty@ccur.com, wli@holomorphy.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: atomic copy_from_user?
Message-Id: <20031222141431.111e7611.akpm@osdl.org>
In-Reply-To: <1072126506.3318.31.camel@fur>
References: <1072054100.1742.156.camel@cube>
	<20031222150026.GD27687@holomorphy.com>
	<20031222182637.GA2659@rudolph.ccur.com>
	<1072126506.3318.31.camel@fur>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Love <rml@ximian.com> wrote:
>
> Actually, dec_preempt_count() ought to call preempt_check_resched()
> itself.  In the case of !CONFIG_PREEMPT, that call would simply optimize
> away.
> 
> Attached patch is against 2.6.0.
> 
> 	Rob Love
> 
> 
>  linux/preempt.h |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -urN include/linux/preempt.h.orig include/linux/preempt.h
> --- include/linux/preempt.h.orig	2003-12-22 15:53:11.329113296 -0500
> +++ include/linux/preempt.h	2003-12-22 15:53:51.314034664 -0500
> @@ -18,6 +18,7 @@
>  #define dec_preempt_count() \
>  do { \
>  	preempt_count()--; \
> +	preempt_check_resched(); \
>  } while (0)

But preempt_enable_no_resched() calls dec_preempt_count().
