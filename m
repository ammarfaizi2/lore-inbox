Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFCPpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFCPpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVFCPpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:45:23 -0400
Received: from mail.suse.de ([195.135.220.2]:30637 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261336AbVFCPpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:45:17 -0400
Date: Fri, 3 Jun 2005 17:45:16 +0200
From: Andi Kleen <ak@suse.de>
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Vara Prasad <prasadav@us.ibm.com>, Hien Nguyen <hien@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch] x86_64 specific function return probes
Message-ID: <20050603154516.GM23831@wotan.suse.de>
References: <200506022058.j52KwokR030613@linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506022058.j52KwokR030613@linux.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 01:58:50PM -0700, Rusty Lynch wrote:
> The following patch adds the x86_64 architecture specific implementation

[....]

Thanks for the long description.

but...

> +struct task_struct  *arch_get_kprobe_task(void *ptr)
> +{
> +	return ((struct thread_info *) (((unsigned long) ptr) &
> +					(~(THREAD_SIZE -1))))->task;
> +}

and


> +	tsk = arch_get_kprobe_task(sara);


This is still wrong when the code is not executing on the process
stack, but on a interrupt/Exception stack. Any reason you cannot
just use current here?

-Andi
