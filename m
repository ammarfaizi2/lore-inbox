Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUHSVCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUHSVCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHSVCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:02:14 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:41673 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S267393AbUHSU7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:59:54 -0400
Date: Thu, 19 Aug 2004 13:59:43 -0700
Message-Id: <200408192059.i7JKxh4F024918@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent cleanup
In-Reply-To: OGAWA Hirofumi's message of  Thursday, 19 August 2004 13:26:26 +0900 <87oel7eost.fsf@devron.myhome.or.jp>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland McGrath <roland@redhat.com> writes:
> 
> >  void
> >  notify_parent(struct task_struct *tsk, int sig)
> 
> [...]
> 
> > +	BUG_ON(tsk->state != TASK_STOPPED);
> 
> task->state is changed anytime, right?  Although the window is small,
> I think we should remove it at least for right now.

You are right.  That assertion is not safe.  I put it there intending just
to ensure that all the code paths were the stopping ones, as all the extant
ones are.  But in fact there is the race you mention, and the test should
not be there.


Thanks,
Roland
