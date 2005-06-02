Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVFBXIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVFBXIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVFBW7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:59:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:46789 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbVFBWrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:47:41 -0400
Date: Thu, 2 Jun 2005 15:48:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, ak@suse.de, nanhai.zou@intel.com,
       rohit.seth@intel.com, rajesh.shah@intel.com
Subject: Re: [Patch] x86_64: TASK_SIZE fixes for compatibility mode
 processes
Message-Id: <20050602154823.15141bfc.akpm@osdl.org>
In-Reply-To: <20050602151912.B14384@unix-os.sc.intel.com>
References: <20050602133256.A14384@unix-os.sc.intel.com>
	<20050602135013.4cba3ae2.akpm@osdl.org>
	<20050602151912.B14384@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> On Thu, Jun 02, 2005 at 01:50:13PM -0700, Andrew Morton wrote:
> > "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> > >
> > > +#define TASK_SIZE_OF(child) 	((test_tsk_thread_flag(child, TIF_IA32)) ? IA32_PAGE_OFFSET : TASK_SIZE64)
> > 
> > The task size is an attribute of the task's mm_struct, not of the task.
> 
> ia64, ppc64 and s390 seems be getting this info from thread_info or 
> thread_struct in the task struct.

I know.  I'm claiming that this is conceptually wrong.

> > The place where this tends to come unstuck is when a 32-bit task holds a
> > reference on a 64-bit tasks's task_struct via a read of a /proc file.  If
> > the 64-bit task exits then it is the 32-bit task who does the final freeing
> > of the 64-bit tasks's task_struct and mm_struct.  (and all vice-versa, of
> > course).  Will your patch handle this race scenario correctly?
> 
> In recent kernels, instead of TASK_SIZE, "-1" is getting passed to unmap_vmas()
> from exit_mmap. Same case with ceiling (set to "0") for free_pgtables().
> It shouldn't be a problem with this, right?

Yeah, I recall that hack being added.  Might work.
