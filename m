Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVDIEpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVDIEpY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 00:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVDIEpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 00:45:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41927 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261279AbVDIEpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 00:45:18 -0400
Date: Sat, 9 Apr 2005 06:44:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 'BUG: scheduling with irqs disabled' when umounting NFS volume
Message-ID: <20050409044449.GA2857@elte.hu>
References: <1112991311.11000.37.camel@mindpipe> <1112992701.26296.16.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112992701.26296.16.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.111, required 5.9,
	BAYES_00 -4.90, REMOVE_REMOVAL_NEAR 0.79
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> I submitted a fix for this a while ago, I think ..
> interruptible_sleep_on()'s are broken .. 

sleep_on() is a fundamentally broken interface, it only works on UP - 
but there it _does_ rely on the behavior your patch removes. (i.e.  
disabled interrupts until we hit schedule())

the PREEMPT_RT kernel makes the limitations of sleep_on() even more 
apparent. The patch only removes the warning, it doesnt remove the race.  
To remove the race, sleep_on() usage should be converted to something 
else. (e.g. one of the wait_event() variants)

	Ingo
