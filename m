Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265132AbUFRMue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbUFRMue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 08:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUFRMud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 08:50:33 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:52362 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265132AbUFRMua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 08:50:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 8/11] serio sysfs integration
Date: Fri, 18 Jun 2004 07:50:26 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, vojtech@ucw.cz
References: <200406180335.52843.dtor_core@ameritech.net> <200406180342.11056.dtor_core@ameritech.net> <20040618023853.5d4ee96a.akpm@osdl.org>
In-Reply-To: <20040618023853.5d4ee96a.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180750.26570.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 June 2004 04:38 am, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> >   Input: serio sysfs integration
> 
> What is the sysfs directory layout, and what do the chosen nodes do?
> 
> What design decisions were made when choosing that layout?
> 
> Is it so trivial that users don't need any documentation?
> 

I do consider it trivial for now as the only thing that user can do is
"echo" desired driver into serioX/driver to rebind it. The typical node
looks like this:

[dtor@core dtor]$ ls -la /sys/bus/serio/devices/serio0/
total 0
-r--r--r--    1 root     root         4096 Jun 17 21:49 description
-rw-r--r--    1 root     root         4096 Jun 17 21:49 detach_state
-rw-r--r--    1 root     root            0 Jun 18 02:52 driver
-r--r--r--    1 root     root         4096 Jun 17 21:49 legacy_position
drwxr-xr-x    2 root     root            0 Jun 17 21:49 power
drwxr-xr-x    3 root     root            0 Jun 18 02:52 serio3

description 	- i8042 Aux Port
driver		- psmouse
legacy_position	- isa0060/serio1 (take from serio's phys, can be used
to match with /proc/bus/input/devices).

Every driver will have a set of custom attributes that will be documented
on one by one basis. Btw, where would you document it? Documentation
directory entry? Something else?

-- 
Dmitry

[dtor@core dtor]$ ls -laR /sys/bus/serio/
/sys/bus/serio/:
total 0
drwxr-xr-x    2 root     root            0 Jun 18 02:52 devices
drwxr-xr-x    5 root     root            0 Jun 18 02:52 drivers

/sys/bus/serio/devices:
total 0
lrwxrwxrwx    1 root     root            0 Jun 17 21:49 serio0 -> ../../../devices/serio0
lrwxrwxrwx    1 root     root            0 Jun 17 21:49 serio1 -> ../../../devices/serio1
lrwxrwxrwx    1 root     root            0 Jun 18 02:52 serio3 -> ../../../devices/serio0/serio3

/sys/bus/serio/drivers:
total 0
drwxr-xr-x    2 root     root            0 Jun 17 21:49 atkbd
drwxr-xr-x    2 root     root            0 Jun 18 02:52 psmouse
drwxr-xr-x    2 root     root            0 Jun 18 02:52 serio_raw

/sys/bus/serio/drivers/atkbd:
total 0
-r--r--r--    1 root     root         4096 Jun 17 21:49 description
lrwxrwxrwx    1 root     root            0 Jun 17 21:49 serio1 -> ../../../../devices/serio1

/sys/bus/serio/drivers/psmouse:
total 0
-r--r--r--    1 root     root         4096 Jun 18 02:52 description
lrwxrwxrwx    1 root     root            0 Jun 18 02:52 serio0 -> ../../../../devices/serio0
lrwxrwxrwx    1 root     root            0 Jun 18 02:52 serio3 -> ../../../../devices/serio0/serio3

/sys/bus/serio/drivers/serio_raw:
total 0
-r--r--r--    1 root     root         4096 Jun 18 02:50 description

