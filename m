Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVAZKJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVAZKJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 05:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVAZKJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 05:09:38 -0500
Received: from mx1.elte.hu ([157.181.1.137]:60843 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262415AbVAZKJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 05:09:00 -0500
Date: Wed, 26 Jan 2005 11:08:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
Message-ID: <20050126100846.GB8720@elte.hu>
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6C797.80403@bigpond.net.au>
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


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> Oops, after rereading the patch, a task that set its RT_CPU_RATIO
> rlimit to zero wouldn't be escaping the mechanism at all.  It would be
> suffering maximum throttling. [...]

my intention was to let 'limit 0' mean 'old RT semantics' - i.e. 'no RT
CPU time for unprivileged tasks at all', and only privileged tasks may
do it and then they'll get full CPU time with no throttling.

so in that context your observation highlights another bug, which i
fixed in the -D7 patch available from the usual place:

  http://redhat.com/~mingo/rt-limit-patches/

not doing the '0' exception would make it harder to introduce the rlimit
in a compatible fashion. (My current thinking is that the default RT_CPU
rlimit should be 0.)

	Ingo
