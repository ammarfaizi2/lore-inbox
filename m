Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbULWQWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbULWQWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 11:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbULWQWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 11:22:41 -0500
Received: from holomorphy.com ([207.189.100.168]:59575 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261193AbULWQWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 11:22:39 -0500
Date: Thu, 23 Dec 2004 08:22:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: 2.6.x BUGs at boot time (APIC related)
Message-ID: <20041223162202.GB771@holomorphy.com>
References: <200412231611.iBNGBdLY022571@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412231611.iBNGBdLY022571@harpo.it.uu.se>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>> Sounds pretty serious. What happens if you add the missing return -1?

On Thu, 23 Dec 2004 14:57:25 +0000, Denis Vlasenko wrote:
>> Just tested that. It booted ok. Patch is in attachment.

On Thu, Dec 23, 2004 at 05:11:39PM +0100, Mikael Pettersson wrote:
> The early return just hides the real bug, whatever it is.
> I'm suspecting some bogosity with boot_cpu_physical_apicid,
> or possibly smp_found_config. Please remove the early return
> and try the patch below instead.

Dropping the early return means nolapic is not honored in this
codepath. I realize it doesn't have much impact on the bug that
happens while nolapic is not passed. Thanks for fixing that.

Also, it should probably not have to clear X86_FEATURE_APIC from
boot_cpu_data.x86_capability, because lapic_disable() already did
so. Tracking down where that is being set (if it indeed is) when
enable_local_apic < 0 may be useful.


-- wli
