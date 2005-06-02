Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVFBWTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVFBWTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVFBWTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:19:32 -0400
Received: from fmr22.intel.com ([143.183.121.14]:54502 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261437AbVFBWTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:19:23 -0400
Date: Thu, 2 Jun 2005 15:19:13 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, ak@suse.de, nanhai.zou@intel.com,
       rohit.seth@intel.com, rajesh.shah@intel.com
Subject: Re: [Patch] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050602151912.B14384@unix-os.sc.intel.com>
References: <20050602133256.A14384@unix-os.sc.intel.com> <20050602135013.4cba3ae2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050602135013.4cba3ae2.akpm@osdl.org>; from akpm@osdl.org on Thu, Jun 02, 2005 at 01:50:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 01:50:13PM -0700, Andrew Morton wrote:
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> >
> > +#define TASK_SIZE_OF(child) 	((test_tsk_thread_flag(child, TIF_IA32)) ? IA32_PAGE_OFFSET : TASK_SIZE64)
> 
> The task size is an attribute of the task's mm_struct, not of the task.

ia64, ppc64 and s390 seems be getting this info from thread_info or 
thread_struct in the task struct.

> The place where this tends to come unstuck is when a 32-bit task holds a
> reference on a 64-bit tasks's task_struct via a read of a /proc file.  If
> the 64-bit task exits then it is the 32-bit task who does the final freeing
> of the 64-bit tasks's task_struct and mm_struct.  (and all vice-versa, of
> course).  Will your patch handle this race scenario correctly?

In recent kernels, instead of TASK_SIZE, "-1" is getting passed to unmap_vmas()
from exit_mmap. Same case with ceiling (set to "0") for free_pgtables().
It shouldn't be a problem with this, right?

thanks,
suresh
