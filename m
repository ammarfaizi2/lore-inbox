Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbUC2T3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUC2T3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:29:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:34237 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263097AbUC2T3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:29:00 -0500
Date: Mon, 29 Mar 2004 11:28:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seriel console support broken in -mm4 and -mm5
Message-Id: <20040329112856.0b103c66.akpm@osdl.org>
In-Reply-To: <190920000.1080584708@[10.10.2.4]>
References: <189440000.1080583215@[10.10.2.4]>
	<190920000.1080584708@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > It works fine in -rc2.
> > 
> > -mm4 prints jibberish (wrong speed / settings?) for serial console, but
> > the getty stuff comes out file. shutdown just prints more jibberish.
> > 
> > -mm5 prints about half as much jibberish as -mm4 then hangs, seemingly
> > halfway through boot.
> > 
> > I guess I'll try linus.patch from -mm4 next, unless you have any other
> > suggestions that'd be more fruitful ...
> 
> OK, so -mm5 actually does the same as mm4 on my second try, so maybe the
> hang is intermittent, or something.
> 
> However, linus.patch from -mm4 works fine, so the culprit is one of the
> other patches in your tree ... any suggestions for which to shoot first? ;-)
> 

Not really.  Are you using early printk?

The only patches I have which touch drivers/serial/ are
8250-resource-management-fix, linus, pmac_zilog-oops-fix, kgdb-ga.

Lots of patches against drivers/char/*, but I don't see how any of those
can futz the serial settings.  I'm assuming you're using 8250?

drivers/char/cyclades.c~linus
drivers/char/efirtc.c~linus
drivers/char/istallion.c~bk-driver-core
drivers/char/Kconfig~kconfig-url-fixes
drivers/char/keyboard.c~kgdb-ga
drivers/char/mem.c~get_user_pages-handle-VM_IO
drivers/char/mem.c~linus
drivers/char/n_tty.c~move-job-control-stuff-tosignal_struct
drivers/char/random.c~urandom-scalability-fix
drivers/char/rocket.c~move-job-control-stuff-tosignal_struct
drivers/char/rtc.c~linus
drivers/char/sn_serial.c~linus
drivers/char/sonypi.h~linus
drivers/char/stallion.c~bk-driver-core
drivers/char/sx.c~move-job-control-stuff-tosignal_struct
drivers/char/sysrq.c~kgdb-ga
drivers/char/tipar.c~bk-driver-core
drivers/char/tpqic02.c~bk-driver-core
drivers/char/tty_io.c~move-job-control-stuff-tosignal_struct
drivers/char/tty_io.c~remove-down_tty_sem
drivers/char/tty_io.c~tty-locking-again
drivers/char/vc_screen.c~bk-driver-core
drivers/char/viocons.c~linus
drivers/char/viotape.c~linus
drivers/char/vt.c~bk-driver-core
drivers/char/vt.c~con_open-speedup
drivers/char/vt.c~linus
drivers/char/vt.c~move-job-control-stuff-tosignal_struct
drivers/char/vt.c~vt-cleanup
drivers/char/vt_ioctl.c~move-job-control-stuff-tosignal_struct


