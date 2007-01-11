Return-Path: <linux-kernel-owner+w=401wt.eu-S932673AbXAKWQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbXAKWQL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 17:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbXAKWQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 17:16:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51281 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932675AbXAKWQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 17:16:09 -0500
Date: Thu, 11 Jan 2007 17:14:46 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 2.6.20-rc4 4/4][RFC] sys_futex64 : allows 64bit futexes
Message-ID: <20070111221446.GF29911@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <45A3B330.9000104@bull.net> <45A3C1F6.4020503@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A3C1F6.4020503@bull.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 05:25:26PM +0100, Pierre Peiffer wrote:
> This latest patch is an adaptation of the sys_futex64 syscall provided in 
> -rt
> patch (originally written by Ingo). It allows the use of 64bit futex.
> 
> I have re-worked most of the code to avoid the duplication of the code.
> 
> It does not provide the functionality for all architectures, and thus, it 
> can
> not be applied "as is".
> But, again, feedbacks and comments are welcome.

Why do you support all operations for 64-bit futexes?
IMHO PI futexes don't make sense for 64-bit futexes, PI futexes have
hardcoded bit layout of the 32-bit word.  Similarly, FUTEX_WAKE
is not really necessary for 64-bit futexes, 32-bit futex's FUTEX_WAKE
can wake it equally well (it never reads anything, all it cares
is about the futex's address).  Similarly, I don't see a need for
FUTEX_WAKE_OP (and this could simplify the patch quite a lot, no
need to change asm*/futex.h headers at all).
All that's needed is 64-bit FUTEX_WAIT and perhaps FUTEX_CMP_REQUEUE.

	Jakub
