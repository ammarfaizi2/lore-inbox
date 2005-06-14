Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVFNHwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVFNHwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVFNHwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:52:53 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:50098 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261311AbVFNHws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:52:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: Input sysbsystema and hotplug
Date: Tue, 14 Jun 2005 02:52:41 -0500
User-Agent: KMail/1.8.1
Cc: linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200506131607.51736.dtor_core@ameritech.net> <42AE8A9E.5040406@suse.de>
In-Reply-To: <42AE8A9E.5040406@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506140252.42306.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 02:43, Hannes Reinecke wrote:
> Dmitry Torokhov wrote:
> > 	 
> Hmm. I don't like it very much as it mixes two different types of
> devices (class devices and subclasses) into one directory.
> 

If one could come up with a good name to group inputX under I think
it will be OK. We'd have XXX, mouse, joystick, event, ... as subclasses
and all class_devices will be on level below. OTOH input_devs are parents
for mice, joysticks etc so they might be on the higher level.

> I think it's cleaner to have two distinct class device types
> (one for input_dev and one for input).
> 

I actually detest this practice:

[dtor@core ~]$ ls /sys/class/
firmware     ieee1394       ieee1394_protocol  mem   pci_bus        sound  usb_host
graphics     ieee1394_host  input              misc  pcmcia_socket  tty    vc
i2c-adapter  ieee1394_node  input_dev          net   printer        usb
[dtor@core ~]$

dtor@anvil ~]$ ls /sys/class/
cpuid     i2c-adapter  ieee1394_host      input  msr      printer      sound  usb_host
firmware  i2c-dev      ieee1394_node      mem    net      scsi_device  tty    vc
graphics  ieee1394     ieee1394_protocol  misc   pci_bus  scsi_host    usb    video4linux
[dtor@anvil ~]$

Firewire has 4 classes on the uppper level, I2C, USB, SCSI and Input got
2 each. It would be much nicer IMHO if we merge them into trees of classes
with poarent class actually defining subsystem.  

> subclasses for the input class devices are a neat idea; but I fear the
> hotplug event name will change for each subclass device ('input' will
> become eg 'mouse'), so we again have to change all hotplug handlers.
> And I don't see an easy solution for that ...
>

We could have parent class define agent/subsystem name for all its children.

-- 
Dmitry
