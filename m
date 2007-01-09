Return-Path: <linux-kernel-owner+w=401wt.eu-S1751106AbXAIGpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbXAIGpI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 01:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbXAIGpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 01:45:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49616 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbXAIGpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 01:45:07 -0500
Date: Tue, 9 Jan 2007 07:41:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com, Arjan van de Ven <arjan@infradead.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock()
Message-ID: <20070109064113.GB5569@elte.hu>
References: <20070104001420.GA32440@m.safari.iki.fi> <20070107213734.GS44411608@melbourne.sgi.com> <20070108155636.a68dce33.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108155636.a68dce33.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Revert bd_mount_mutex back to a semaphore so that xfs_freeze -f 
> > /mnt/newtest; xfs_freeze -u /mnt/newtest works safely and doesn't 
> > produce lockdep warnings.
> 
> Sad.  The alternative would be to implement 
> mutex_unlock_dont_warn_if_a_different_task_did_it().  Ingo?  Possible?

i'd like to avoid it as much as i'd like to avoid having to add 
spin_unlock_dont_warn_if_a_different_task_did_it(). Unlocking by a 
different task is usually a sign of messy locking and bugs lurking. Is 
it really true that XFS's use of bd_mount_mutex is safe and justified?

	Ingo
