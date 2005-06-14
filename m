Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVFNE0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVFNE0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 00:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVFNE0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 00:26:21 -0400
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:8377 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261427AbVFNE0Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 00:26:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: Input sysbsystema and hotplug
Date: Mon, 13 Jun 2005 23:26:06 -0500
User-Agent: KMail/1.8.1
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200506131607.51736.dtor_core@ameritech.net> <20050613221657.GB15381@suse.de>
In-Reply-To: <20050613221657.GB15381@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506132326.06630.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 17:16, Greg KH wrote:
> On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > I am trying to convert input systsem to play nicely with sysfs and I am
> > having trouble with hotplug agent. The old hotplug mechanism was using
> > "input" as agent/subsystem name, unfortunately I can't simply use "input"
> > class because when Greg added class_simple support to input handlers
> > (evdev, mousedev, joydev, etc) he used that name.
> 
> Why not?  What's wrong with using the existing input class?  I was
> hopeing it would get flushed out into something "real" someday.  All you
> have to do is keep the "dev" stuff in there somewhere and udev will be
> happy.
> 

They are different. Your input class represents userpsace interfaces, my
input class represent middleman class devices. If you remember, input
core looks like this:
                                     evdev (/dev/input/eventX devices)
				    /
    hardware			   /
    device	-------- input_dev - mousedev (/dev/input/mouseX,
    (serio port,		   \           /dev/input/mice
     USB port)			    \
                                      joydev (/dev/input/jsX devices)

Your input class is fine (except for its name as it uses the same name
that input core was/is using for notification about new instances of
input_devs), but it represents different point in object hierarchy, as
it represents /dev/input/{mouse|event|js}X objects.

Your class devices are useful to properly create device nodes and
probably set up userspace applications to use new input devices. My
input_dev class devices are useful so hotplug would load proper input
handlers (joysdev, mousedev) to create your class devices.

I hope it explains things a bit...
       
-- 
Dmitry
