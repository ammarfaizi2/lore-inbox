Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWANRBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWANRBM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWANRBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:01:12 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:36443 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750994AbWANRBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:01:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
Date: Sat, 14 Jan 2006 12:01:08 -0500
User-Agent: KMail/1.8.3
Cc: Faidon Liambotis <faidon@cube.gr>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <20060114160253.GA1073@elte.hu> <200601141143.05112.dtor_core@ameritech.net> <1137257628.3014.40.camel@laptopd505.fenrus.org>
In-Reply-To: <1137257628.3014.40.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141201.08478.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 11:53, Arjan van de Ven wrote:
> On Sat, 2006-01-14 at 11:43 -0500, Dmitry Torokhov wrote:
> > On Saturday 14 January 2006 11:21, Faidon Liambotis wrote:
> > > Ingo Molnar wrote:
> > > > @@ -1371,11 +1373,11 @@ static ssize_t psmouse_attr_set_protocol
> > > >  			return -EIO;
> > > >  		}
> > > >  
> > > > -		up(&psmouse_sem);
> > > > +		mutex_unlock(&psmouse_mutex);
> > > >  		serio_unpin_driver(serio);
> > > >  		serio_unregister_child_port(serio);
> > > >  		serio_pin_driver_uninterruptible(serio);
> > > > -		down(&psmouse_sem);
> > > > +		mutex_lock(&psmouse_mutex);
> > > Isn't that supposed to be the other way around?
> > > 
> > 
> > No, that's correct. We temporarily dropping the lock to let the serio core
> > do its job and then reaqcuire it again to finish what we were doing. 
> 
> are you REALLY sure? It looks to me as if this function is called from
> sysfs.. so you don't know that you have the lock...
>

Yes, I am sure, the sysfs helper does acquire that lock. See 

	drivers/input/mouse/psmouse-base.c::psmouse_attr_set_helper()

-- 
Dmitry
