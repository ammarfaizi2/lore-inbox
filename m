Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVA2Vgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVA2Vgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 16:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVA2Vgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 16:36:46 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:19723 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261570AbVA2Vgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 16:36:44 -0500
Date: Sat, 29 Jan 2005 21:36:42 +0000
From: John Levon <levon@movementarian.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] OProfile: Fix oops on undetected CPU type
Message-ID: <20050129213642.GB71581@compsoc.man.ac.uk>
References: <Pine.LNX.4.61.0501281146150.22906@montezuma.fsmlabs.com> <20050129140423.GA71581@compsoc.man.ac.uk> <Pine.LNX.4.61.0501290941180.10009@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501290941180.10009@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Cv0Gp-000HDU-8N*QxeFk94WcTA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 09:47:42AM -0700, Zwane Mwaikambo wrote:

> > Unfortunately bkcvs seems out of date so I can't even look at this
> > myself.
> 
> Yes you are right, i checked bk and there was a lot of shuffling about due 
> to the timer override. But it looks like we're depending on the timer 
> variable being set. We could always just run timer_init if cpu_type is not 
> set.
> 
> Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> 
> ===== drivers/oprofile/oprof.c 1.11 vs edited =====
> --- 1.11/drivers/oprofile/oprof.c	2005-01-04 19:48:23 -07:00
> +++ edited/drivers/oprofile/oprof.c	2005-01-29 09:38:24 -07:00
> @@ -157,7 +157,7 @@ static int __init oprofile_init(void)
>  
>  	oprofile_arch_init(&oprofile_ops);
>  
> -	if (timer) {
> +	if (timer || !oprofile_ops.cpu_type) {

Looks like you're still on the broken bkcvs, which is missing this
patch:

http://linus.bkbits.net:8080/linux-2.5/cset@1.1966.1.72?nav=index.html|ChangeSet@-2w

which AFAICS is the correct solution to the problem.

regards,
john
