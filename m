Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261785AbSI2UxK>; Sun, 29 Sep 2002 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbSI2UxK>; Sun, 29 Sep 2002 16:53:10 -0400
Received: from host187.south.iit.edu ([216.47.130.187]:4224 "EHLO
	host187.south.iit.edu") by vger.kernel.org with ESMTP
	id <S261785AbSI2UxJ>; Sun, 29 Sep 2002 16:53:09 -0400
Date: Sun, 29 Sep 2002 15:57:30 -0500 (CDT)
From: Stephen Marz <smarz@host187.south.iit.edu>
To: David Brownell <david-b@pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG in usb-ohci.c:902!
In-Reply-To: <3D976726.4070909@pacbell.net>
Message-ID: <Pine.LNX.4.44.0209291549390.1911-100000@host187.south.iit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually there is a file of that name 'uhci-hcd' in the 2.5.39 source, 
which I was talking about.  I was also talking about the uhci-hcd driver 
in the 2.5.39 source which doesn't necessarily have to have a BUG in that 
code.  Here is my call trace:

uhci-irq [uchi-hcd]
usb_hcd_irq_Rfba60562 [usbcore]
handle_IRQ_event
do_IRQ
common_interrupt
page_remove_rmap
zap_pke_range
zap_pmd_range
unmap_page_range
exit_mmap
mmput
exec_mmap
flush_old_exec
load_elf_binary
load_elf_binary
search_binary_handler
do_execve
sys_execve
syscall_call

Code: 83 7b 18 8d 73 04 74 38 c7 04 24 80 f8 88 d0 89 5c 24 04
  <0> Kernel panic:  Aiee, killing interrupt handler!
In interrupt handler - not syncing...

I am apparently hitting a different bug, but it inevitably comes from
the uhci-hcd driver (according to the panic).

Regards,

Stephen Marz

> > I have noticed this problem in 2.5.39 except it occurs with the module
> > uhci-hcd.

> No you haven't.  It doesn't have a file of that name, so you
> didn't see such a BUG().  And I don't know about you, but my
> copy of 2.5.39 has no BUG() anywhere in the ohci-hcd driver,
> so it'd be hard seeing _any_ BUG() coming from there.

> You might be hitting a different BUG(), but in that case you
> would need to get your bug reports straight.

> - Dave





