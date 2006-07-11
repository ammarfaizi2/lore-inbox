Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWGKNHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWGKNHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWGKNHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:07:45 -0400
Received: from ns1.suse.de ([195.135.220.2]:37346 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750749AbWGKNHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:07:44 -0400
From: Andi Kleen <ak@suse.de>
To: "Joachim Deguara" <joachim.deguara@amd.com>
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Date: Tue, 11 Jul 2006 15:07:39 +0200
User-Agent: KMail/1.9.3
Cc: "Mark Langsdorf" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com> <p73fyhdpqe1.fsf@verdi.suse.de> <1152622554.4489.32.camel@lapdog.site>
In-Reply-To: <1152622554.4489.32.camel@lapdog.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111507.39079.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Jul 11 21:23:35 gradient kernel: CPU 2: Syncing TSC to CPU 0.
> Jul 11 21:23:35 gradient kernel: CPU 2: synchronized TSC with CPU 0
> (last diff -91 cycles, maxerr 621 cycles)

> Jul 11 21:23:35 gradient kernel: CPU 3: Syncing TSC to CPU 0.
> Jul 11 21:23:35 gradient kernel: CPU 3: synchronized TSC with CPU 0
> (last diff -122 cycles, maxerr 1129 cycles)

This means the CPUs diverged between 500 and 1100 cycles in the night.
This can already cause severe timing problems with the clock going 
backwards if a task switches CPUs - and there are many programs that 
don't like that. If the system is up longer it will be worse.

The only way to possibly make the concept work would be regular TSC resyncs
during runtime, but I think I would prefer using per CPU TSC offsets
using RDTSCP instead because they should be able to tolerate arbitary
shifts.

-Andi

