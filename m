Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269900AbUJGXHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269900AbUJGXHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269897AbUJGXGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:06:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:2515 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269891AbUJGXFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:05:10 -0400
Date: Thu, 7 Oct 2004 16:08:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ian Campbell <icampbell@arcom.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] trivial fix for warning in kernel/power/console.c
Message-Id: <20041007160858.0708e968.akpm@osdl.org>
In-Reply-To: <1097157857.5231.10.camel@icampbell-debian>
References: <1097157857.5231.10.camel@icampbell-debian>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell <icampbell@arcom.com> wrote:
>
> orig_fgconsole and orig_kmsg are only used in kernel/power/console.c if 
> SUSPEND_CONSOLE is defined.
> 
> Signed-off-by: Ian Campbell <icampbell@arcom.com>
> 
> Index: 2.6-bk/kernel/power/console.c
> ===================================================================
> --- 2.6-bk.orig/kernel/power/console.c	2004-10-07 14:47:25.764724497 +0100
> +++ 2.6-bk/kernel/power/console.c	2004-10-07 14:47:54.241016791 +0100
> @@ -11,7 +11,9 @@
>  
>  static int new_loglevel = 10;
>  static int orig_loglevel;
> +#ifdef SUSPEND_CONSOLE
>  static int orig_fgconsole, orig_kmsg;
> +#endif

Not only that, orig_kmsg is assigned to but never read from.


