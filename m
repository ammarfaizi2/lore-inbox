Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270764AbUJUP05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270764AbUJUP05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270766AbUJUP0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:26:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:32395 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S270748AbUJUPXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:23:02 -0400
Message-ID: <4177D226.7020607@osdl.org>
Date: Thu, 21 Oct 2004 08:13:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: add an option to configure oops stack dump
References: <200410201907.i9KJ7r2s022648@hera.kernel.org>
In-Reply-To: <200410201907.i9KJ7r2s022648@hera.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2016, 2004/10/20 08:11:53-07:00, ak@muc.de
> 
> 	[PATCH] x86_64: add an option to configure oops stack dump
> 	
> 	Add an kstack= option to configure how much stack should be printed on a
> 	oops.
> 	
> 	Signed-off-by: Andi Kleen <ak@suse.de>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  traps.c |    8 ++++++++
>  1 files changed, 8 insertions(+)
> 
> 
> diff -Nru a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
> --- a/arch/x86_64/kernel/traps.c	2004-10-20 12:08:04 -07:00
> +++ b/arch/x86_64/kernel/traps.c	2004-10-20 12:08:04 -07:00
> @@ -900,3 +900,11 @@
>  	return -1; 
>  } 
>  __setup("oops=", oops_dummy); 
> +
> +static int __init kstack_setup(char *s)
> +{
> +	kstack_depth_to_print = simple_strtoul(s,NULL,0);
> +	return 0;
> +}
> +__setup("kstack=", kstack_setup);

I'm happy to see this, but I don't see why it's arch-specific...

-- 
~Randy
