Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWANQxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWANQxx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWANQxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:53:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23255 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751214AbWANQxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:53:53 -0500
Subject: Re: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Faidon Liambotis <faidon@cube.gr>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601141143.05112.dtor_core@ameritech.net>
References: <20060114160253.GA1073@elte.hu> <43C92502.30307@cube.gr>
	 <200601141143.05112.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 17:53:48 +0100
Message-Id: <1137257628.3014.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 11:43 -0500, Dmitry Torokhov wrote:
> On Saturday 14 January 2006 11:21, Faidon Liambotis wrote:
> > Ingo Molnar wrote:
> > > @@ -1371,11 +1373,11 @@ static ssize_t psmouse_attr_set_protocol
> > >  			return -EIO;
> > >  		}
> > >  
> > > -		up(&psmouse_sem);
> > > +		mutex_unlock(&psmouse_mutex);
> > >  		serio_unpin_driver(serio);
> > >  		serio_unregister_child_port(serio);
> > >  		serio_pin_driver_uninterruptible(serio);
> > > -		down(&psmouse_sem);
> > > +		mutex_lock(&psmouse_mutex);
> > Isn't that supposed to be the other way around?
> > 
> 
> No, that's correct. We temporarily dropping the lock to let the serio core
> do its job and then reaqcuire it again to finish what we were doing. 

are you REALLY sure? It looks to me as if this function is called from
sysfs.. so you don't know that you have the lock...


