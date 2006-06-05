Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750712AbWFEHh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWFEHh3 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWFEHh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:37:29 -0400
Received: from gw.goop.org ([64.81.55.164]:17122 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750712AbWFEHh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:37:28 -0400
Message-ID: <4483DF32.4090608@goop.org>
Date: Mon, 05 Jun 2006 00:37:22 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, dzickus@redhat.com,
        Andi Kleen <ak@suse.de>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org>
In-Reply-To: <4480C102.3060400@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> I'm trying to get suspend/resume working properly on my Thinkpad X60.
> This is a dual-core machine, so its running in SMP mode.
>
> Now that I have a set of patches to make AHCI resume properly, I'm
> getting a crash on the second suspend.  I can't get an actual listing of
> the oops, but I have a set of screenshots if anyone needs more details.
>
> The gist is that there's a BUG_ON failing at arch/i386/kernel/nmi.c:174
> (BUG_ON(counter > NMI_MAX_COUNTER_BITS)), in release_evntsel_nmi.  The
> backtrace is:
>
>     release_evntsel_nmi
>     stop_apci_nmi_watchdog
>     on_each_cpu
>     disable_lapic_nmi_watchdog
>     lapic_nmi_suspend
>     sysdev_suspend
>     device_power_down
>     suspend_enter
>     enter_state
>     state_store
>     subsys_attr_store
>     sysfs_write_file
>     vfs_write
>     sys_write
>     sysenter_past_esp

This BUG_ON was introduced by the patch 
x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch.

    J
