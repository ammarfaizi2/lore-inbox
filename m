Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVABXmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVABXmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 18:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVABXmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 18:42:24 -0500
Received: from nevyn.them.org ([66.93.172.17]:34696 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261346AbVABXmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 18:42:21 -0500
Date: Sun, 2 Jan 2005 18:41:55 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, davidel@xmailserver.org,
       mh@codeweavers.com, the3dfxdude@gmail.com
Subject: Re: [PATCH] Fix typo in i386 single step changes
Message-ID: <20050102234155.GA29453@nevyn.them.org>
Mail-Followup-To: Andi Kleen <ak@muc.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, davidel@xmailserver.org,
	mh@codeweavers.com, the3dfxdude@gmail.com
References: <m1brc7xv98.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1brc7xv98.fsf@muc.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 12:32:19AM +0100, Andi Kleen wrote:
> 
> Fix an obvious typo in the recent i386 single stepping changes.
> 
> I would recommend to redo all the Wine etc. testing that lead to this patch
> since it probably never worked.
> 
> Signed-off-by: Andi Kleen <ak@muc.de>
> 
> --- linux-2.6.10-bk5/arch/i386/kernel/traps.c-o	Mon Jan  3 01:02:06 2005
> +++ linux-2.6.10-bk5/arch/i386/kernel/traps.c	Mon Jan  3 01:03:05 2005
> @@ -725,7 +725,7 @@
>  		if (tsk->ptrace & PT_DTRACE) {
>  			regs->eflags &= ~TF_MASK;
>  			tsk->ptrace &= ~PT_DTRACE;
> -			if (!tsk->ptrace & PT_DTRACE)
> +			if (!(tsk->ptrace & PT_DTRACE))
>  				goto clear_TF;
>  		}
>  	}

That test is still wrong... the bit is cleared on the previous line. 
Is it supposed to be testing something else entirely?

-- 
Daniel Jacobowitz
