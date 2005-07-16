Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVGPV07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVGPV07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 17:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVGPV07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 17:26:59 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:8356 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261191AbVGPV06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 17:26:58 -0400
Message-ID: <42D97B29.4050400@gentoo.org>
Date: Sat, 16 Jul 2005 22:24:57 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>, Ayaz Abdulla <AAbdulla@nvidia.com>
Subject: Re: [PATCH] forcedeth: TX handler changes (experimental)
References: <42D913D6.5050902@colorfullife.com> <42D9658B.7020907@gentoo.org>
In-Reply-To: <42D9658B.7020907@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> After applying the v0.38 patch, I can't get any network at all. DHCP 
> fails to get an IP. v0.37 works fine.

Tracked it down. (sorry for linewraps)

+#define DEV_NEED_TIMERIRQ	0x0001  /* set the timer irq flag in the irq mask */
+#define DEV_NEED_LINKTIMER	0x0002	/* poll link settings. Relies on the timer 
irq */
+#define DEV_HAS_LARGEDESC	0x0003	/* device supports jumbo frames and needs 
packet format 2 */

My hardware is NEED_TIMERIRQ|NEED_LINKTIMER, however, by this logic, it'll 
also be DEV_HAVE_LARGEDESC, which isn't true.

So, you want this instead:

#define DEV_HAS_LARGEDESC	0x0004

After making that change, all is working fine, but then again, I've never run 
into the hangs you are debugging. I'll follow up in a couple of days time to 
confirm I'm not getting any problems with the new code.

Thanks,
Daniel
