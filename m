Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVCWGiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVCWGiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVCWGiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:38:23 -0500
Received: from mx1.elte.hu ([157.181.1.137]:4296 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261189AbVCWGiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:38:17 -0500
Date: Wed, 23 Mar 2005 07:37:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323063727.GA32199@elte.hu>
References: <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323063317.GB31626@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the 'migrate read count' solution seems more promising, as it would
> keep other parts of the RCU code unchanged. [ But it seems to break
> the nice 'flip pointers' method you found to force a grace period. If
> a 'read section' can migrate from one CPU to another then it can
> migrate back as well, at which point it cannot have the 'old' pointer.
> Maybe it would still work better than no flip pointers. ]

the flip pointer method could be made to work if we had a NR_CPUS array
of 'current RCU pointer' values attached to the task - and that array
would be cleared if the task exits the read section. But this has memory
usage worries with large NR_CPUS. (full clearing of the array can be
avoided by using some sort of 'read section generation' counter attached
to each pointer)

	Ingo
