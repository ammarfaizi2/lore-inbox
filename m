Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTEQOo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 10:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTEQOo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 10:44:56 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:47255 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261561AbTEQOoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 10:44:55 -0400
Date: Sat, 17 May 2003 16:57:30 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Neukum <oliver@neukum.org>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517145730.GA10314@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030515200324.GB12949@ranty.ddts.net> <200305161753.17198.oliver@neukum.org> <20030516183152.GB18732@ranty.ddts.net> <200305170022.29824.oliver@neukum.org> <1053177811.7505.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053177811.7505.11.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 02:23:32PM +0100, Alan Cox wrote:
[snip]
> > No, still no good. It means that you get a memory leak if you unload
> > a driver before firmware is provided. You need the ability to explicitely
> > cancel a request for firmware.
> 
> Only if you program it wrongly. Its not exactly hard.
> 
> As to an interface. The simplest is probably
> 
> 	request_firmware()
> and
> 	request_firmware_nowait(......, workqueuehandler)

 This is what I plan to use:

 int request_firmware_nowait (
              struct module *module,
              const char *name, const char *device, void *context,
              void (*cont)(const struct firmware *fw, void *context));

 Working code should be available later today.
 
> The issues brought up about it failing appear bogus too, if the hotplug
> run returns a non zero exit code you know about this already.

 In this case, hotplug gets called automatically by the device model, and
 there is no way to get the return value of the hotplug run.

 If I get any good feedback on it, I'll try to make that return value
 available, in the mean while, I already implemented a timeout.

 Have a nice day

	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
