Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUGSMEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUGSMEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 08:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUGSMEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 08:04:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59776 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265031AbUGSMEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 08:04:31 -0400
Date: Mon, 19 Jul 2004 13:59:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       rlrevell@joe-job.com, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040719115952.GA13564@elte.hu>
References: <20040713114829.705b9607.akpm@osdl.org> <20040713213847.GH974@dualathlon.random> <20040713145424.1217b67f.akpm@osdl.org> <20040713220103.GJ974@dualathlon.random> <20040713152532.6df4a163.akpm@osdl.org> <20040713223701.GM974@dualathlon.random> <20040713154448.4d29e004.akpm@osdl.org> <20040713225305.GO974@dualathlon.random> <20040713160628.596b96a3.akpm@osdl.org> <20040713231803.GP974@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713231803.GP974@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.524, required 5.9,
	autolearn=not spam, BAYES_01 -1.52
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> As Ingo basically showed (and I agree), all current might_sleep seems
> suitable to be converted to cond_resched. I checked all them and
> there's none that seems to be called in a loop for no good reason. the
> ones in the semaphore are quite nice too since it's better to schedule
> right before taking the semaphore than after getting it. The one in
> the semaphore and in the copy-user are the only place where preempt
> seems to be lower overhead but in most other places a spinlock is
> being taken very near to the cond_resched.

yes. Btw., i'm not sure whether you've noticed but last week i've also
created a 'clean' variant of the patch. The latest version against -mm
is:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-clean-2.6.7-mm7-H4

this one doesnt have any of the debugging/development helpers and
switches. I have still made it a .config option. Note how minimal the
patch became this way.

	Ingo
