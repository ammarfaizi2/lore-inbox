Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVKAJN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVKAJN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVKAJN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:13:28 -0500
Received: from mail6.hitachi.co.jp ([133.145.228.41]:31196 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S965007AbVKAJN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:13:26 -0500
Date: Tue, 01 Nov 2005 18:12:29 +0900 (JST)
Message-Id: <20051101.181229.74752004.noboru.obata.ar@hitachi.com>
To: ebiederm@xmission.com
Cc: umka@sevcity.net, fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH] [KDUMP] pending interrupts problem
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <m1u0f2bj18.fsf@ebiederm.dsl.xmission.com>
References: <m1u0f2bj18.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005, Eric W. Biederman wrote:
> 
> Alex Lyashkov <umka@sevcity.net> writes:
> 
> > seems to bad patch. you dereference pointer (1) before check to NULL(2).
> 
> Duh.  I forgot to delete the earlier references. 
> That should have been...

Thank you Eric, the patch you resent has fixed the problem,
which originally happened on vanilla 2.6.13.

But, on such an unusual case, I prefer to mark it unlikely() and
output some warning message.

> +	/* Ignore spurious IPIs */
> +	if (!call_data)
> +		return;

	if (unlikely(!call_data)) {
		printk(KERN_WARNING "spurious IPI on CPU#%d, ignored\n",
		       smp_processor_id());
		return;
	}

Please take this if you like it, Eric.  I have also tested this
printk-added code.

Regards,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

