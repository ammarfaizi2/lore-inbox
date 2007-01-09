Return-Path: <linux-kernel-owner+w=401wt.eu-S1751202AbXAIJJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbXAIJJ1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbXAIJJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:09:27 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:58310 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXAIJJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:09:26 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: mutex ownership (was: Re: [PATCH 19/24] Unionfs: Helper macros/inlines)
Date: Tue, 9 Jan 2007 10:09:29 +0100
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       arjan <arjan@infradead.org>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> <20070108132817.5c9a30d6.akpm@osdl.org> <1168333376.12503.22.camel@twins>
In-Reply-To: <1168333376.12503.22.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701091009.30063.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. Januar 2007 10:02 schrieb Peter Zijlstra:
> On Mon, 2007-01-08 at 13:28 -0800, Andrew Morton wrote:
> 
> > Please use mutexes where possible.  Semaphores should only be used when
> > their counting feature is employed.  And, arguably, in situations where a
> > lock is locked and unlocked from different threads, because this presently
> > triggers mutex debugging warnings, although we should find a way of fixing
> > this in the mutex code.
> 
> Its a fundamental property of a mutex, not a shortcoming. A mutex has an
> owner, the one that takes and releases the resource. This allows things
> such as Priority Inheritance to boost owners.
> 
> 'fixing' this takes away much of what a mutex is.
> 
> That said, it seems some folks really want this to happen, weird as it
> may be. I'm not sure if all these cases are because of wrong designs. A
> possible extension to the mutex interface might be something like this:
> 
>   mutex_pass_owner(struct task_struct *task);
> 
> which would be an atomic unlock/lock pair where the current task
> releases the resource and the indicated task gains it. However it must
> be understood that from the POV of 'current' this should be treated as
> an unlock action.

This won't help if I want to release from an interrupt handler or tasklet.

	Regards
		Oliver
