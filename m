Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUHaGic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUHaGic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUHaGib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:38:31 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:47308 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S266821AbUHaGhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:37:47 -0400
Date: Mon, 30 Aug 2004 23:37:42 -0700
Message-Id: <200408310637.i7V6bgSD000489@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Jakub Jelinek <jakub@redhat.com>
X-Fcc: ~/Mail/linus
Cc: Michael Kerrisk <mtk-lkml@gmx.net>, torvalds@osdl.org, akpm@osdl.org,
       drepper@redhat.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [PATCH] waitid system call
In-Reply-To: Jakub Jelinek's message of  Tuesday, 31 August 2004 02:26:56 -0400 <20040831062656.GU11465@devserv.devel.redhat.com>
X-Shopping-List: (1) Tenacious delusions
   (2) Harmonic beatific travesty
   (3) Glamorous console detectors
   (4) Lunar ponds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it really necessary to check the exit code after each put_user?
> 	if (!retval && access_ok(VERIFY_WRITE, infop, sizeof(*infop)))) {
> 		retval = __put_user(0, &infop->si_signo);
> 		retval |= __put_user(0, &infop->si_errno);
> 		retval |= __put_user(0, &infop->si_code);
> 		retval |= __put_user(0, &infop->si_pid);
> 		retval |= __put_user(0, &infop->si_uid);
> 		retval |= __put_user(0, &infop->si_status);
> 	}
> is what kernel usually does when filling multiple structure members.

That is certainly fine by me, but shouldn't that be setting retval to
-EFAULT if access_ok fails?  The waitid patch has a couple of other spots
where those several members are filled in and the code uses the several if's.
If one should change I suppose they all should.


Thanks,
Roland
