Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVA1Xvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVA1Xvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVA1Xvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:51:32 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:16754 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261386AbVA1Xva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:51:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH] add driver matching priorities
Date: Fri, 28 Jan 2005 18:51:28 -0500
User-Agent: KMail/1.7.2
Cc: greg@kroah.com, rml@novell.com, linux-kernel@vger.kernel.org
References: <1106951404.29709.20.camel@localhost.localdomain> <200501281823.27132.dtor_core@ameritech.net> <1106955187.29709.24.camel@localhost.localdomain>
In-Reply-To: <1106955187.29709.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501281851.28475.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 January 2005 18:33, Adam Belay wrote:
> On Fri, 2005-01-28 at 18:23 -0500, Dmitry Torokhov wrote:
> > On Friday 28 January 2005 17:30, Adam Belay wrote:
> > > Of course this patch is not going to be effective alone.  We also need
> > > to change the init order.  If a driver is registered early but isn't the
> > > best available, it will be bound to the device prematurely.  This would
> > > be a problem for carbus (yenta) bridges.
> > > 
> > > I think we may have to load all in kernel drivers first, and then begin
> > > matching them to hardware.  Do you agree?  If so, I'd be happy to make a
> > > patch for that too.
> > > 
> > 
> > I disagree. The driver core should automatically unbind generic driver
> > from a device when native driver gets loaded. I think the only change is
> > that we can no longer skip devices that are bound to a driver and match
> > them all over again when a new driver is loaded.  
> > 
> 
> That's another option.  My concern is that if a generic driver pokes
> around with hardware, it may fail to initialize properly when the actual
> driver is loaded.  There are other problems too.  If the system were to
> be suspended while the generic driver was loaded, the restore_state code
> may be incorrect, also rendering the device unusable.
> 

If generic driver binds to a device that is has no idea how to drive
_at all_ then I will argue that the generic driver is broken. It should
not bind to begin with.

-- 
Dmitry
