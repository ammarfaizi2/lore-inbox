Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVBDRjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVBDRjU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVBDReg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:34:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62890 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265552AbVBDRap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:30:45 -0500
Date: Fri, 4 Feb 2005 18:30:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kevin Hilman <kevin@hilman.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050204173027.GB30196@elte.hu>
References: <20050204100347.GA13186@elte.hu> <83hdksxsi0.fsf@www2.muking.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83hdksxsi0.fsf@www2.muking.org>
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


* Kevin Hilman <kevin@hilman.org> wrote:

> What I've done for now is to use sema_init_nocheck() to disable the
> checking in the case of a counting semaphore, but I remember seeing
> discussion in an earlier thread about creating a separate counting
> semaphore type.  Is this still planned?

the nocheck variant is the counting semaphore in essence. I removed the
counting semaphore implementation because it caused more problems than
it solved - but it can be reintroduced later.

> [*] For example, an open semaphore being down'ed and thus acquired and
> the same thread doing a down() again before another thread has a
> chance to up() the semaphore. 

yeah, these are cases where the code is better off using completions
anyway. Thomas Gleixner had a good bunch of patches to convers such
semaphore use to completions - the most necessary ones are in -RT, and i
hope he'll submit the whole bunch upstream after 2.6.11 is out :-)

	Ingo
