Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVCJJyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVCJJyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVCJJyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:54:46 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:3223 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262410AbVCJJym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:54:42 -0500
Date: Thu, 10 Mar 2005 04:54:41 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net>
 <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Mar 2005, Steven Rostedt wrote:

> The short term fix is probably to put back the preempt_disables, the long
> term is to get rid of these stupid bit_spin_lock busy loops.
>

Doing a quick search on the kernel, it looks like only kjournald uses the
bit_spin_locks. I'll start converting them to spinlocks. The use seems to
be more of a hack, since it is using bits in the state field for locking,
and these bits aren't used for anything else.

-- Steve
