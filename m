Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbULFJ7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbULFJ7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbULFJ7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:59:40 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:13790 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261477AbULFJ7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:59:37 -0500
Date: Mon, 6 Dec 2004 02:54:40 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Michael Buesch <mbuesch@freenet.de>
cc: paulmck@us.ibm.com, dipankar@in.ibm.com, rusty@au1.ibm.com, ak@suse.de,
       gareth@valinux.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Strange code in cpu_idle()
In-Reply-To: <200412060132.40912.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.61.0412060250410.1036@montezuma.fsmlabs.com>
References: <20041204231149.GA1591@us.ibm.com> <200412060132.40912.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Michael Buesch wrote:

> Hi Paul,
> 
> Well, your mail is _very_ interresting for me.
> 
> I get this oops for weeks with several kernel versions now:

There shouldn't be any oopses with the changes in question, the original 
bugfix was for crashes whilst unloading ACPI processor or APM module.

> Unable to handle kernel paging request at virtual address 00099108
>  printing eip:
> b01010c0
> *pde = 00000000
> Oops: 0000 [#1]
> SMP 
> Modules linked in: nfs lockd sunrpc nvidia ipv6 ohci_hcd tuner tvaudio msp3400 bttv video_buf firmware_class btcx_risc ehci_hcd uhci_hcd usbcore intel_agp agpgart evdev
> CPU:    0
> EIP:    0060:[<b01010c0>]    Tainted: P      VLI
> EFLAGS: 00010286   (2.6.10-rc2-ck2-nozeroram-findvmastat)

It would be a lot easier to debug with a vanilla kernel and no nvidia 
loaded.

> The above oops shows a crash when we try to access the
> thread_info->flags field. This is done by need_resched()
> to check the TIF_NEED_RESCHED flag.
> I don't know how to interpret the oops correctly to find
> the source of the crash.

Looks like thread_info was. Wow i think you're in a different world of 
hurt. If you can reproduce with less patches and no nvidia please send 
over the bugreport.

Thanks,
	Zwane

