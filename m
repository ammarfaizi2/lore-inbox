Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVA1Xhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVA1Xhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVA1Xhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:37:31 -0500
Received: from peabody.ximian.com ([130.57.169.10]:37511 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262814AbVA1XhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:37:25 -0500
Subject: Re: [RFC][PATCH] add driver matching priorities
From: Adam Belay <abelay@novell.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: greg@kroah.com, rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <200501281823.27132.dtor_core@ameritech.net>
References: <1106951404.29709.20.camel@localhost.localdomain>
	 <200501281823.27132.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 18:33:06 -0500
Message-Id: <1106955187.29709.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 18:23 -0500, Dmitry Torokhov wrote:
> On Friday 28 January 2005 17:30, Adam Belay wrote:
> > Of course this patch is not going to be effective alone.  We also need
> > to change the init order.  If a driver is registered early but isn't the
> > best available, it will be bound to the device prematurely.  This would
> > be a problem for carbus (yenta) bridges.
> > 
> > I think we may have to load all in kernel drivers first, and then begin
> > matching them to hardware.  Do you agree?  If so, I'd be happy to make a
> > patch for that too.
> > 
> 
> I disagree. The driver core should automatically unbind generic driver
> from a device when native driver gets loaded. I think the only change is
> that we can no longer skip devices that are bound to a driver and match
> them all over again when a new driver is loaded.  
> 

That's another option.  My concern is that if a generic driver pokes
around with hardware, it may fail to initialize properly when the actual
driver is loaded.  There are other problems too.  If the system were to
be suspended while the generic driver was loaded, the restore_state code
may be incorrect, also rendering the device unusable.

I'd like to leave the option of unloading generic driver open.  I just
think we need to be aware of potential problems it might cause, before
deciding to go that direction.

Thanks,
Adam


