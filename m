Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWGRAYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWGRAYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 20:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWGRAYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 20:24:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751252AbWGRAYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 20:24:45 -0400
Date: Mon, 17 Jul 2006 17:23:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Horms <horms@verge.net.au>
Cc: ak@suse.de, rmk@arm.linux.org.uk, tony.luck@intel.com, paulus@samba.org,
       anton@samba.org, chris@zankel.net, linux-ia64@vger.kernel.org,
       linuxppc-dev@ozlabs.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Message-Id: <20060717172341.6d49f109.akpm@osdl.org>
In-Reply-To: <20060717231056.GC12463@verge.net.au>
References: <31687.FP.7244@verge.net.au>
	<200607180027.51986.ak@suse.de>
	<20060717231056.GC12463@verge.net.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2006 19:10:59 -0400
Horms <horms@verge.net.au> wrote:

> On Tue, Jul 18, 2006 at 12:27:51AM +0200, Andi Kleen wrote:
> > On Monday 17 July 2006 18:17, Horms wrote:
> > ...
> > Keeping the delay might be actually useful so that you can see the panic
> > before system reboots when reboot on panic is enabled. I would just use a loop
> > of mdelays(1) with touch_nmi_watchdog/touch_softirq_watchdog()s
> > inbetween.
> 
> Ok, I will look into making that happen. I agree that the pause is
> quite useful.

It's kind-of already implemented, via pause_on_oops.  Perhaps doing
something like 

	if (panic_on_oops)
		pause_on_oops = max(pause_on_oops, 5*HZ);

would be sufficient.
