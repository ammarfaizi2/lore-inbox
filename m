Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUAHAXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUAHAXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:23:04 -0500
Received: from dp.samba.org ([66.70.73.150]:64384 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262580AbUAHAW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:22:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Alt-arrow console switch sometimes dropped 
In-reply-to: Your message of "Sat, 03 Jan 2004 14:37:46 BST."
             <20040103133746.GA516@elf.ucw.cz> 
Date: Thu, 08 Jan 2004 10:55:59 +1100
Message-Id: <20040108002255.0EC092C44B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040103133746.GA516@elf.ucw.cz> you write:
> Hi!
> 
> Alt-arrow console switch is routinely dropped under high load. This
> patch fixes it: alt-arrow has to start from console _we want to switch
> to_, if switch is already pending. Please apply,
> 								Pavel

Sure, but a comment would be nice:

	/* Currently switching?  Queue this next switch relative to that. */

Thanks,
Trivial Rusty.

> Index: linux.new/drivers/char/keyboard.c
> ===================================================================
> --- linux.new.orig/drivers/char/keyboard.c	2003-12-25 13:28:51.000000000 +0100
> +++ linux.new/drivers/char/keyboard.c	2003-12-25 13:29:08.000000000 +0100
> @@ -507,8 +528,12 @@
>  static void fn_inc_console(struct vc_data *vc, struct pt_regs *regs)
>  {
>  	int i;
> +	int cur = fg_console;
>  
> -	for (i = fg_console+1; i != fg_console; i++) {
> +	if (want_console != -1)
> +		cur = want_console;
> +
> +	for (i = cur+1; i != cur; i++) {
>  		if (i == MAX_NR_CONSOLES)
>  			i = 0;
>  		if (vc_cons_allocated(i))
> 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
