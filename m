Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWBTAo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWBTAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWBTAo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:44:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64673 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751153AbWBTAo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:44:26 -0500
Date: Mon, 20 Feb 2006 01:44:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: suspend2 review [was Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)]
Message-ID: <20060220004407.GK15608@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219234212.GA1762@elf.ucw.cz> <200602191935.36844.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602191935.36844.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 19-02-06 19:35:36, Dmitry Torokhov wrote:
> On Sunday 19 February 2006 18:42, Pavel Machek wrote:
> > --- linux-2.6.15-1/drivers/input/serio/serio.c  2006-01-03 15:08:26.000000000 +1000
> > +++ build-2.6.15.1/drivers/input/serio/serio.c  2006-01-23 21:38:28.000000000 +1000
> > @@ -314,6 +314,12 @@
> >  
> >                 serio_remove_duplicate_events(event);
> >                 serio_free_event(event);
> > +
> > +               if (unlikely(todo_list_active())) {
> > +                       up(&serio_sem);
> > +                       try_todo_list();
> > +                       down(&serio_sem);
> > +               }
> >         }
> >  
> >         up(&serio_sem);
> > 
> > What is this?
> > 
> 
> I think it is a leftover from when serio and gameport cores were not
> "swsusp friendly" and were not releasing semaphore untill all pending
> messages have been processed. If you remember swsusp used to fail in
> this case. It can be safely dropped now.
> 
> Overall as you noted alot of changes in Nigel's patch are useable outside
> of swsuspend2 so it's intrusiveness is not as big as you making it appear.

Yes, some of them are usaeable outside. But many of them were
attempted outside and vetoed for whatever reason :-(.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
