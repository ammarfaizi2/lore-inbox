Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFBRcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFBRcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 13:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVFBRcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 13:32:05 -0400
Received: from ns.suse.de ([195.135.220.2]:54154 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261207AbVFBRb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 13:31:59 -0400
Date: Thu, 2 Jun 2005 19:31:58 +0200
From: Andi Kleen <ak@suse.de>
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Vara Prasad <prasadav@us.ibm.com>, Hien Nguyen <hien@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch] x86_64 specific function return probes
Message-ID: <20050602173158.GJ23831@wotan.suse.de>
References: <200506021609.j52G99Ft023464@linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506021609.j52G99Ft023464@linux.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 09:09:09AM -0700, Rusty Lynch wrote:
> The following patch adds the x86_64 architecture specific implementation
> for function return probes to the 2.6.12-rc5-mm2 kernel. 

This is not a sufficient description for a patch. Can you describe
how it actually works and what it does? 

> + * Called when we hit the probe point at kretprobe_trampoline
> + */
> +int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
> +{
> +	struct task_struct *tsk;
> +	struct kretprobe_instance *ri;
> +	struct hlist_head *head;
> +	struct hlist_node *node;
> +	unsigned long *sara = (unsigned long *)regs->rsp - 1;
> +
> +	tsk = arch_get_kprobe_task(sara);

I dont think you handle the case of the exception happening on 
a exception or interrupt stack. This is broken.

-Andi
