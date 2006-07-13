Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWGMRgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWGMRgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWGMRgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:36:40 -0400
Received: from ns.suse.de ([195.135.220.2]:7079 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751053AbWGMRgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:36:40 -0400
From: Andi Kleen <ak@suse.de>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] IDE: Touch NMI watchdog during resume from STR
Date: Thu, 13 Jul 2006 19:36:34 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <44B61D0A.7010305@stud.feec.vutbr.cz> <p73ejwpmy6m.fsf@verdi.suse.de> <44B683EB.20709@stud.feec.vutbr.cz>
In-Reply-To: <44B683EB.20709@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607131936.34832.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 July 2006 19:33, Michal Schmidt wrote:
> Andi Kleen wrote:
> > Michal Schmidt <xschmi00@stud.feec.vutbr.cz> writes:
> >> if (stat == 0xff)
> >>  			return -ENODEV;
> >>  		touch_softlockup_watchdog();
> >> +		touch_nmi_watchdog();
> > You can remove the touch_softlock_watchdog then. It's implied in 
> > touch_nmi_watchdog
> 
> I don't think that's always true. There are architectures where 
> touch_nmi_watchdog is a NOP. This is in include/linux/nmi.h:
> 
> #ifdef ARCH_HAS_NMI_WATCHDOG
> extern void touch_nmi_watchdog(void);
> #else
> # define touch_nmi_watchdog() do { } while(0)
> #endif

That's broken code then. It should be defined to touch_softlock_watchdog
for the !ARCH_HAS_NMI_WATCHDOG then.

-Andi
