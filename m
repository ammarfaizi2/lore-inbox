Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318675AbSG0BaH>; Fri, 26 Jul 2002 21:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318676AbSG0BaH>; Fri, 26 Jul 2002 21:30:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:14355 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318675AbSG0BaG>;
	Fri, 26 Jul 2002 21:30:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()] 
In-reply-to: Your message of "Sat, 27 Jul 2002 03:19:06 +0200."
             <20020727011906.GA1160@dualathlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Jul 2002 11:33:11 +1000
Message-ID: <19388.1027733591@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002 03:19:06 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>here an updated patch that moves the bitflag from the dedicated array to
>the mod->flags per your suggesiton.
>Oops: 0002
>2.4.19-rc3aa2 #3 SMP Sat Jul 27 05:06:19 CEST 2002

Kernel version without any identifying string cannot be picked up by
ksymoops.  Can you append the kernel version to the die message?  That
means changing all arch/*/traps.c but it saves a line on the console.

Oops: 0002 2.4.19-rc3aa2 #3 SMP Sat Jul 27 05:06:19 CEST 2002

>+void module_oops_tracking_init(void)
>+{
>+	struct module * mod;
>+
>+	for (mod = module_list; mod != &kernel_module; mod = mod->next)
>+		mod->flags &= MOD_OOPS_PRINT;

		mod->flags &= ~MOD_OOPS_PRINT;


