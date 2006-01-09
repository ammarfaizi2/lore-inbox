Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWAIDLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWAIDLj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWAIDLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:11:39 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:54147 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S1750851AbWAIDLj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:11:39 -0500
Date: Mon, 9 Jan 2006 04:12:06 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] RTC subsystem, dev interface
Message-ID: <20060109041206.6115bafb@inspiron>
In-Reply-To: <200601082150.22213.dtor_core@ameritech.net>
References: <20060108231235.153748000@linux>
	<20060108231255.609424000@linux>
	<200601082150.22213.dtor_core@ameritech.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 21:50:21 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

 Hi,

   I will reply in two different emails as I need
 to do some research on some questions of yours.

> > +	if (down_trylock(&rtc->char_sem))
> > +		return -EBUSY;
> > +
> 
> Does the device have to be opened for exclusively? Can it support
> concurrent reads?

 I'm trying to make the things work the same way as with the old
 interface. Once this new code will be as stable as the old one, new
 features can be added. 

 Concurrent reads are certainly possible, but we'd need to lock
 out writes in proper places, and I do not feel safe
 to do it at this stage.

 [..]

> > +			ret = -ERESTARTSYS;
> > +			break;
> > +		}
> > +		schedule();
> > +	} while (1);
> > +	set_current_state(TASK_RUNNING);
> > +	remove_wait_queue(&rtc->irq_queue, &wait);
> > +
> 
> 
> The above looks very much like open-coded wait_event_interruptible();

 Ditto, plus there's the irq data inside 

> > +	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
> > +
> 
> This is kobject_hotplug abuse; you are not adding a new object here.

 Yes. But I've checked the code and should not harm. I've asked
 for that a couple of weeks ago in this same mailing list
 and got no answer. If there's a working alternative to obtain
 the same result, I'm obviously willing to try.

> > +/* interface registration */
> > +
> > +struct class_interface rtc_dev_interface = {
> > +	.add = &rtc_dev_add_device,
> > +	.remove = &rtc_dev_remove_device,
> > +};
> > +
> 
> I wonder if doing rtc dev as a class device interface is a good idea.
> It may be cleaner to fold it into the core.

 What the code implements is actually an interface, so this should
 be the riht place. It is also fully optional, everything could work
 without it. Probably the interface implementation hasn't all the primitives
 to handle this kind of work, but I'm not willing to go into that right now ;)

 Thank you for your hard work Dmitry, after weeks viewing the same
 code I'm going to be lost in all of those locks issues ;)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

