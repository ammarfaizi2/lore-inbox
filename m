Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbUJYK1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbUJYK1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 06:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUJYK1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 06:27:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55996 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261739AbUJYK1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 06:27:01 -0400
Date: Mon, 25 Oct 2004 12:27:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [swsusp] print error message when swapping is disabled
Message-ID: <20041025102700.GB14551@atrey.karlin.mff.cuni.cz>
References: <3ACA40606221794F80A5670F0AF15F8403BD57DA@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD57DA@pdsmsx403>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> swsusp exits silently when swapping is disabled. This patch gives some
> clues to
> the user in this case. Please apply.

Did you mean "swapon -a"? Otherwise approved, please send it to akpm
directly.

								Pavel

> --- linux-2.6.9-orig/kernel/power/swsusp.c	2004-10-24
> 16:16:41.000000000 +0800
> +++ linux-2.6.9/kernel/power/swsusp.c	2004-10-24 16:15:06.000000000
> +0800
> @@ -843,8 +843,11 @@ asmlinkage int swsusp_save(void)
>  {
>  	int error = 0;
>  
> -	if ((error = swsusp_swap_check()))
> +	if ((error = swsusp_swap_check())) {
> +		printk(KERN_ERR "swsusp: FATAL: cannot find swap device,
> try "
> +				"swap -a!\n");
>  		return error;
> +	}
>  	return suspend_prepare_image();
>  }
>  

-- 
Boycott Kodak -- for their patent abuse against Java.
