Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032027AbWLGLJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032027AbWLGLJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032034AbWLGLJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:09:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40433 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032027AbWLGLJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:09:56 -0500
Date: Thu, 7 Dec 2006 12:08:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, ak@suse.de
Subject: Re: [patch] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
Message-ID: <20061207110816.GC11207@elte.hu>
References: <20061206223025.GA17227@elte.hu> <200612061857.30248.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612061857.30248.len.brown@intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Len Brown <len.brown@intel.com> wrote:

> c. disable the NMI whenever the ACPI interpeter is running
>    (who knows, maybe this isn't limited to the _INI case, but
>     could cause a hang at some other time -- only the
>     BIOS AML writers knows....)

i have tested this by forcing the NMI frequency to 10,000 per second, 
and never saw any other problem. So at least this particular laptop 
should be OK.

So i /think/ this should be enough - the _INI case should be limited to 
bootup - or can it trigger during module load too? The IO-APIC based NMI 
watchdog should really only involve the southbridge (whose 
initialization package has this problem, in my guesstimation - do you 
agree?) and not random other devices - so once we have booted up we 
should be fine from this particular issue. acpi_nmi_disable()/enable() 
does a cross-IPI to all CPUs, so it can be quite heavy-handed - i'm not 
sure we want it for every interpreter invocation.

	Ingo
