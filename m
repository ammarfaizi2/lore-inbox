Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWHBHbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWHBHbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWHBHbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:31:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932066AbWHBHbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:31:18 -0400
Date: Wed, 2 Aug 2006 00:31:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@sgi.com>
Cc: nagar@watson.ibm.com, jlan@sgi.com, linux-kernel@vger.kernel.org,
       balbir@in.ibm.com, csturtiv@sgi.com, tee@sgi.com
Subject: Re: [patch 3/3] convert CONFIG tag for a few accounting data used
 by CSA
Message-Id: <20060802003102.c8cb1a47.akpm@osdl.org>
In-Reply-To: <44D0538A.3090600@sgi.com>
References: <44CE58AF.7030200@sgi.com>
	<44CE6AE7.8020304@watson.ibm.com>
	<44D0538A.3090600@sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 09:26:02 +0200
Jes Sorensen <jes@sgi.com> wrote:

> Shailabh Nagar wrote:
> > Jay Lan wrote:
> >> There were a few accounting data/macros that are used in CSA
> >> but are #ifdef'ed inside CONFIG_BSD_PROCESS_ACCT. This patch is
> >> to change those ifdef's from CONFIG_BSD_PROCESS_ACCT to
> >> CONFIG_CSA_ACCT. A few defines are moved from kernel/acct.c and
> >> include/linux/acct.h to kernel/csa.c and include/linux/csa_kern.h.
> >>
> >>
> >> Signed-off-by:  Jay Lan <jlan@sgi.com>
> 
> [snip]
> 
> >> +#ifdef CONFIG_CSA_ACCT
> >> +extern void acct_update_integrals(struct task_struct *tsk);
> >> +extern void acct_clear_integrals(struct task_struct *tsk);
> >> +#else
> >> +#define acct_update_integrals(x)	do { } while (0)
> >> +#define acct_clear_integrals(task)	do { } while (0)
> >> +#endif
> >> +
> > 
> > static inlines preferred
> 
> Huh? Is that a preference to the taskstat project? For the kernel
> itself it makes no difference.

static inlines provide typechecking and typo checking and presence-of-x
checking when the option is configged off.  They can also suppress unused
variable warnings.

And they're C, not cpp ;)

