Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263789AbUD0F5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUD0F5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUD0F5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:57:14 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:46250 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263789AbUD0F5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:57:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Tue, 27 Apr 2004 00:57:10 -0500
User-Agent: KMail/1.6.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <200404260732.46315.dtor_core@ameritech.net> <1082984991.28880.145.camel@pegasus>
In-Reply-To: <1082984991.28880.145.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200404270057.10835.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 April 2004 08:09 am, Marcel Holtmann wrote:
> Hi Dmitry,
> 
> > This is wrong... What if you have several devices that are needed firmware?
> > You are not only loading a specific firmware but do it for a specific device.
> > You may also want to do something else with it...
> > 
> > I think until pcmcia either provides or allows to create devices on pcmcia
> > bus you can just fixup the name breakage like I did for atmel driver and
> > leave it be. The device is not registered and not used in any way except to
> > provide "unique" name for fimrware loader, at list in atmel_cs that is the
> > case.
> 
> as you said the only real goal of the device in request_firmware() is to
> provide us with a unique path to the "loading" and "data" files. The
> advantage of having the device linked is currently not used by the
> firmware.agent script and I don't think that it ever will be used.
> However you can take a look at 2.4, where the device parameter is only a
> string. So what is wrong with letting request_firmware() create a dummy
> and temporary device that is not related to any hardware?
>

Several drivers already use the firmware loading facility and I expect seeing
more of them in the future. So it is possible to have 2 seperate devices
request firmware at the same time. If we just provide single dummy device and
use it they will clash. Generating unique ID on every request with empty
device is a hack. I do not think that interface needs this kind of a hack, it
is better to keep them in the drivers that do not properly register themselves
with the driver model yet.

-- 
Dmitry
