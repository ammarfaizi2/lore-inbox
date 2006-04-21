Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWDUARo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWDUARo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWDUARo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:17:44 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48126 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932171AbWDUARn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:17:43 -0400
Subject: Re: [PATCH] Rename "swapper" to "idle"
From: Steven Rostedt <rostedt@goodmis.org>
To: Hua Zhong <hzhong@gmail.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
In-Reply-To: <4448161D.9010109@gmail.com>
References: <4448161D.9010109@gmail.com>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 20:17:35 -0400
Message-Id: <1145578655.671.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 16:15 -0700, Hua Zhong wrote:
> This patch renames the "swapper" process (pid 0) to a more appropriate name "idle". The name "swapper" is not obviously meaningful and confuses a lot of people (e.g., when seen in oops report).
> 
> Patch not tested, but I guess it works. :-)

Usually a patch not tested will never be accepted no matter how trivial
it is, unless you had to modify a driver to match a new syntax or
something and you don't have the device.  Did you at least compile it?

> 
> Signed-off-by: Hua Zhong <hzhong@gmail.com>
> 
> diff --git a/include/linux/init_task.h b/include/linux/init_task.h
> index 41ecbb8..5e3ca4f 100644
> --- a/include/linux/init_task.h
> +++ b/include/linux/init_task.h
> @@ -108,7 +108,7 @@ #define INIT_TASK(tsk)      \
>         .cap_permitted  = CAP_FULL_SET,                                 \
>         .keep_capabilities = 0,                                         \
>         .user           = INIT_USER,                                    \
> -       .comm           = "swapper",                                    \
> +       .comm           = "idle",                                       \
>         .thread         = INIT_THREAD,                                  \
>         .fs             = &init_fs,                                     \
>         .files          = &init_files,                                  \
> -

Yes, swapper is because of historical reasons.  In most text books for
Unix, the initial process on boot up is called "swapper".  Probably
because those early Unix systems had this process handle the swapping
(as kswapd does today).

By doing this, it will probably make Linux out of sync with all the text
books on Unix, so it really is Linus' call.

-- Steve


