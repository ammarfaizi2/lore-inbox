Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161489AbWJUSMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161489AbWJUSMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWJUSMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:12:50 -0400
Received: from gw.goop.org ([64.81.55.164]:48564 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964773AbWJUSMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:12:49 -0400
Message-ID: <453A6320.30009@goop.org>
Date: Sat, 21 Oct 2006 11:12:48 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [11/19] i386: Fix fake return address
References: <20061021 651.356252000@suse.de> <20061021165131.4FDD813C4D@wotan.suse.de>
In-Reply-To: <20061021165131.4FDD813C4D@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> From: Jeremy Fitzhardinge <jeremy@goop.org>
> The fake return address was being set to __KERNEL_PDA, rather than 0.
> Push it earlier while %eax still equals 0.
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Andi Kleen <ak@suse.de>
> Cc: Andi Kleen <ak@muc.de>
> Cc: Andrew Morton <akpm@osdl.org>
>
> ---
>  arch/i386/kernel/head.S |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux/arch/i386/kernel/head.S
> ===================================================================
> --- linux.orig/arch/i386/kernel/head.S
> +++ linux/arch/i386/kernel/head.S
> @@ -317,7 +317,7 @@ is386:	movl $2,%ecx		# set MP
>  	movl %eax,%gs
>  	lldt %ax
>  	cld			# gcc2 wants the direction flag cleared at all times
> -	pushl %eax		# fake return address
> +	pushl $0		# fake return address for unwinder
>  #ifdef CONFIG_SMP
Yep, that's better than my patch, but the comment is out of date.

    J

