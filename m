Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVFNIAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFNIAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 04:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVFNIAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 04:00:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:46810 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261315AbVFNIAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 04:00:16 -0400
Message-ID: <42AE8E8F.5070404@suse.de>
Date: Tue, 14 Jun 2005 10:00:15 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Input sysbsystema and hotplug
References: <200506131607.51736.dtor_core@ameritech.net> <42AE8A9E.5040406@suse.de> <200506140252.42306.dtor_core@ameritech.net>
In-Reply-To: <200506140252.42306.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Tuesday 14 June 2005 02:43, Hannes Reinecke wrote:
>>Dmitry Torokhov wrote:
>>>	 
>>Hmm. I don't like it very much as it mixes two different types of
>>devices (class devices and subclasses) into one directory.
>>
> 
> If one could come up with a good name to group inputX under I think
> it will be OK. We'd have XXX, mouse, joystick, event, ... as subclasses
> and all class_devices will be on level below. OTOH input_devs are parents
> for mice, joysticks etc so they might be on the higher level.
> 
>>I think it's cleaner to have two distinct class device types
>>(one for input_dev and one for input).
>>
> 
> I actually detest this practice:
> 
> [dtor@core ~]$ ls /sys/class/
> firmware     ieee1394       ieee1394_protocol  mem   pci_bus        sound  usb_host
> graphics     ieee1394_host  input              misc  pcmcia_socket  tty    vc
> i2c-adapter  ieee1394_node  input_dev          net   printer        usb
> [dtor@core ~]$
> 
> dtor@anvil ~]$ ls /sys/class/
> cpuid     i2c-adapter  ieee1394_host      input  msr      printer      sound  usb_host
> firmware  i2c-dev      ieee1394_node      mem    net      scsi_device  tty    vc
> graphics  ieee1394     ieee1394_protocol  misc   pci_bus  scsi_host    usb    video4linux
> [dtor@anvil ~]$
> 
> Firewire has 4 classes on the uppper level, I2C, USB, SCSI and Input got
> 2 each. It would be much nicer IMHO if we merge them into trees of classes
> with poarent class actually defining subsystem.  
> 
Correct.
And this in indeed a shortcoming of the driver model, as it basically
only knows about classes and devices.
Maybe it's about time to introduce a subsystem?

>>subclasses for the input class devices are a neat idea; but I fear the
>>hotplug event name will change for each subclass device ('input' will
>>become eg 'mouse'), so we again have to change all hotplug handlers.
>>And I don't see an easy solution for that ...
>>
> 
> We could have parent class define agent/subsystem name for all its children.
> 
Hmm.
We probably could.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
