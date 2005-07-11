Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVGKP7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVGKP7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGKP5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:57:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28622 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262086AbVGKPy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:54:59 -0400
Date: Mon, 11 Jul 2005 17:55:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [no more]
Message-ID: <20050711155503.GA21762@elte.hu>
References: <20050703133738.GB14260@elte.hu> <1120428465.21398.2.camel@cmn37.stanford.edu> <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org> <20050707194914.GA1161@elte.hu> <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org> <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org> <20050708085253.GA1177@elte.hu> <28798.195.245.190.94.1120815616.squirrel@www.rncbc.org> <20050708095600.GA5910@elte.hu> <63108.195.245.190.94.1121094757.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63108.195.245.190.94.1121094757.squirrel@www.rncbc.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> After several trials, with CONFIG_PROFILING=y and profile=1 
> nmi_watchdog=2 as boot parameters, I'm almost convinced I'm doing 
> something wrong :)
> 
> - `readprofile` always just outputs one line:
> 
>      0 total                                    0.0000
> 
> - `readprofile -a` gives the whole kernel symbol list, all with zero times.
> 
> Is there anything else I can check around here?

it means that the NMI watchdog was not activated - i.e. the 'NMI' counts 
in /proc/interrupts do not increase. Do you have LOCAL_APIC enabled in 
the .config? If yes and if nmi_watchdog=1 does not work either then it's 
probably not possible to activate the NMI watchdog on your box. In that 
case try nmi_watchdog=0, that should activate normal profiling. (unless 
i've broken it via the profile-via-NMI changes ...)

	Ingo
