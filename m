Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTK3JTi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTK3JTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:19:38 -0500
Received: from smtp802.mail.ukl.yahoo.com ([217.12.12.139]:54383 "HELO
	smtp802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263310AbTK3JTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:19:35 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [2.6 RFC/PATCH] Input: possible deadlock in i8042
Date: Sun, 30 Nov 2003 04:19:28 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200311300303.57654.dtor_core@ameritech.net> <20031130090009.GA17038@ucw.cz>
In-Reply-To: <20031130090009.GA17038@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311300419.29064.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 November 2003 04:00 am, Vojtech Pavlik wrote:
> On Sun, Nov 30, 2003 at 03:03:57AM -0500, Dmitry Torokhov wrote:
> > If request_irq fails in i8042_open it will call
> > serio_unregister_port, which takes serio_sem. i8042_open may be
> > called:
> >
> > serio_register_port - serio_find_dev - dev->connect
> > serio_register_device - dev->connect
> >
> > Both serio_register_port and serio_register_device take serio_sem as
> > well.
> >
> > I think that serio_{register|unregister}_port can be converted into
> > submitting requests to kseriod thus removing deadlock on the
> > serio_sem.
> >
> > The patch below is on top of serio* patches in Andrew Morton's -mm
> > tree.
>
> It's nice to avoid the deadlock this way, but I think it's not a good
> idea to make the register/unregister asynchronous - it could be a nasty
> surprise for an unsuspecting driver writer.
>

Serio_register_port is not guaranteed to find a driver for the serio anyway
as the driver can be compiled as a module and loaded much much later so it
should not be a concern. It is somewhat asynchronous already.

Dmitry
