Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423208AbWF1IDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423208AbWF1IDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423209AbWF1IDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:03:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30567 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1423208AbWF1IDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:03:45 -0400
Date: Wed, 28 Jun 2006 10:05:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git broke suspend!
Message-ID: <20060628080519.GN32115@suse.de>
References: <20060627181045.GA32115@suse.de> <20060627182014.GB7914@redhat.com> <20060627182646.GB32115@suse.de> <20060627183935.GC7914@redhat.com> <20060627185532.GD32115@suse.de> <20060627191125.GH7914@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627191125.GH7914@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Dave Jones wrote:
> On Tue, Jun 27, 2006 at 08:55:33PM +0200, Jens Axboe wrote:
> 
>  > > I don't see any cpufreq stuff in your dmesg at all. 
>  > > Is it definitly on in the config ?
>  > 
>  > Strangely, now /sys/devices/system/cpu/cpu0 also seems to be empty on
>  > this kernel. Wonder what is going on here...
>  > 
>  > CONFIG_CPU_FREQ=y
>  > CONFIG_CPU_FREQ_TABLE=y
>  > # CONFIG_CPU_FREQ_DEBUG is not set
>  > CONFIG_CPU_FREQ_STAT=y
>  > # CONFIG_CPU_FREQ_STAT_DETAILS is not set
>  > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
>  > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
>  > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>  > CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>  > CONFIG_CPU_FREQ_GOV_USERSPACE=m
>  > CONFIG_CPU_FREQ_GOV_ONDEMAND=m
>  > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> 
> CONFIG_X86_SPEEDSTEP_CENTRINO too ?
> 
> booting with cpufreq.debug=7 should show _some_ info.
> Give that a shot

Ok, foudn the problem, it was indeed a missing .config setting. I had
acpi processor as =m, and apparently some of the later kernels then
don't allow CPU_FREQ_ACPI_TABLES=y and just helpfully deleted the
option. Fixing that up makes everything work again!

-- 
Jens Axboe

