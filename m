Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUHEN5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUHEN5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267698AbUHENzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:55:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15317 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267694AbUHENx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:53:29 -0400
Date: Thu, 5 Aug 2004 12:34:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Message-ID: <20040805103409.GA20171@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
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


* Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:

> Fusyn aims to provide primitives to solve a bunch of gaps in POSIX
> compliance related to mutexes, conditional variables and semaphores,
> POSIX Advanced real-time support as well as adding mutex robustness
> (to dying owners) and deep deadlock checking.

the sched.c bits look clean enough.

i like the generic concept - keeping the userspace fast-path for
lock/unlock, like for futexes, and registering/unregistering a lock via
the kernel.

but, couldnt there be more sharing between futex.c and fusyn.c? In
particular on the API side, why arent all these ops done as an extension
to sys_futex()? That would keep the glibc part much simpler (and more
compatible) as well. You'd still get all the glory of implementing true
priority inheritance and advanced RT-locking for Linux :-)

or are the two interfaces way too different?

	Ingo
