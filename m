Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbUKPGiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbUKPGiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 01:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUKPGiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 01:38:05 -0500
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:11898 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261923AbUKPGiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 01:38:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: ambx1@neo.rr.com (Adam Belay)
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Date: Tue, 16 Nov 2004 01:37:57 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Tejun Heo <tj@home-tj.org>, Patrick Mochel <mochel@digitalimplant.org>
References: <20041109223729.GB7416@kroah.com> <200411092249.44561.dtor_core@ameritech.net> <20041116061315.GG29574@neo.rr.com>
In-Reply-To: <20041116061315.GG29574@neo.rr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411160137.57402.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 November 2004 01:13 am, Adam Belay wrote: 
> An Alternative Solution
> =======================
> 
> Why not have a file named "bind".  We can write the name of the driver we want
> bound to the device.  When we want to unbind the driver we could do something
> like this:
> 
> # echo "" > bind
> or
> # echo 0 > bind
> 
> At least then we only have the link and the "bind" file to worry about.  I've
> also been considering more inventive solutions (like deleting the symlink will
> cause the driver to unbind). But it could get complex very quickly.  Really, 
> we need to discuss this more.
>

I'd like having one node as well. Right now serio bus uses "drvctl" and supports
the following operations:
 - "none" to unbind;
 - "rescan" to unbind if bound and then find appropriate driver;
 - "reconnect" to reinitialize hardware without inbinding (so exesting input
   devices will be kept intact)
 - <driver name> to unbind if bound and try to bind.

There was also ide of changing commands to form "CMD [DRIVER] [ARGS...]:
"detach", "rescan", "reconnect", "attach <driver_name>"

My bind mode patch is somewhat independent of "drvctl" as it just adds a new
attribute - "bind_mode" to all devices and drivers. It can be either "auto"
or "manual" and device/drivers that are set as manual mode will be ignored
by driver core and will only be bound when user explicitely asks to do that.
This is useful when you want "penalize" one driver over another, like
psmouse/serio_raw.

-- 
Dmitry
