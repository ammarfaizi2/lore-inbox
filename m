Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270445AbTHGTZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270455AbTHGTZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:25:42 -0400
Received: from post.tau.ac.il ([132.66.16.11]:46276 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S270445AbTHGTZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:25:36 -0400
Subject: Re: usbcore module can't unload after swsusp
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030806212335.GA7387@kroah.com>
References: <1060197664.1368.14.camel@litshi.luna.local>
	 <20030806212335.GA7387@kroah.com>
Content-Type: text/plain
Message-Id: <1060284416.3348.3.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 22:26:56 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.20.0.1; VDF: 6.20.0.55; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 00:23, Greg KH wrote:
> On Wed, Aug 06, 2003 at 10:42:06PM +0300, Micha Feigin wrote:
> > I am running a patched kernel 2.4.21 with acpi and swsusp ver 1.0.3
> > with usb compiled in as a module.
> > 
> > When kernel loads for the first time everything works fine, all usb
> > modules can be loaded and unloaded properly. After suspending and
> > restarting, the computer comes up fine and everything works. The
> > problem is that at this point, when I try to unload the usbcore module
> > it gets to the point of calling usb_hub_cleanup in drivers/usb/hub.c.
> > At this points it tried to kill khubd with killproc, which works fine
> > (the process is stoped), with a return value of 0. The problem is that
> > at this point the function locks on the call
> > wait_for_completion(&khubd_exited); which never returns, and rmmod gets
> > locked. I tried changing the DECLARE_COMPLETION call so that it will be
> > redone each time the module starts but it didn't solve the problem. Any
> > ideas on how to further persue this or whether there is a known
> > solution?
> 
> Unload the usb modules before suspending.
> 
> Good luck,
> 
> greg k-h

Guess I wasn't clear enough. I unload all the modules (except for the fw
ones actually since for some reason they refuse to do so).
This includes the usb modules, before I suspend.
There some more info on the subject though. Apparently this happens only
when calling the hibernation script (from the swsusp page on
sourceforge) from acpid in response to the sleep button. When called
from the command line I don't see this behavior.
-- 
Micha Feigin
michf@math.tau.ac.il

