Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTKUEEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 23:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTKUEEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 23:04:07 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:16763 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264284AbTKUEEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 23:04:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Corrected drivermodel for i8042.c
Date: Thu, 20 Nov 2003 23:03:57 -0500
User-Agent: KMail/1.5.4
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       vojtech@ucw.cz
References: <20031116131134.GA301@elf.ucw.cz> <200311161520.03425.dtor_core@ameritech.net> <20031117085123.GF643@openzaurus.ucw.cz>
In-Reply-To: <20031117085123.GF643@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311202303.57999.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 November 2003 03:51 am, Pavel Machek wrote:
> Hi!
>
> > > +static int i8042_resume_port(struct serio *port)
> > > +{
> > > +	struct serio_dev *dev = port->dev;
> > > +	if (dev) {
> > > +		dev->disconnect(port);
> > > +		dev->connect(port, dev);
> > > +	}
> > > +}
> >
> > You want to do that event if there was nothing attached to the port
> > as a mouse might get plugged in while the box is suspended. I think
> > serio_rescan() is more appropriate (it will do a disconnect if needed
> > for you).
>
> I tried doing _rescan() but could not figure it out :-(.
>
> > Overall there is a problem with disconnect/connect method as it will
> > cause a new input device created for the same hardware if old input
> > device is held open by some process. If ever serio_reconnect patches
> > will make in the tree then serio_reconnect() can be used instead of
>
> Where can I get _reconnect() patches?

Please take a look in -mm tree serio-* patches. I believe if you apply them 
and then copy psmouse_pm_callback into i8042_resume_port it should work.

Dmitry
