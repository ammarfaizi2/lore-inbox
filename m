Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbUKHH07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUKHH07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUKHH07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:26:59 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:29544 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261762AbUKHH05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:26:57 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 0/4] driver-model: manual device attach
Date: Mon, 8 Nov 2004 02:23:07 -0500
User-Agent: KMail/1.6.2
Cc: Tejun Heo <tj@home-tj.org>, Greg KH <greg@kroah.com>,
       rusty@rustcorp.com.au, mochel@osdl.org
References: <20041104074330.GG25567@home-tj.org> <200411050002.57174.dtor_core@ameritech.net> <20041105063237.GA28308@home-tj.org>
In-Reply-To: <20041105063237.GA28308@home-tj.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411080223.07639.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 November 2004 01:32 am, Tejun Heo wrote:
> > Do we really need 2 or even 3 files ("attach", "detach" and "rescan")?
> > Given that you really can't (at least not yet) do all there operations
> > for all buses from the core that woudl require 3 per-bus callbacks.
> > I think reserving special values such as "none" or "detach" and "rescan"
> > shoudl work just fine and also willallow extending supported operations
> > on per-bus basis. For example serio bus supports "reconnect" option which
> > tries to re-initialize device if something happened to it. It does not
> > want to do rescan as that would generate new input devices while it is
> > much more convenient to re-use old ones. 
> 
>  How about making the command format "CMD ARGS" rather than
> "{CMD|DRIVERNAME}"  i.e.
> 

Hi guys,

What do you think about following set of patches. It adds drvctl default
device attribute (write only) that controls device/driver binding. It
expects commands in form of "CMD [DRIVER_NAME] [ARG ARG...]" so I think
it will be very easy to adapt it to Tejun's per-device parameters.

I adjusted serio bus to the new form of commands so now it accepts:
"detach", "attach <driver>", "rescan", "reconnect"

And I added PCI bus drvctl that understands "detach", "attach <driver>",
and "rescan".

As we add drvctl methods to the rest of the buses we can review what
can be pulled into the core and what has to stay bus-specific.

Plus there is the bind_mode patch that allows switching between automatic
and manual binding on per-device/per-driver base.

-- 
Dmitry
