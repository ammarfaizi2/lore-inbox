Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVKLUBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVKLUBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKLUBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:01:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25806 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932493AbVKLUBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:01:14 -0500
Date: Sat, 12 Nov 2005 21:01:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Bj?rn Mork <bmork@dod.no>, linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051112200103.GB1667@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <200511121023.23245.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511121023.23245.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have had swsusp working for ages on a IBM Thinkpad T42, but since
> > 2.6.14 it hasn't been willing to resume anymore.  Both suspending to
> > disk and ACPI S3 still works. 
> > 
> > Output of dmesg below (running 2.6.15-rc1). Notice the line:
> > 
> >   Restarting tasks...<6> Strange, kseriod not stopped
> > 
> > I guess that's the explanation.  Could it be the new TrackPoint
> > driver, maybe?  (This PC has both a TrackPoint and a Touchpad).
> >
> 
> This is unlikely... serio has the proper support for freezing as
> far as I understand:
> 
> static int serio_thread(void *nothing)
> {
>         do {
>                 serio_handle_events();
>                 wait_event_interruptible(serio_wait,
>                         kthread_should_stop() || !list_empty(&serio_event_list));
>                 try_to_freeze();
>         } while (!kthread_should_stop());
> 
>         printk(KERN_DEBUG "serio: kseriod exiting\n");
>         return 0;
> }
> 
> Pavel, any ideas?

No, sorry. I'll try to reproduce it here (x32 notebook), but...

							Pavel
-- 
Thanks, Sharp!
