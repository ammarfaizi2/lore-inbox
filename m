Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423853AbWLBM4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423853AbWLBM4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 07:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423857AbWLBM4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 07:56:41 -0500
Received: from www.osadl.org ([213.239.205.134]:64493 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1423847AbWLBM4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 07:56:40 -0500
Subject: Re: [RFC] timers, pointers to functions and type safety
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
In-Reply-To: <20061201172149.GC3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:59:30 +0100
Message-Id: <1165064370.24604.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 17:21 +0000, Al Viro wrote:
> Now, there's another question: how do we get there?  Or, at least, from
> current void (*)(unsigned long) to void (*)(void *)...

I think the real solution should be 

	void (*function)(struct timer_list *timer);

and hand the timer itself to the callback. Most of the timers are
embedded into data structures anyway and for the rest we can easily
build one.

> "A fscking huge patch flipping everything at once" is obviously not an
> answer; too much PITA merging and impossible to review.

There are ~ 500 files affected and this is in the range of cleanups we
did recently at the end of the merge window already. I'd volunteer to
hack this up and keep the patch up to date until the final merge. I have
done that before and I'm not scared about it. The patches are a couple
of lines per file and I do not agree that this is impossible to review. 

	tglx


