Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWDMSpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWDMSpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWDMSpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:45:33 -0400
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:9673 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932391AbWDMSpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:45:33 -0400
Message-ID: <443E9CB2.8020500@keyaccess.nl>
Date: Thu, 13 Apr 2006 20:47:14 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       ALSA devel <alsa-devel@alsa-project.org>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again
 if probe was unsuccessful
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de> <443E5AAD.5040800@keyaccess.nl> <20060413145756.GA29959@flint.arm.linux.org.uk> <443E79AD.50505@keyaccess.nl> <20060413170549.GB7805@flint.arm.linux.org.uk>
In-Reply-To: <20060413170549.GB7805@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> On Thu, Apr 13, 2006 at 06:17:49PM +0200, Rene Herman wrote:

>> Okay, thanks, that's relevant information. Please explain though
>> what's incorrect about the fact that for these ISA devices on the
>> plain old PC, with nothing other than the driver available to probe
>> for them, just keeping them registered after failing a probe turns
>> /sys/devices/platform into a view of "what drivers did we load".
> 
> If a driver for an ISA device only wants to register a device and
> driver if the hardware exists, it needs to handle behaviour itself
> and not force such behaviour on the upper layers (which is what
> you're arguing for.)

Nono, please note I'm arguing for nothing of the sort. The original 
patch to bus_add_device() to pass up the probe() return was submitted 
with just a "if I do this, things work as I expect. is it correct?" 
question attached. Given that everything uses that same code, it wasn't 
correct. What I am arguing for is that it would be good if the driver 
model provided me the _option_ to fail a registration if the driver 
tells it there are no devices. ie, the flag that I could set that would 
make the driver model interpret an ENODEV from probe() to really mean NODEV.

The current work-around of using drvdata() as a success flag is exactly 
what you say -- ALSA doing it all by itself. This thread specifically 
only started due to Ingo Oeser suggesting that work-around would go into 
platform_device_register_simple()...

>> M'kay. I believe there's one clean way out of this. We could add an "isa 
>> bus", where the _user_ would first need to setup the hardware from 
>> userspace by echoing values into sysfs. Say, something like:
> 
> Maybe this is the best solution for ISA devices - they do appear to
> have differing semantics at the probe level from platform devices.
> Maybe this "discovery" should be part of the bus matching method, prior
> to the driver probe method being called?  With an ISA bus type, you can
> certainly arrange for that to happen without changing existing driver
> model behaviour.

I can try and see if I can come up with something sensible I guess. Will 
need time though...

Takashi: anyways, these patches are good to go. Already saw the ISA 
driver ones present in 1.0.11-rc5. I by the way do not see them in the 
ALSA CVS at http://cvs.sourceforge.net/viewcvs.py/alsa/. How's that?

Rene.

