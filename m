Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTIBWPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 18:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTIBWPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 18:15:46 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:44297 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S264113AbTIBWPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 18:15:44 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Date: Wed, 3 Sep 2003 06:13:19 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <200309020139.08248.mhf@linuxmail.org> <20030902164341.GF17568@kroah.com>
In-Reply-To: <20030902164341.GF17568@kroah.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309030613.19800.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 September 2003 00:43, Greg KH wrote:
> On Tue, Sep 02, 2003 at 01:39:08AM +0800, Michael Frank wrote:
> > PL2303 is used to connect the serial console on a classic serial port
> > of a test machine. HW nandshaking is used
> > The test machine reboots once a minute and dumps lots of messages
> >
> > Frequently:
> > - driver hangs
> > - userspace (cu) can't be stopped
> > - pl2303 and/or usbserial can't be unloaded
> > - USB interrupts stop
> > - problems result in requiring a reboot.
>
> Hm, it looks like you physically removed the device, is that correct?
> Or were you just unloading the pl2303 and other USB drivers and then
> reloading them?
>
> What exactly were you doing in this log?
>
> Oh, and can you send a copy of /proc/bus/usb/devices with your pl2303
> device plugged in?
>

Whenever it stops working I follow this sequence, which you can match
to the logs.

1) Exit cu by ~.
   - if this does not work
       try \r~.
       - if this does not work
          Send SIGHUP, (which so far always worked)

2) Start cu again
   - if it prints leftover characters
     exit cu again by ~. and continue from step 2)

3) If it still not works and hangs again
   - for a few tries  
     unplug PL2303, wait a second replug and goto step 2)


4) If it still does not work
   - Remove PL2303, unload and reload usb (all) and
     plug PL2303 again
   - If module unloading fails, or interrupts died 
       (no response to plugging) > reboot 



Regards
Michael



