Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWETVae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWETVae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWETVae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:30:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932376AbWETVad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:30:33 -0400
Date: Sat, 20 May 2006 14:30:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.17-rc4-mm2 (hard lockup after resume from disk on AMD64)
Message-Id: <20060520143017.43a87c3a.akpm@osdl.org>
In-Reply-To: <200605202322.40214.rjw@sisk.pl>
References: <20060520054103.46a6edb5.akpm@osdl.org>
	<200605202322.40214.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Saturday 20 May 2006 14:41, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm2/
> 
>  My box (Asus L5D, x86_64 kernel) locks up hard after the resume from suspend
>  to disk.  This happens right after the console has been restored and only if
>  all modules are loaded before suspend (eg. it doesn't lock up when booted with
>  init=/bin/bash).  Also it's caught by the softlockup watchdog which produces
>  traces similar to the appended one.
> 
>  Greetings,
>  Rafael
> 
> 
>  BUG: soft lockup detected on CPU#0!
> 
>  Call Trace: <IRQ> <ffffffff8025b2f1>{softlockup_tick+193}
>         <ffffffff802360a3>{run_local_timers+19} <ffffffff802362c7>{update_process_times+87}
>         <ffffffff8020e174>{main_timer_handler+548} <ffffffff8020e3c5>{timer_interrupt+21}
>         <ffffffff8025b4e3>{handle_IRQ_event+51} <ffffffff8025b5d2>{__do_IRQ+162}
>         <ffffffff8020c3b1>{do_IRQ+65} <ffffffff80209d5e>{ret_from_intr+0}
>         <ffffffff803cb8d0>{urb_destroy+0} <ffffffff803ca84a>{usb_hcd_poll_rh_status+250}
>         <ffffffff880dafa2>{:ohci_hcd:ohci_irq+194} <ffffffff803c9ce2>{usb_hcd_irq+50}
>         <ffffffff8025b4e3>{handle_IRQ_event+51} <ffffffff8025b5d2>{__do_IRQ+162}
>         <ffffffff8020c3b1>{do_IRQ+65} <ffffffff80209d5e>{ret_from_intr+0}
>         <ffffffff8025b4d4>{handle_IRQ_event+36} <ffffffff8025b5d2>{__do_IRQ+162}
>         <ffffffff8020c3b1>{do_IRQ+65} <ffffffff80209d5e>{ret_from_intr+0}
>         <ffffffff8025b4d4>{handle_IRQ_event+36} <ffffffff8025b5d2>{__do_IRQ+162}
>         <ffffffff8020c3b1>{do_IRQ+65} <ffffffff80209d5e>{ret_from_intr+0} <EOI>
>         <ffffffff803cb8d0>{urb_destroy+0} <ffffffff803cb788>{hcd_submit_urb+2072}
>         <ffffffff80463d4d>{_spin_unlock_irqrestore+29} <ffffffff803cb9a5>{usb_free_urb+21}
>         <ffffffff803ca0ab>{usb_hcd_giveback_urb+315} <ffffffff80463d4d>{_spin_unlock_irqrestore+29}
>         <ffffffff803cbd2b>{usb_submit_urb+859} <ffffffff803cc66a>{usb_start_wait_urb+122}
>         <ffffffff8027c58d>{dbg_redzone1+29} <ffffffff8027d804>{cache_alloc_debugcheck_after+532}
>         <ffffffff8027c58d>{dbg_redzone1+29} <ffffffff803cca40>{usb_control_msg+240}
>         <ffffffff803c5e74>{set_port_feature+68} <ffffffff803c61f9>{hub_port_reset+57}
>         <ffffffff803c64d1>{hub_port_init+129} <ffffffff803c8b31>{hub_thread+2241}
>         <ffffffff80242140>{autoremove_wake_function+0} <ffffffff803c8270>{hub_thread+0}
>         <ffffffff80241f29>{kthread+217} <ffffffff80463d84>{_spin_unlock_irq+20}
>         <ffffffff80228d99>{schedule_tail+73} <ffffffff8020a38a>{child_rip+8}
>         <ffffffff80241e50>{kthread+0} <ffffffff8020a382>{child_rip+0}
>  BUG: soft lockup detected on CPU#0!

What a revolting backtrace.  There were some x86_64 precise-backtrace
patches floating around on the list this week.

Still, it would appear that USB has become confused.  If you have the time
to do a bisection search, I'd start in on gregkh-usb-*.patch.




