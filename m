Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVDYWbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVDYWbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVDYWbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:31:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54966 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261266AbVDYWbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:31:34 -0400
Date: Mon, 25 Apr 2005 15:31:25 -0700
Message-Id: <200504252231.j3PMVPTb010573@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: handle iret faults better
In-Reply-To: Linus Torvalds's message of  Monday, 25 April 2005 08:55:22 -0700 <Pine.LNX.4.58.0504250849370.18901@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Tropical fission
   (2) Delinquent bugs
   (3) Onerous golden reservation livers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why don't you just do
> 
> 	pushl $0
> 	pushl $do_iret_error
> 	jmp error_code

I quote from the comment in the code:

								   We want
 * to turn it into a signal.  To make that signal's info exactly match what
 * this same kind of fault in a user instruction would show, the fixup
 * needs to know the trapno and error code.  But those are lost when we get
 * back to the fixup entrypoint.  

The error code is not always 0, it might be a bad segment value.  I think
the kernel ought to give accurate information about the fault consistently
no matter where it occurs, so I did not want to pretend the error code is 0.

I certainly think it would be cleaner if the fixup code could access the
fault information directly.  However, it's arguably not so clean to have a
do_iret_error function that replicates the work of do_trap and
do_general_protection.  The iret case is really not so much a special case
for what to do, but a special case for how you determine whether the
vanilla user-mode thing is done or the vanilla kernel-mode thing is done.


Thanks,
Roland
