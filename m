Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVBKItV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVBKItV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVBKItV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:49:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10628 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262003AbVBKItQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:49:16 -0500
Date: Fri, 11 Feb 2005 09:48:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211084843.GA3980@elte.hu>
References: <420C25D6.6090807@bigpond.net.au> <200502110341.j1B3fS8o017685@localhost.localdomain> <20050211065753.GE15058@waste.org> <20050211075417.GA2287@elte.hu> <20050211082536.GF15058@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211082536.GF15058@waste.org>
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


* Matt Mackall <mpm@selenic.com> wrote:

> Here's Chris' patch for reference:
> 
> http://groups-beta.google.com/group/linux.kernel/msg/6408569e13ed6e80

how does this patch solve the separation of 'negative nice values' and
'RT priority rlimits'? In one piece of code it handles the rlimit value
as a 0-39 nice value, in another place it handles it as a limit for a
1-100 RT priority range. The two ranges overlap and have nothing to do
with each other. [*]

anyway, as long as it doesnt touch the scheduler runtime code (and it
doesnt), both types of solutions are fine to me - it's basically the
security-subsystem people's call.

if the patch solves the negative-nice-value and the RT-priority issues
at once, then it indeed looks more flexible (and more generic) than the
LSM solution. [**]

	Ingo

[*]  one acceptable way to 'merge' the two priority ranges would be to
     introduce a unified priority range of 0-139: 0-39 would be for nice
     values while 40-139 would be for RT priorities 1-99. NOTE: due to
     rlimit semantics (users can always lower them without any security
     checks), value 39 _must_ denote nice -20 and value 0 must denote
     nice +19. I.e. it must strictly in increasing priority order.

[**] in fact, the 'Gnome problem' wrt. suid/gid binaries would be solved 
     via the rlimit too.
