Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWGQW1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWGQW1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWGQW1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:27:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53198 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751047AbWGQW1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:27:16 -0400
From: Andi Kleen <ak@suse.de>
To: Horms <horms@verge.net.au>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Date: Tue, 18 Jul 2006 00:27:51 +0200
User-Agent: KMail/1.9.1
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Chris Zankel <chris@zankel.net>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
References: <31687.FP.7244@verge.net.au>
In-Reply-To: <31687.FP.7244@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607180027.51986.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 July 2006 18:17, Horms wrote:
> This patch is part of an effort to unify the panic_on_oops behaviour
> across all architectures that implement it.
>
> It was pointed out to me by Andi Kleen that if an oops has occured
> in interrupt context, then calling sleep() in the oops path will only cause
> a panic, and that it would be really better for it not to be in the path at
> all.
>
> This patch removes the ssleep() call and reworks the console message
> accordinly.  I have a slght concern that the resulting console message is
> too long, feedback welcome.

Keeping the delay might be actually useful so that you can see the panic
before system reboots when reboot on panic is enabled. I would just use a loop
of mdelays(1) with touch_nmi_watchdog/touch_softirq_watchdog()s
inbetween.

-Andi
