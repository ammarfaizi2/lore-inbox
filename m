Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750703AbWFEHso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWFEHso (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWFEHso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:48:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750703AbWFEHsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:48:43 -0400
Date: Mon, 5 Jun 2006 00:48:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: jeremy@goop.org, linux-kernel@vger.kernel.org, dzickus@redhat.com,
        ak@suse.de, Miles Lane <miles.lane@gmail.com>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in
 arch/i386/kernel/nmi.c:174
Message-Id: <20060605004823.566b266c.akpm@osdl.org>
In-Reply-To: <4483DF32.4090608@goop.org>
References: <4480C102.3060400@goop.org>
	<4483DF32.4090608@goop.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 00:37:22 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Jeremy Fitzhardinge wrote:
> > I'm trying to get suspend/resume working properly on my Thinkpad X60.
> > This is a dual-core machine, so its running in SMP mode.
> >
> > Now that I have a set of patches to make AHCI resume properly, I'm
> > getting a crash on the second suspend.  I can't get an actual listing of
> > the oops, but I have a set of screenshots if anyone needs more details.
> >
> > The gist is that there's a BUG_ON failing at arch/i386/kernel/nmi.c:174
> > (BUG_ON(counter > NMI_MAX_COUNTER_BITS)), in release_evntsel_nmi.  The
> > backtrace is:
> >
> >     release_evntsel_nmi
> >     stop_apci_nmi_watchdog
> >     on_each_cpu
> >     disable_lapic_nmi_watchdog
> >     lapic_nmi_suspend
> >     sysdev_suspend
> >     device_power_down
> >     suspend_enter
> >     enter_state
> >     state_store
> >     subsys_attr_store
> >     sysfs_write_file
> >     vfs_write
> >     sys_write
> >     sysenter_past_esp
> 
> This BUG_ON was introduced by the patch 
> x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch.
> 

http://bugzilla.kernel.org/show_bug.cgi?id=6647 has details.

Do you think the suspend breakage is related to that patch?

Miles also reports that every second suspend fails for him.  Miles, does
'nmi_watchdog=0' make it better?

