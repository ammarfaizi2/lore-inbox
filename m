Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWANQnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWANQnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWANQnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:43:08 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:34672 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751202AbWANQnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:43:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Faidon Liambotis <faidon@cube.gr>
Subject: Re: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
Date: Sat, 14 Jan 2006 11:43:04 -0500
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
References: <20060114160253.GA1073@elte.hu> <43C92502.30307@cube.gr>
In-Reply-To: <43C92502.30307@cube.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141143.05112.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 11:21, Faidon Liambotis wrote:
> Ingo Molnar wrote:
> > @@ -1371,11 +1373,11 @@ static ssize_t psmouse_attr_set_protocol
> >  			return -EIO;
> >  		}
> >  
> > -		up(&psmouse_sem);
> > +		mutex_unlock(&psmouse_mutex);
> >  		serio_unpin_driver(serio);
> >  		serio_unregister_child_port(serio);
> >  		serio_pin_driver_uninterruptible(serio);
> > -		down(&psmouse_sem);
> > +		mutex_lock(&psmouse_mutex);
> Isn't that supposed to be the other way around?
> 

No, that's correct. We temporarily dropping the lock to let the serio core
do its job and then reaqcuire it again to finish what we were doing. 

-- 
Dmitry
