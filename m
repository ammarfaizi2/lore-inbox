Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbULHI1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbULHI1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 03:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbULHI1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 03:27:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:1005 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262039AbULHI07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 03:26:59 -0500
Date: Wed, 8 Dec 2004 09:26:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, kernel@kolivas.org
Subject: Re: [PATCH, RFC] protect call to set_tsk_need_resched() by the rq-lock
Message-ID: <20041208082633.GA7720@elte.hu>
References: <200412062339.52695.mbuesch@freenet.de> <20041207131006.GB3710@elte.hu> <200412080031.08490.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412080031.08490.mbuesch@freenet.de>
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


* Michael Buesch <mbuesch@freenet.de> wrote:

> > > The two attached patches (one against vanilla kernel and one
> > > against ck patchset) moves the rq-lock a few lines up in
> > > scheduler_tick() to also protect set_tsk_need_resched().
> > > 
> > > Is that neccessary?
> > 
> > scheduler_tick() is a special case, 'current' is pinned and cannot
> > go away, nor can it get off the runqueue.
>
> Can you explain in short, why this is the case, please? I don't really
> get behind it. How are the two things enforced?

'current' is the currently executing task and as such it wont get moved
off the runqueue. The only way to leave the runqueue is to execute
schedule() [or to be preempted].

	Ingo
