Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbUKIWxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUKIWxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUKIWxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:53:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:49049 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261758AbUKIWxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:53:18 -0500
Date: Tue, 9 Nov 2004 14:52:45 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>, dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: /sys/devices/system/timer registered twice
Message-ID: <20041109225245.GB7618@kroah.com>
References: <20041109193043.GA8767@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109193043.GA8767@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 08:30:43PM +0100, Kay Sievers wrote:
> Hi,
> I got this on a Centrino box with the latest bk:
> 
>   [kay@pim linux.kay]$ ls -l /sys/devices/system/
>   total 0
>   drwxr-xr-x  7 root root 0 Nov  8 15:12 .
>   drwxr-xr-x  5 root root 0 Nov  8 15:12 ..
>   drwxr-xr-x  3 root root 0 Nov  8 15:12 cpu
>   drwxr-xr-x  3 root root 0 Nov  8 15:12 i8259
>   drwxr-xr-x  2 root root 0 Nov  8 15:12 ioapic
>   drwxr-xr-x  3 root root 0 Nov  8 15:12 irqrouter
>   ?---------  ? ?    ?    ?            ? timer
> 
> 
> It is caused by registering two devices with the name "timer" from:
> 
>   arch/i386/kernel/time.c
>   arch/i386/kernel/timers/timer_pit.c
> 
> If I change one of the names, I get two correct looking sysfs entries.
> 
> Greg, shouldn't the driver core prevent the corruption of the first
> device if another one tries to register with the same name?

Hm, this looks like an issue for Dmitry, as there shouldn't be too
sysdev_class structures with the same name, right?

thanks,

greg k-h
