Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVCaULu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVCaULu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCaULu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:11:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:8385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261749AbVCaULh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:11:37 -0500
Date: Thu, 31 Mar 2005 12:11:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3
Message-Id: <20050331121119.4629aa94.akpm@osdl.org>
In-Reply-To: <200503311505.48590.petkov@uni-muenster.de>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<200503251746.10458.petkov@uni-muenster.de>
	<200503311505.48590.petkov@uni-muenster.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <petkov@uni-muenster.de> wrote:
>
> On Friday 25 March 2005 17:46, Borislav Petkov wrote:
>  > Hi Andrew,
>  >
>  > mm3 still not booting on my machine. Boot option 'nmi_watchdog=2' (my cpu
>  > is a dual core pentium 4 HT, 2.60 GHz) gets me a bit further in the boot
>  > process but it blocks there too.
>  >
>  > [output retyped from screen]:
>  > kernel: [    4.109241] PM: Checking swsusp image.
>  > kernel: [    4.109244] PM: Resume from disk failed.
>  > kernel: [    4.112220] VFS: Mounted root (ext2 filesystem) readonly.
>  > kernel: [    4.112465] Freeing unused kernel memory: 188k freed
>  > kernel: [    4.142002] logips2pp: Detected unknown logitech mouse model 1
>  > kernel: [    4.274620] input: PS/2 Logitech Mouse on isa0060/serio1
>  > <--- [point of previous blocks without boot option 'nmi_watchdog=2']--->
>  > INIT: version 2.86 booting
>  > Mounting a tmpfs over /dev... done.
>  > Creating initial device nodes... done.
>  > Setting parameters of disc: (none).
>  > Activating swap.
>  > kernel: [   10.712648] Adding 976744k swap on /dev/hda2. Priority:-1
>  > extents:1 Checking root file system...
>  > fsck 1.36 (05-Feb-2005)
>  > /: clean, 127290/1831424 files, 898566/3662056 blocks
>  > [EOF]
> 
>  Hi Andrew,
> 
>  i finally got to run kdb within mm3 and I got a bit further but am not sure 
>  whether I'm debugging in the right direction:
> 
>  After booting with "kdb=early" I found out that the kernel blocks with the 
>  partial message:
> 
>  kmem_cache_create: Early error in slab task_struct
>  kernel BUG at mm/slab.c:1215
>  invalid operand: 0000 [#1]
>  PREEMPT SMP

Beats me.  Where did the kdb patch come from?

It sounds like kdb for some reason is leaving the calling task in
in_interrupt() state when it shouldn't.  You could try removing the
in_interrupt() test, but things will probably die later on.

It might be worth disabling preempt, although a bug there won't cause
in_interrupt() to return true.

Did you send me your .config?
