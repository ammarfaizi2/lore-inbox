Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbSI1CLx>; Fri, 27 Sep 2002 22:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbSI1CLx>; Fri, 27 Sep 2002 22:11:53 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:60686 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262683AbSI1CLw>;
	Fri, 27 Sep 2002 22:11:52 -0400
Date: Fri, 27 Sep 2002 19:15:30 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>,
       Thomas Molina <tmolina@cox.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: (more) Sleeping function called from illegal context...
Message-ID: <20020928021530.GA14866@kroah.com>
References: <20020927233044.GA14234@kroah.com> <3D94EEBF.D6328392@digeo.com> <3D94FB57.40507@easynet.be> <3D9504B7.1C8CB675@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9504B7.1C8CB675@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 06:24:07PM -0700, Andrew Morton wrote:
> Luc Van Oostenryck wrote:
> > 
> > With CONFIG_PREEMPT=y on an SMP AMD (2CPU):
> > 
> > Sleeping function called from illegal context at /kernel/l-2.5.39/include/asm/semaphore.h:119
> > c1b4ff7c c0117094 c0280b00 c02bc680 00000077 f7f78540 c01ffc8c c02bc680
> >         00000077 c1b4e000 c1b4e000 00000001 c1b4ffdc c1b4ffc0 00000206 f7f78568
> >         c1b4e000 00000001 c1b4ffdc c01fff35 c01fff00 00000000 00000000 00000000
> > Call Trace:
> >   [<c0117094>]__might_sleep+0x54/0x58
> >   [<c01ffc8c>]usb_hub_events+0x6c/0x2e0
> >   [<c01fff35>]usb_hub_thread+0x35/0xe0
> >   [<c01fff00>]usb_hub_thread+0x0/0xe0
> >   [<c0115500>]default_wake_function+0x0/0x40
> >   [<c010553d>]kernel_thread_helper+0x5/0x18
> 
> usb_hub_events() does down() inside hub_event_lock.

Yup, just got that one myself, along with a few other USB goodies :(

This is a very good debugging tool, thanks for doing it.

greg k-h
