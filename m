Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVCaDB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVCaDB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVCaDB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:01:57 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:50845 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262496AbVCaDBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:01:55 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: klists and struct device semaphores
Date: Wed, 30 Mar 2005 22:01:53 -0500
User-Agent: KMail/1.8
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0503291055560.1038-100000@ida.rowland.org> <Pine.LNX.4.50.0503301814090.20992-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0503301814090.20992-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503302201.53487.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 21:16, Patrick Mochel wrote:
> 
> On Tue, 29 Mar 2005, Alan Stern wrote:
> 
> > On Mon, 28 Mar 2005, Patrick Mochel wrote:
> >
> > > How is this related to (8) above? Do you need some sort of protected,
> > > short path through the core to add the device, but not bind it or add it
> > > to the PM core?
> >
> > Having thought it through, I believe all we need for USB support is this:
> >
> > 	Whenever usb_register() in the USB core calls driver_register()
> > 	and the call filters down to driver_attach(), that routine
> > 	should lock dev->parent->sem before calling driver_probe_device()
> > 	(and unlock it afterward, of course).
> >
> > 	(For the corresponding remove pathway, where usb_deregister()
> > 	calls driver_unregister(), it would be nice if __remove_driver()
> > 	locked dev->parent->sem before calling device_release_driver().
> > 	This is not really needed, however, since USB drivers aren't
> > 	supposed to touch the device in their disconnect() method.)
> 
> 
> Why can't you just lock it in ->probe() and ->remove() yourself?
> 

Will the lock be exported (via helper functions)? I always felt dirty using
subsys.rwsem because it I think it was supposed to be implementation detail.
 
-- 
Dmitry
