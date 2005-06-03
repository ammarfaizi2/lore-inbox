Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFCFIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFCFIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFCFIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:08:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:49070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbVFCFIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:08:19 -0400
Date: Thu, 2 Jun 2005 22:07:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Lynch, Rusty" <rusty.lynch@intel.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, prasadav@us.ibm.com,
       hien@us.ibm.com, prasanna@in.ibm.com, jkenisto@us.ibm.com
Subject: Re: [patch] x86_64 specific function return probes
Message-Id: <20050602220729.762d9385.akpm@osdl.org>
In-Reply-To: <032EB457B9DBC540BFB1B7B519C78B0E07499229@orsmsx404.amr.corp.intel.com>
References: <032EB457B9DBC540BFB1B7B519C78B0E07499229@orsmsx404.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lynch, Rusty" <rusty.lynch@intel.com> wrote:
>
> 
> From: Andi Kleen [mailto:ak@suse.de]
> >On Thu, Jun 02, 2005 at 09:09:09AM -0700, Rusty Lynch wrote:
> >> The following patch adds the x86_64 architecture specific
> implementation
> >> for function return probes to the 2.6.12-rc5-mm2 kernel.
> >
> >This is not a sufficient description for a patch. Can you describe
> >how it actually works and what it does?
> >
> 
> Ok, let me write up a description and I'll repost.

You did, but:

> >> + * Called when we hit the probe point at kretprobe_trampoline
> >> + */
> >> +int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
> >> +{
> >> +	struct task_struct *tsk;
> >> +	struct kretprobe_instance *ri;
> >> +	struct hlist_head *head;
> >> +	struct hlist_node *node;
> >> +	unsigned long *sara = (unsigned long *)regs->rsp - 1;
> >> +
> >> +	tsk = arch_get_kprobe_task(sara);
> >
> >I dont think you handle the case of the exception happening on
> >a exception or interrupt stack. This is broken.

What about this problem?
