Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVCaWRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVCaWRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCaWPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:15:33 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:9118 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262028AbVCaWOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:14:43 -0500
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp
	at fault?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: dtor_core@ameritech.net
Cc: Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@suse.cz>,
       Vojtech Pavlik <vojtech@suse.cz>, Andy Isaacson <adi@hexapodia.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d50005033108321c8f4ae7@mail.gmail.com>
References: <20050329181831.GB8125@elf.ucw.cz>
	 <1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	 <20050329223519.GI8125@elf.ucw.cz>
	 <200503310226.03495.dtor_core@ameritech.net>
	 <Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net>
	 <d120d50005033108321c8f4ae7@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112307395.18871.4.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 01 Apr 2005 08:16:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-04-01 at 02:32, Dmitry Torokhov wrote:
> On Thu, 31 Mar 2005 08:02:44 -0800 (PST), Patrick Mochel
> <mochel@digitalimplant.org> wrote:
> > 
> > On Thu, 31 Mar 2005, Dmitry Torokhov wrote:
> > 
> > > Ok, what do you think about this one?
> > >
> > > ===================================================================
> > >
> > > swsusp: disable usermodehelper after generating memory snapshot and
> > >         before resuming devices, so when device fails to resume we
> > >         won't try to call hotplug - userspace stopped anyway.
> > 
> > Hm, shouldn't we disable it before we start to freeze processes? We don't
> > want any more processes trying to start up after we've taken care of
> > them..
> > 
> 
> Can't a device be removed (for any reason) _while_ we are freezing
> processes? I think freeszing code will properly deal with it... What
> about suspend semantics - if suspend fails do we say the device should
> be operational or the system should attempt to re-initialize? I.e. we
> are not doing suspend after all - can we still drop messages on the
> floor? After all, we still have ability to run coldplug after failed
> suspend.
> 
> I frankly am not sure at what point to disable usermode helper. Or
> maybe we need to have a list of pending events and suspend khelper_wq
> while suspending.

FWIW, my solution is purely freezer based. I freeze khelper and in the
freezer code ignore kernel threads in state uninterruptible (which is
where kseriod, eg, will be while it waits for the usermode helper
process (which also gets frozen).

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

