Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262232AbSI1RAK>; Sat, 28 Sep 2002 13:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262251AbSI1RAK>; Sat, 28 Sep 2002 13:00:10 -0400
Received: from packet.digeo.com ([12.110.80.53]:22682 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262232AbSI1RAJ>;
	Sat, 28 Sep 2002 13:00:09 -0400
Message-ID: <3D95E14D.9134405C@digeo.com>
Date: Sat, 28 Sep 2002 10:05:17 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context...
References: <20020927233044.GA14234@kroah.com> <1033174290.23958.17.camel@phantasy> <20020928145418.GB50842@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 17:05:17.0947 (UTC) FILETIME=[387AC4B0:01C26711]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> 
> On Fri, Sep 27, 2002 at 08:51:30PM -0400, Robert Love wrote:
> 
> > Note this has nothing to do with kernel preemption.  IDE explicitly
> > sleeps while purposely holding a lock.
> >
> > It is just we do not have the ability to measure atomicity w/o
> > preemption enabled - e.g. the debugging only works when it is enabled.
> 
> Would it be particularly difficult to separate this debug tool from the
> feature ? Surely we could make it so that CONFIG_PREEMPT depends on
> CONFIG_MIGHT_SLEEP or whatever, and just adds the actual ability to
> reschedule.

We need a standalone CONFIG_MIGHT_SLEEP.  I sinfully hooked it
to CONFIG_DEBUG_KERNEL (it's not obvious why CONFIG_DEBUG_KERNEL
exists actually).

So yes, you could make CONFIG_MIGHT_SLEEP mutually exclusive
with CONFIG_OPROFILE. But that would make people look at you
suspiciously.

> I have a bit of a problem with __might_sleep because I call sleepable
> stuff holding a spinlock (yes, it is justified, and yes, it is safe
> afaics, at least with PREEMPT=n)

I'm looking at you suspiciously.  How come?
