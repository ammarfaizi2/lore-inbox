Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268389AbUHLDaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268389AbUHLDaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 23:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268394AbUHLDaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 23:30:24 -0400
Received: from holomorphy.com ([207.189.100.168]:49032 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268389AbUHLDaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 23:30:19 -0400
Date: Wed, 11 Aug 2004 20:30:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] 2.6.8-rc4-mm1 - UML fixes
Message-ID: <20040812033012.GE11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Dike <jdike@addtoit.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200408120415.i7C4FWJd010494@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408120415.i7C4FWJd010494@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 12:15:32AM -0400, Jeff Dike wrote:
> The patch below fixes a few UML-specific bugs not related to the rest of the
> kernel
> 	a bogus error return and some formatting in the fork code
> 	correct calculation of task.thread.kernel_stack
> 	remove a bogus panic
> 	a couple of fixes to allow UML to boot in the presence of exec-shield
[...]
>  	p->thread.kernel_stack = 
> -		(unsigned long) p->thread_info + THREAD_SIZE;
> +		(unsigned long) p->thread_info + 2 * PAGE_SIZE;
>  	return(CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr, 
>  				clone_flags, sp, stack_top, p, regs));

Out of curiosity, why are you allocating 4*PAGE_SIZE for the stack if
you're only going to use 2*PAGE_SIZE of it? I saw no other users for
the rest of ->thread_info offhand.


-- wli
