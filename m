Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUJLXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUJLXTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJLXTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:19:33 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:684 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S268079AbUJLXSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:18:53 -0400
From: David Brownell <david-b@pacbell.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Proposed fix for PM deadlock on dpm_sem
Date: Tue, 12 Oct 2004 16:19:20 -0700
User-Agent: KMail/1.6.2
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <16747.20196.293232.983056@cargo.ozlabs.ibm.com>
In-Reply-To: <16747.20196.293232.983056@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410121619.20360.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 8:26 pm, Paul Mackerras wrote:
> 
> This patch removes the deadlocks by adding a new semaphore, called
> dpm_list_sem, which serializes changes to the power management lists
> (dpm_active et al.).  We hold dpm_sem during calls to suspend_device
> and resume_device but not dpm_list_sem.

Looks pleasantly simple, I'll have to try it!  I recall that Patrick's
patch also removed these comments ... methinks they're the
reason I wanted to avoid patching this myself, they make it sound
like there's a big deal.  Of course, (a) is one side of the bug so
it's got to go, but the other two were less obvious to me.   It
looked like (b) was undesirable prevention-of-concurrency,
but (c) might matter for the system-suspend cases.

- Dave


> - *	Note this function leaves dpm_sem held to
> - *	a) block other devices from registering.
> - *	b) prevent other PM operations from happening after we've begun.
> - *	c) make sure we're exclusive when we disable interrupts.

