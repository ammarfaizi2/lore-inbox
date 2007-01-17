Return-Path: <linux-kernel-owner+w=401wt.eu-S932258AbXAQK0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbXAQK0t (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 05:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXAQK0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 05:26:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52004 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932258AbXAQK0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 05:26:48 -0500
Date: Wed, 17 Jan 2007 11:25:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix emergency reboot: call reboot notifier list if possible
Message-ID: <20070117102510.GA20917@elte.hu>
References: <20070117091319.GA30036@elte.hu> <20070117092233.GA30197@flint.arm.linux.org.uk> <20070117093917.GA7538@elte.hu> <20070117020343.8622e44d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117020343.8622e44d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -3.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.3 required=5.9 tests=ALL_TRUSTED autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Making it dependent upon CONFIG_PREEMPT seems a bit sucky.  Perhaps 
> pass in some "you were called from /proc/sysrq-trigger" notification?

looks quite invasive to the whole sysrq interfaces, it trickles all the 
way down into sysrq.c's handler prototype, affecting 20 prototypes. 
Worth the trouble?

> Also, there are ways of telling if the kernel has oopsed (oops 
> counter, oops_in_progress, etc) which should perhaps be tested.

i'm not sure. Should we perhaps forget this patch and only do the 
i386/x86_64 VMX patch i sent?

> Or just learn to type `reboot -fn' ;)

well, emergency_reboot() might also be called from panic(), if someone 
sets panic_timeout, resulting in a similar hang. It might be called from 
a serial console on a soft-locked-up system, having no physical access 
to the system. Having a hung reboot in that scenario is not really 
productive.

	Ingo
