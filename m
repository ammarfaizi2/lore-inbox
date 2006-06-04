Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932236AbWFDLrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWFDLrP (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 07:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWFDLrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 07:47:15 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:29369 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932236AbWFDLrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 07:47:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Sun, 4 Jun 2006 13:47:26 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com
References: <4480C102.3060400@goop.org>
In-Reply-To: <4480C102.3060400@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606041347.26853.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 03 June 2006 00:51, Jeremy Fitzhardinge wrote:
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
>      release_evntsel_nmi
>      stop_apci_nmi_watchdog
>      on_each_cpu
>      disable_lapic_nmi_watchdog
>      lapic_nmi_suspend
>      sysdev_suspend
>      device_power_down
>      suspend_enter
>      enter_state
>      state_store
>      subsys_attr_store
>      sysfs_write_file
>      vfs_write
>      sys_write
>      sysenter_past_esp
> 
> This happens after all the devices have suspended themselves; then
> there's a longish pause (several seconds), and the oops appears.  The
> first suspend is very quick.
> 
> Everything works as expected when I disable nmi watchdog with
> nmi_watchdog=0 on the kernel command line.
> 
> dmesg after a single successful suspend/resume cycle attached.
> (resent without .config to get under linux-kernel's size limit; mail if 
> you want a copy)

Well, this looks like a tough one.  Could you please create a bugzilla entry
with all of the relevant information?

Greetings,
Rafael
