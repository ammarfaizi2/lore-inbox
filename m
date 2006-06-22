Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWFVV0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWFVV0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbWFVV0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:26:45 -0400
Received: from mail.suse.de ([195.135.220.2]:163 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932120AbWFVV0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:26:44 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] x86_64: another fix for canonical RIPs during signal handling
Date: Thu, 22 Jun 2006 23:26:22 +0200
User-Agent: KMail/1.9.3
Cc: marcelo@kvack.org, linux-kernel@vger.kernel.org, pageexec@freemail.hu
References: <20060622210657.GA1221@1wt.eu>
In-Reply-To: <20060622210657.GA1221@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606222326.22133.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 June 2006 23:06, Willy Tarreau wrote:
> 
> I've been reported by the PaX Team that the following fix left a
> small hole :
> 
> [PATCH] Always check that RIPs are canonical during signal handling
> 
> +	if (regs->rip >= TASK_SIZE && regs->rip < VSYSCALL_START) {
> +		regs->rip = 0;
> +		return -EFAULT;
> +	}
> 
> ...
> 
> +	if (regs->rip >= TASK_SIZE) {
> +		if (sig == SIGSEGV)
> +			ka->sa.sa_handler = SIG_DFL;
> +		regs->rip = 0;
> +	}
> 
> "the wrong part is regs->rip=0, i guess the intention was to cause a
>  SIGSEGV upon returning to userland, but 0 is a valid userland address,
>  an application may very well have something mapped there. the correct
>  value would be ~0UL as it's guaranteed to fault on linux."
> 
> This explanation makes sense, so here's the patch. Andi, would you please
> review and confirm ? Thanks in advance.

I don't think it's a real problem.

The patch is not wrong, but also doesn't fix something that needs
to be fixed.

-Andi
