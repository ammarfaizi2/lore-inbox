Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbTI2SQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTI2SFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:05:30 -0400
Received: from web40907.mail.yahoo.com ([66.218.78.204]:11654 "HELO
	web40907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264125AbTI2SBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:01:51 -0400
Message-ID: <20030929180149.93047.qmail@web40907.mail.yahoo.com>
Date: Mon, 29 Sep 2003 11:01:49 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
To: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200309291254.22966.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Torokhov,

--- Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Monday 29 September 2003 12:49 pm, Bradley Chapman wrote:
> > Mr. Torokhov,
> >
> > --- Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > On Monday 29 September 2003 11:41 am, Andrew Morton wrote:
> > > > Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> > > > > I am experiencing defunct event/0 kernel daemons under
> > > > > 2.6.0-test6-mm1 with synaptics_drv 0.11.7, Dmitry Torokhov's
> > > > > gpm-1.20 with synaptics support, and XFree86 4.3.0-10. Moving the
> > > > > touchpad in either X or with gpm causes defunct event/0 processes
> > > > > to be created.
> > > >
> > > > Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?
> > > >
> > > > You could try reverting synaptics-reconnect.patch, and then
> > > > serio-reconnect.patch from
> > > >
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0
> > > >-tes t6/2.6.0-test6-mm1/broken-out
> > >
> > > Input subsystem uses only one kernel thread called kseriod, not
> > > eventsX. I think it's not synaptics/serio reconnect but other patch
> > > you mentioned (call_usermodehelper-retval-fix-2.patch)
> >
> > OK. I'll try reverting that one too. I'm inclined to agree that it
> > could be the problem, because I noticed one more thing before I
> > rebooted to 2.6.0-test6.
> >
> > I recently installed the latest RH9 hotplug packages from the hotplug
> > Sourceforge website. Under 2.6.0-test6-mm1 the hotplug initscript
> > leaves a defunct hotplug process along with the other events/0 defunct
> > processes. Does this mean anything?
> >
> > The hotplug version is hotplug-2003_08_05-1.
> 
> Othe people reported that reverting call_suserhelper patch resolved their
> eventsX/hotplug zombies problem.

Yup! I'm running 2.6.0-test6-mm1 with synaptics-reconnect, serio-reconnect
and call_usermodehlper-retval-fix reverted, and no more zombies. It was the
call_usermodehelper reversion that fixed it. I looked at the patch and it
appears to mess with SIGCHLD signal handling and the kernel stack. How would
that mess up hotplug and the events/0 kernel thread?

> 
> Btw, GPM does not work with test6 or test6-mm yet, I will hopefully have
> the upated version later tonight.

Yes it does ;-)

On both 2.6.0-test6, 2.6.0-test6-mm1 full and 2.6.0-test6-mm1 minus the three
patches I mentioned above, the touchpad does work (at least it moves the cursor
and clicks). 

> 
> Dmitry

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
