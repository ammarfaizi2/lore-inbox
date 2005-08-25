Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVHYImB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVHYImB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHYImB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:42:01 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12248 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964876AbVHYImA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:42:00 -0400
Date: Thu, 25 Aug 2005 10:41:27 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@www.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
In-Reply-To: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.62.0508251038360.28348@numbat.sonytel.be>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot, Al!

On Thu, 25 Aug 2005, Al Viro wrote:
> encapsulates the rest of arch-dependent operations with thread_info access.
> Two new helpers - setup_thread_info() and end_of_stack().  For normal
> case the former consists of copying thread_info of parent to new thread_info
> and the latter returns pointer immediately past the end of thread_info.
> 
> Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
> ----
> diff -urN RC13-rc7-task_thread_info/include/linux/sched.h RC13-rc7-other-helpers/include/linux/sched.h
> --- RC13-rc7-task_thread_info/include/linux/sched.h	2005-08-25 00:54:17.000000000 -0400
> +++ RC13-rc7-other-helpers/include/linux/sched.h	2005-08-25 00:54:17.000000000 -0400
> @@ -1138,6 +1138,16 @@
>  
>  #define task_thread_info(task) (task)->thread_info
>  
> +static inline void setup_thread_info(struct task_struct *p, struct thread_info *ti)
					^^^^^^^^^^^^^^^^^^^^^
					const struct task_struct *p?

> +{
> +	*ti = *p->thread_info;
> +}
> +
> +static inline unsigned long *end_of_stack(struct task_struct *p)
					     ^^^^^^^^^^^^^^^^^^^^^
					     const struct task_struct *p?

> +{
> +	return (unsigned long *)(p->thread_info + 1);
> +}
> +

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
