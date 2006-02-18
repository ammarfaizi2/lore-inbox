Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWBRFpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWBRFpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWBRFpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:45:16 -0500
Received: from digitalimplant.org ([64.62.235.95]:4762 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1750840AbWBRFpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:45:14 -0500
Date: Fri, 17 Feb 2006 21:45:07 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Andrew Morton <akpm@osdl.org>
cc: greg@kroah.com, "" <torvalds@osdl.org>, "" <linux-kernel@vger.kernel.org>,
       "" <linux-pm@osdl.org>
Subject: Re: [PATCH 2/5] [pm] Add state field to pm_message_t (to hold actual
 state device is in)
In-Reply-To: <20060217210900.514b5f4c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.50.0602172136240.6792-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
 <20060217210900.514b5f4c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2006, Andrew Morton wrote:

> Patrick Mochel <mochel@digitalimplant.org> wrote:
> >
> >
> > Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
> >
> > ---
> >
> >  include/linux/pm.h |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > applies-to: 1ac50ba99ca37c65bdf3643c4056c246e401c18a
> > 63b8e7f0896ce93834ac60c15df954b1e6d45e56
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 5be87ba..a7324ea 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -140,6 +140,7 @@ struct device;
> >
> >  typedef struct pm_message {
> >  	int event;
> > +	u32 state;
> >  } pm_message_t;
>
> I don't quite understand.  This is a message which is sent to a driver
> saying "go into this state", isn't it?

.event is one of these:

#define PM_EVENT_ON 0
#define PM_EVENT_FREEZE 1
#define PM_EVENT_SUSPEND 2

Which only says what to do - turn on or off (AFAICT, FREEZE and SUSPEND
are synonymous). They are designed to work when the entire system is being
suspended or resumed, since every device is most likely going into its
lowest power state.

However, some devices support >1 low-power state which can be used to save
power while the system is otherwise fully up and running. Devices that are
not being used will most likely use the lowest power state, but devices
that are idle (and that support >1 low power state) can use the other
states even when idle.

In reality, there aren't many devices or drivers that support >1 low-power
state. But, there are some and likely to be more. And, the interface had
always supported it until some time in the 2.6.16 development cycle.

Does that help?

Thanks,


	Pat

