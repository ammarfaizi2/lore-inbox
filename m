Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269964AbTGZVBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269919AbTGZVAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:00:39 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:45281 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S269913AbTGZVA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:00:26 -0400
Date: Sat, 26 Jul 2003 23:15:22 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() backport to 2.4 kernels
Message-ID: <20030726211522.GA16316@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030726121638.GB31145@ranty.pantax.net> <1059253473.922.18.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059253473.922.18.camel@pegasus>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 11:04:27PM +0200, Marcel Holtmann wrote:
> Hi Manuel,
> 
> >  A while back request_firmware() was added to the 2.5 kernel series to
> >  support firmware needing drivers keeping the firmware images in
> >  userspace. And I also backported it to the 2.4 kernel series on top of
> >  procfs, but Marcelo didn't answer emails relating to it (there where
> >  probably other more important matters back then).
> >  
> >  Since then, the 2.4 backport has been deployed and tested with
> >  orinoco_usb driver variant (http://orinoco-usb.alioth.debian.org/),
> >  as you can see in the download statistics in alioth, there has been
> >  more than 400 downloads of the request_firmware enabled version
> >  (0.2.1). And drivers on the 2.5/2.6 series are being ported to use
> >  request_firmware() interface.
> 
> I've tested your patch with 2.4.22-pre8 and a modified version of my
> bfusb driver. It is working fine, but I get these log entries:
> 
> 	hub.c: new USB device 02:0c.0-2, assigned address 2
> 	firmware_class.c:call_helper: firmware: /sbin/hotplug firmware add
> 	remove_proc_entry: bfusb003002/loading busy, count=1
> 	remove_proc_entry: firmware/bfusb003002 busy, count=1
> 	BlueFRITZ! USB loading firmware
> 	de_put: deferred delete of loading
> 	de_put: deferred delete of bfusb003002
> 	BlueFRITZ! USB device ready
> 
> Is this a problem of your patch or is it a general /proc problem?

 I don't know if I can get around it, but it is a /proc issue, it dumps
 those messages when the kernel removes a file that is being used from
 userspace. Those messages should probably be changed into KERN_DEBUG.
 
> I already ported drivers/bluetooth/bfusb.c to use the request_firmware()
> interface and I will port drivers/bluetooth/bt3c_cs.c after this patch
> gets merged.

 Great.


 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
