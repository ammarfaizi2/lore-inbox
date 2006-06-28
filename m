Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWF1RPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWF1RPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWF1RPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:15:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6341 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751436AbWF1RPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:15:12 -0400
Date: Wed, 28 Jun 2006 13:15:03 -0400
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git broke suspend!
Message-ID: <20060628171503.GD23396@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20060627181045.GA32115@suse.de> <20060627182014.GB7914@redhat.com> <20060627182646.GB32115@suse.de> <20060627183935.GC7914@redhat.com> <20060627185532.GD32115@suse.de> <20060627191125.GH7914@redhat.com> <20060628080519.GN32115@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628080519.GN32115@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 10:05:19AM +0200, Jens Axboe wrote:
 > On Tue, Jun 27 2006, Dave Jones wrote:
 > > On Tue, Jun 27, 2006 at 08:55:33PM +0200, Jens Axboe wrote:
 > > 
 > >  > > I don't see any cpufreq stuff in your dmesg at all. 
 > >  > > Is it definitly on in the config ?
 > >  > 
 > >  > Strangely, now /sys/devices/system/cpu/cpu0 also seems to be empty on
 > >  > this kernel. Wonder what is going on here...
 > >  > 
 > >  > CONFIG_CPU_FREQ=y
 > >  > CONFIG_CPU_FREQ_TABLE=y
 > >  > # CONFIG_CPU_FREQ_DEBUG is not set
 > >  > CONFIG_CPU_FREQ_STAT=y
 > >  > # CONFIG_CPU_FREQ_STAT_DETAILS is not set
 > >  > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 > >  > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
 > >  > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 > >  > CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 > >  > CONFIG_CPU_FREQ_GOV_USERSPACE=m
 > >  > CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 > >  > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 > > 
 > > CONFIG_X86_SPEEDSTEP_CENTRINO too ?
 > > 
 > > booting with cpufreq.debug=7 should show _some_ info.
 > > Give that a shot
 > 
 > Ok, foudn the problem, it was indeed a missing .config setting. I had
 > acpi processor as =m, and apparently some of the later kernels then
 > don't allow CPU_FREQ_ACPI_TABLES=y and just helpfully deleted the
 > option. Fixing that up makes everything work again!

Ouch, that's a nasty trap for someone to fall into.
I'm glad you figured out what was happening, but I'm
concerned that a lot of users building their own kernels
may not be able to do the same.

Hmm, not sure what the right fix is though.

		Dave

-- 
http://www.codemonkey.org.uk
