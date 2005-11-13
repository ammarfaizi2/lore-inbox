Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVKMHRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVKMHRE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 02:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVKMHRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 02:17:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12776 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751355AbVKMHRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 02:17:02 -0500
Date: Sun, 13 Nov 2005 08:17:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ia64 SN2 - migration costs: 1) nearly zero 2) BUG 3) repeated
Message-ID: <20051113071716.GA31075@elte.hu>
References: <20051112135410.3eef5641.pj@sgi.com> <20051112144949.3b331aa1.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051112144949.3b331aa1.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> I turned on migration_debug=3 at boot, enabled CONFIG_PREEMPT and some 
> other CONFIG DEBUG options, and captured the output from the tty 
> console instead of via the /var/log/messages file.  This resulted in 
> the following.  Now I don't see the BUG, and the cost matrix makes 
> more sense (not all 0's), and the matrix output is not repeated.  I 
> don't understand why.  Feel free to ask me to try various 
> combinations, Ingo, if this doesn't make sense to you either.

hm, these calibration results looks quite sane. Could you try 
migration_debug=3 with the .config that failed before? (if it doesnt 
fail, could you re-check it still fails with migration_debug=2?) Zero 
results in the cost matrix usually are a sign of time resolution 
problems - but that shouldnt be an issue on ia64 which should have a 
globally synced TSC, right?

until these problems are solved, you should be able to work around it by 
booting with the migration_cost=0,7512036,45850376 boot option.

you can work around the warning message via changing the:

	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = smp_processor_id();

line to:

	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = raw_smp_processor_id();

i'll do the correct fix.

	Ingo
