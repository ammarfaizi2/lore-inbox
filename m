Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132194AbQKWAni>; Wed, 22 Nov 2000 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132190AbQKWAn2>; Wed, 22 Nov 2000 19:43:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64013 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S132194AbQKWAnP>;
        Wed, 22 Nov 2000 19:43:15 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011230006.AAA02777@raistlin.arm.linux.org.uk>
Subject: Re: Modutils 2.3.14 / Kernel 2.4.0-test11 incompatibility
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 23 Nov 2000 00:06:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4589.974935487@ocs3.ocs-net> from "Keith Owens" at Nov 23, 2000 10:24:47 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> On Wed, 22 Nov 2000 23:12:25 +0000 (GMT), 
> Russell King <rmk@arm.linux.org.uk> wrote:
> >        if (copy_from_user(mod+1, mod_user+1, mod->size-sizeof(*mod))) {
> 
> Using sizeof(struct module) is a nono in sys_init_module(), the code
> has to use the user space size.  Does this untested patch fix the
> problem?  Against 2.4.0-test11-pre6 but should fit test11.
> 
> 
> Index: 0-test11-pre6.1/kernel/module.c
> --- 0-test11-pre6.1/kernel/module.c Wed, 08 Nov 2000 11:52:15 +1100 kaos (linux-2.4/j/28_module.c 1.1.2.1.1.1.7.1.1.1 644)
> +++ 0-test11-pre6.1(w)/kernel/module.c Thu, 23 Nov 2000 10:22:26 +1100 kaos (linux-2.4/j/28_module.c 1.1.2.1.1.1.7.1.1.1 644)
> @@ -480,7 +480,9 @@ sys_init_module(const char *name_user, s
>  
>  	/* Ok, that's about all the sanity we can stomach; copy the rest.  */
>  
> -	if (copy_from_user(mod+1, mod_user+1, mod->size-sizeof(*mod))) {
> +	if (copy_from_user((char *)mod+mod_user_size,
> +			   (char *)mod_user+mod_user_size,
> +			   mod->size-mod_user_size)) {
>  		error = -EFAULT;
>  		goto err3;
>  	}

This also works!
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
