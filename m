Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVLNLlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVLNLlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVLNLlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:41:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44993 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932429AbVLNLlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:41:05 -0500
Date: Wed, 14 Dec 2005 11:08:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
Message-ID: <20051214100841.GA18381@elf.ucw.cz>
References: <439FCECA.3060909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439FCECA.3060909@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The overall purpose of this patch series is to all a system administrator
> to reserve a number of pages in a 'critical pool' that is set aside for
> situations when the system is 'in emergency'.  It is up to the individual
> administrator to determine when his/her system is 'in emergency'.  This is
> not meant to (necessarily) anticipate OOM situations, though that is
> certainly one possible use.  The purpose this was originally designed for
> is to allow the networking code to keep functioning despite the sytem
> losing its (potentially networked) swap device, and thus temporarily
> putting the system under exreme memory pressure.

I don't see how this can ever work.

How can _userspace_ know about what allocations are critical to the
kernel?!

And as you noticed, it does not work for your original usage case,
because reserved memory pool would have to be "sum of all network
interface bandwidths * ammount of time expected to survive without
network" which is way too much.

If you want few emergency pages for some strange hack you are doing
(swapping over network?), just put swap into ramdisk and swapon() it
when you are in emergency, or use memory hotplug and plug few more
gigabytes into your machine. But don't go introducing infrastructure
that _can't_ be used right.
								Pavel
-- 
Thanks, Sharp!
