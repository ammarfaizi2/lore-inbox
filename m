Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUIPNrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUIPNrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUIPNrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:47:13 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:4093 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268095AbUIPNq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:46:26 -0400
Subject: Re: get_current is __pure__, maybe __const__ even
From: Albert Cahalan <albert@users.sf.net>
To: Andi Kleen <ak@muc.de>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <m3llfaya29.fsf@averell.firstfloor.org>
References: <2ER4z-46B-17@gated-at.bofh.it>
	 <m3llfaya29.fsf@averell.firstfloor.org>
Content-Type: text/plain
Organization: 
Message-Id: <1095342181.3866.1316.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Sep 2004 09:43:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 02:58, Andi Kleen wrote:
> Albert Cahalan <albert@users.sf.net> writes:
> 
> > Andi Kleen writes:
> >
> >> Please CSE "current" manually. It generates
> >> much better code on some architectures
> >> because the compiler cannot do it for you.
> >
> > This looks fixable.
> 
> I tried it some years ago, but I ran into problems with the scheduler
> and some other code and dropped it.

Since then, have you changed:

a. the minimum required compiler version?
b. the clobbers on your switch_to asm?

If not, maybe you should.

> One problem is that gcc doesn't have a "drop all const/pure
> cache values" barrier. Without this I don't think it can be 
> safely implemented.

That's only if gcc can find some place to
hide state which will contaminate another task.
Where could that be? Remember, arm works.

Also, glibc works, with per-thread errno:

/* Function to get address of global `errno' variable.  */
extern int *__errno_location (void) __THROW __attribute__ ((__const__));

/* Function to get address of global `h_errno' variable.  */
extern int *__h_errno_location (void) __THROW __attribute__ ((__const__));


