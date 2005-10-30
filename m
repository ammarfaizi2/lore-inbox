Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVJ3TcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVJ3TcS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVJ3TcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:32:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43162 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932233AbVJ3TcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:32:16 -0500
Date: Sun, 30 Oct 2005 14:33:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org
Subject: Re: [RFC][PATCH 5/6] swsusp: move swap-handling functions to separate file
Message-ID: <20051030133325.GE657@openzaurus.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292241.05312.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510292241.05312.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch is to show that the swap-handling part of swsusp is really independent
> and it can be moved entirely to a separate file.  It introduces the file swap.c
> containing all of the swap-handling code.
> 
> After the change swsusp.c contains the functions that in my opinion do not
> belong to either the snapshot-handling part or the swap-handling part
> (swsusp_suspend(), swsusp_resume() and the functions related to highmem).

Highmem handling should go to snapshot.c. Other parts do not need to know about
it.


linux-2.6.14-rc5-mm1/kernel/power/swap.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.14-rc5-mm1/kernel/power/swap.c	2005-10-29 13:26:26.000000000 +0200
> @@ -0,0 +1,915 @@
> +/*
> + * linux/kernel/power/snapshot.c

wrong name.

> +static void dump_info(void)
> +{
> +	pr_debug(" swsusp: Version: %u\n",swsusp_info.version_code);
> +	pr_debug(" swsusp: Num Pages: %ld\n",swsusp_info.num_physpages);
> +	pr_debug(" swsusp: UTS Sys: %s\n",swsusp_info.uts.sysname);
> +	pr_debug(" swsusp: UTS Node: %s\n",swsusp_info.uts.nodename);
> +	pr_debug(" swsusp: UTS Release: %s\n",swsusp_info.uts.release);
> +	pr_debug(" swsusp: UTS Version: %s\n",swsusp_info.uts.version);
> +	pr_debug(" swsusp: UTS Machine: %s\n",swsusp_info.uts.machine);
> +	pr_debug(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
> +	pr_debug(" swsusp: CPUs: %d\n",swsusp_info.cpus);
> +	pr_debug(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
> +	pr_debug(" swsusp: Total: %ld Pages\n", swsusp_info.pages);
> +}

I'd rather get rid of this, or at least made it *way* more terse.

Ok, that probably belongs to separate patch.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

