Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267625AbTACSwS>; Fri, 3 Jan 2003 13:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267627AbTACSwS>; Fri, 3 Jan 2003 13:52:18 -0500
Received: from fmr01.intel.com ([192.55.52.18]:28116 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267625AbTACSwS>;
	Fri, 3 Jan 2003 13:52:18 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [ACPI] acpi_os_queue_for_execution()
Date: Fri, 3 Jan 2003 11:00:04 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz] 
> Acpi seems to create short-lived kernel threads, and I don't quite
> understand why. 
> 
> In thermal.c
> 
> 
>                         tz->timer.data = (unsigned long) tz;
>                         tz->timer.function = acpi_thermal_run;
>                         tz->timer.expires = jiffies + (HZ * 
> sleep_time) / 1000;
>                         add_timer(&(tz->timer));
> 
> and acpi_thermal_run creates kernel therad that runs
> acpi_thermal_check. Why is not acpi_thermal_check called directly? I
> don't like idea of thread being created every time thermal zone needs
> to be polled...

Are we allowed to block in a timer callback? One of the things
thermal_check does is call a control method, which in turn can be very
slow, sleep, etc., so I'd guess that's why the code tries to execute
things in its own thread.

Regards -- Andy
