Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312600AbSDJRAK>; Wed, 10 Apr 2002 13:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312942AbSDJRAJ>; Wed, 10 Apr 2002 13:00:09 -0400
Received: from zero.tech9.net ([209.61.188.187]:31504 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312600AbSDJRAI>;
	Wed, 10 Apr 2002 13:00:08 -0400
Subject: Re: 2.5.8-pre3: kernel BUG at usb.c:849! (preempt_count 1)
From: Robert Love <rml@tech9.net>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>,
        Kernel List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20020410114144.N8314@sventech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 13:00:07 -0400
Message-Id: <1018458007.6524.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-10 at 11:41, Johannes Erdfelt wrote:

> >  <3>error: rmmod[1787] exited with preempt_count 1
> 
> I don't like the looks of that.

That error means a task exited with a nonzero preempt_count, in this
case 1.  This means a lock was held after exit (or, a lock was never
unlocked - e.g. it was dynamic and just deleted, but the lock counting
code can't know that).

In this case it may just be because the task oopsed while holding the
lock and then exited.  This may point to the lock being the BKL since it
would be trivial to have it reschedule and then die while holding it.

While the main point of that error is to point out code that does rude
things with preemption, in this case we probably just have another
problem and this is another sign of it.

	Robert Love

