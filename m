Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUJUO1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUJUO1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUJUOXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:23:33 -0400
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:61131
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S264881AbUJUOVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:21:34 -0400
Date: Thu, 21 Oct 2004 10:27:45 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Instances of visor us devices are not deleted (2.6.9-rc4-mm1)
Message-ID: <20041021142745.GB24257@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.9
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 12:00:56AM -0700, Greg KH took 41 lines to write:
> On Wed, Oct 20, 2004 at 08:16:47AM +0200, Norbert Preining wrote:
> > Hi USB developers!
> > 
> > I have the following problem with 2.6.9-rc4-mm1 which includes bk-usb:
> > 
> > Everytime I sync my palm I get a new device id:
> > 
> > ...start sync...
> > usb 4-2.1: new full speed USB device using address 8
> > visor 4-2.1:1.0: Handspring Visor / Palm OS converter detected
> > usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB2
> > usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB3
> > ...
> > ...many usb usb2: string descriptor 0 read error: -113 ...
> > ...
> > ...end of sync...
> > usb 4-2.1: USB disconnect, address 8
> > visor 4-2.1:1.0: device disconnected
> > visor ttyUSB3: visor_write - usb_submit_urb(write bulk) failed with status = -19
> > ...new sync...
> > usb 4-2.1: new full speed USB device using address 9
> > visor 4-2.1:1.0: Handspring Visor / Palm OS converter detected
> > usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB4
> > usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB5
> > 
> > etc etc.
> > 
> > Is this a known problem?
> 
> Hm, no it isn't.  Are you sure that userspace doesn't still have the
> device nodes open?  If they do, the ttyUSB number will not be released
> until that happens.

I'm seeing the same thing here, but without the read errors:

drivers/usb/serial/usb-serial.c: USB Serial support registered for
Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony
Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony
Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
usb 1-2: new full speed USB device using address 2
visor 1-2:1.0: Handspring Visor / Palm OS converter detected
usb 1-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 1-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
usb 1-2: USB disconnect, address 2
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from
ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from
ttyUSB1
visor 1-2:1.0: device disconnected

Kurt
-- 
Furious activity is no substitute for understanding.
	-- H. H. Williams
