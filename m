Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266611AbRGIAid>; Sun, 8 Jul 2001 20:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266691AbRGIAiX>; Sun, 8 Jul 2001 20:38:23 -0400
Received: from [192.48.153.1] ([192.48.153.1]:1400 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S266611AbRGIAiO>;
	Sun, 8 Jul 2001 20:38:14 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Jahn Veach - Veachian64" <V64@Galaxy42.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols in 2.4.6 
In-Reply-To: Your message of "Sun, 08 Jul 2001 18:52:28 EST."
             <004c01c10809$0dc310a0$5d910404@molybdenum> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Jul 2001 10:37:27 +1000
Message-ID: <25863.994639047@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001 18:52:28 -0500, 
"Jahn Veach - Veachian64" <V64@Galaxy42.com> wrote:
>nm vmlinux | grep printk
>
>c024f44e ? __kstrtab_printk
>c0254870 ? __ksymtab_printk
>c0113494 T printk
>c017c6ec t printk_pnp_dev_id

That looks OK.  Just to confirm, when you did depmod -ae, did you
include -F pointing at the 2.4.6 System.map?  If you omitted -F then it
used /proc/ksyms on your current kernel, I suspect that this is your
problem.  The command should be depmod -ae -F 2.4.6/System.map 2.4.6.
You should not need to issue that command by hand, make modules_install
does it automatically.

As for why you panic when you try to mount the root file system, you
have your SCSI driver and ide-disk as modules, not built into the
kernel.  If the code to find and mount your root file system is in
modules then you must use initrd, see the kernel howto.  Unless you
have a *very* good reason to use initrd - don't.  Build the root
drivers into the kenrel instead.

