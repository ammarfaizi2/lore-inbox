Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWGABPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWGABPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 21:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWGABPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 21:15:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932571AbWGABPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 21:15:51 -0400
Date: Fri, 30 Jun 2006 18:19:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: ltuikov@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
Message-Id: <20060630181915.638166c2.akpm@osdl.org>
In-Reply-To: <20060701010606.4694.qmail@web31809.mail.mud.yahoo.com>
References: <20060701010606.4694.qmail@web31809.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> wrote:
>
> It is 4 byte aligned anyway.

That's a 64-bitism.  And 32-bit machines are more space-sensitive.

>  This way we can use
> up to 19+1 chars.
> 
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> ---
>  include/linux/sched.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 18f12cb..3fc11bc 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -154,7 +154,7 @@ #define set_current_state(state_value)		
>  	set_mb(current->state, (state_value))
>  
>  /* Task command name length */
> -#define TASK_COMM_LEN 16
> +#define TASK_COMM_LEN 20

So this is basically "increase size of comm[] by 4 bytes, happens to be
zero-cost on 64-bit machines".

We do occasionally hit task_struct.comm[] truncation, when people use
"too-long-a-name%d" for their kernel thread names.  But we seem to manage.

