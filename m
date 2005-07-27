Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVG0XS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVG0XS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVG0XQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:16:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261214AbVG0XOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:14:20 -0400
Date: Wed, 27 Jul 2005 16:13:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-Id: <20050727161316.0593d762.akpm@osdl.org>
In-Reply-To: <200507272207.j6RM7fg18695@unix-os.sc.intel.com>
References: <200507272207.j6RM7fg18695@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> +#ifdef ARCH_HAS_PREFETCH_SWITCH_STACK
>  +extern void prefetch_switch_stack(struct task_struct*);
>  +#else
>  +#define prefetch_switch_stack(task)	do { } while (0)
>  +#endif

It is better to use

static inline void prefetch_switch_stack(struct task_struct *t) { }

in the second case, rather than a macro.  It provides typechecking.
