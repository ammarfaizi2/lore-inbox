Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267393AbUHENGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267393AbUHENGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267674AbUHENEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:04:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35516 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267664AbUHENDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:03:44 -0400
Date: Thu, 5 Aug 2004 12:59:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Message-ID: <20040805105923.GA20568@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407> <20040805103409.GA20171@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805103409.GA20171@elte.hu>
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

> but, couldnt there be more sharing between futex.c and fusyn.c? In
> particular on the API side, why arent all these ops done as an
> extension to sys_futex()? That would keep the glibc part much simpler
> (and more compatible) as well. [...]

i believe the key to integration of this feature is to try to make it
used by normal (non-RT) apps as much as possible. I.e. try to make
current futexes a subset of fusyn.c and to merge the two APIs if
possible (essentially renaming your fusyn.c to futex.c and implementing
the futex API). Is this possible without noticeable performance overhead
(and without too many special-cases)?

such an approach would ensure that key portions of the code would be
triggered by everyday apps. Developers wouldnt break the feature every
other day, etc. Deadlock detection and priority boosting might not be
tested this way, but the basic locking/waking/VM-keying mechanism sure
could be.

	Ingo
