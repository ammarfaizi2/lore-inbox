Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269504AbUJVHCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269504AbUJVHCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUJVHBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:01:45 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10148
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269504AbUJVGxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 02:53:31 -0400
Subject: Re: [PATCH] Completion API extension
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200410212118.32981.dtor_core@ameritech.net>
References: <1098289871.12223.1603.camel@thomas>
	 <200410212118.32981.dtor_core@ameritech.net>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098427528.8955.45.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 08:45:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 04:18, Dmitry Torokhov wrote:

Hi,

it's resubmitted in a correct version already.

Thanks,

tglx


> Hi,
> 
> On Wednesday 20 October 2004 11:31 am, Thomas Gleixner wrote:
> > +unsigned long fastcall __sched
> > +wait_for_completion_interruptible_timeout(struct completion *x,
> > +                                         unsigned long timeout)
> > +{
> > +       might_sleep();
> > +
> > +       spin_lock_irq(&x->wait.lock);
> > +       if (!x->done) {
> > +               DECLARE_WAITQUEUE(wait, current);
> > +
> > +               wait.flags |= WQ_FLAG_EXCLUSIVE;
> > +               __add_wait_queue_tail(&x->wait, &wait);
> > +               do {
> > +                       if (signal_pending(current)) {
> > +                               timeout = -ERESTARTSYS;
> > +                               goto out;
> > +                       }
> > +                       __set_current_state(TASK_INTERRUPTIBLE);
> > +                       spin_unlock_irq(&x->wait.lock);
> > +                       schedule();
> 
> 			^^^^^^^^^^^^^^^^^^
> 
> schedule_timeout perhaps?
> 

