Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVGVFCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVGVFCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 01:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVGVFCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 01:02:47 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:17488 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262035AbVGVFCr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 01:02:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qiUgk258Y+aChz/fFLKBhVW8MmVNpafwTIuAqjoOmRNYek2ufADIZtYRcmT21z9Ks0iaDn679egfq+fWU5EMvERk+J6MmeTGCcbRUcMWfiZG1990xY9Kurf8zf4wyo9m/XKclktNtK4AC9ONIf5hmQc5kARoJ3SHy1bK0hCafCs=
Message-ID: <29495f1d050721220276c8733c@mail.gmail.com>
Date: Thu, 21 Jul 2005 22:02:46 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch,rfc] Support for touchscreen on sharp zaurus sl-5500
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
       vojtech@suse.cz
In-Reply-To: <20050722012814.GB6758@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050721052455.GB7849@elf.ucw.cz>
	 <29495f1d05072117247817c5d1@mail.gmail.com>
	 <20050722012814.GB6758@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/05, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > > +               set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> > > +               schedule_timeout(HZ / 100);
> > > +               if (signal_pending(tsk))
> > > +                       break;
> >
> > You specifically allow SIGKILL, but then sleep uninterruptibly? And
> > then you check if signal_pending() :) I think you may want
> > TASK_INTERRUPTIBLE? Or, go one better and use msleep_interruptible(),
> > as I don't see any wait-queues in the immediate area of this code...
> 
> Okay, I think this should be uninterruptible. The signal can be
> delivered during next interruptible sleep. Fixes.

Good point. But the signal_pending() check after that interruptible
sleep (which deterministically comes after this one) takes care of the
break, doesn't it? I guess you can (maybe already have done so...) get
rid of the signal_pending() check after the uninterruptible sleep. And
then go ahead and make this an msleep(10) call  and the other one (in
the same function) an msleep_interruptible() call ;)

Thanks,
Nish
