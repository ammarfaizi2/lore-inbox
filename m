Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752620AbWAHMZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbWAHMZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbWAHMZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:25:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752610AbWAHMZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:25:12 -0500
Date: Sun, 8 Jan 2006 04:24:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-Id: <20060108042425.4d0b8a76.akpm@osdl.org>
In-Reply-To: <43C050FA.9040400@ens-lyon.org>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43C0172E.7040607@ens-lyon.org>
	<20060107145800.113d7de5.akpm@osdl.org>
	<43C050FA.9040400@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Andrew Morton wrote:
> 
> >Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> >  
> >
> >>2) acpi-cpufreq does not load either, returns ENODEV too. It's probably
> >> git-acpi. I tried to revert it but there are lots of other patches
> >> depending on it, so I finally gave up.
> >>    
> >>
> >
> >OK, let me try to reproduce this.  acpi and cpufreq are fully merged up, so
> >this bug may well be in mainline now.
> >
> >  
> >
> >> 3) wpa_supplicant does not find my WPA network anymore (while iwlist
> >> scanning sees). I didn't see anything relevant in dmesg. My driver is
> >> ipw2200.
> >>    
> >>
> >
> >It's things like this which make me consider a career in carpentry.
> >
> >I assume 2.6.15 works OK?
> >  
> >
> 
> 2.6.15 and 2.6.15-git3 both don't show any of these issues. Did acpi and
> cpufreq get merged after -git3 ?
> 

Well whatever bug it is, it's in Linus's tree now.  Happens for me too.

I traced the failure down as far as acpi_processor_get_performance_info(),
where it's failing here:

	status = acpi_get_handle(pr->handle, "_PCT", &handle);
	if (ACPI_FAILURE(status)) {
		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
				  "ACPI-based processor performance control unavailable\n"));
		return_VALUE(-ENODEV);
	}


