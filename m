Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUJSA4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUJSA4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 20:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268180AbUJSA4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 20:56:05 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:31157 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268177AbUJSAzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 20:55:53 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Richard Smith <rsmith@bitworks.com>
Date: Mon, 18 Oct 2004 17:55:16 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <41740384.5783.12A07B14@localhost>
In-reply-to: <41744505.4080507@bitworks.com>
References: <9e47339104101814166bf4cfe5@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Smith <rsmith@bitworks.com> wrote:

> Jon Smirl wrote:
> 
> > Every system has to be able to somehow indicate that it can find/load the
> > kernel image or that the image is corrupt or that hardware diagnostics failed.
> > Displaying this info is the responsibility of the BIOS.
> 
> Jon, I agree with you 100%.  I was merely responding to a
> statement I saw as false. 
> 
> If we could get the video chip manufacturers to provide me with
> all the necessary documentation we embedded folk would be happy to
> do exactly as you say.  We could code up a nice robust boot time
> init procedure to serve our purposes.  OF would be great if all
> the mfgs would support it. 

Well being able to use this BIOS emulator logic to bring up the primary 
video card in the firmware should solve this problem, right? Just ignore 
the fact that the BIOS image we are using happens to be x86 code, and 
think about is as a set of instructions that we execute using an 
interpreter (ie: the same as Open Firmware really).

> Its a sad fact though that we are (x86 anyway) dependant on some
> amazingly fragile, stupid, usually binary only, legacy bloated, and
> quite often buggy, 16-bit realmode video init code that should have
> been put to pasture many years ago. 

Actually there is nothing wrong with the x86 BIOS from the perspective of 
functionality and useability (or bloat for that matter). It contains all 
the functionality we need and armed with something like the x86 emulator 
we can use it for what we need on any platform.

Open Firmware may be a 'nicer' solution, but I guarantee that if the 
vendors started supporting that it would be just a bug ridden as any 16-
bit real mode BIOS code. For the Video BIOS the code always works for 
what it is tested for. Some vendors spend more time testing the VBE BIOS 
side of things fully (if they are smart they have licensed our VBETest 
tools for this purpose). Unfortunatley some vendors do not test this 
stuff thoroughly and it has problems. But the same testing issues would 
exist whether the firmware was written as a 16-bit x86 blob or as an Open 
Firmware blob.

> LinuxBIOS has been trying to come up with a solution to the video
> BOOT problems for good while now.  Emulation seems to be the only
> thing that really has a chance of working. 

IMHO that is the best solution to the problem because it will be using 
code that has been heavily tested by the vendor. The one thing x86 Video 
BIOS'es can do reliably is POST the graphics card ;-)

> I don't currently (see next paragraph) need the kernel to try and
> do all that stuff for me since I need it prior to when the kernel
> loads.  But what I would like is to be able to use/build on kernel
> framework without having to completely re-invent the wheel. 

Assuming you put the video init code into the firmware, then yes, the 
kernel does not need it. However part of the project to put this into the 
kernel involves building a better VESA framebuffer console driver, and to 
do that we either need vm86() services from kernel land (frowned upon by 
the kernel community and inherently x86 centric) or support for x86 
emulation.

If you want to try and build a better standard than the x86 VESA VBE 
BIOS, be my guest. I lobbied for years on the VESA Software Standards 
Committee to build the next generation firmware that would be cross 
platform, but nobody was interested. In fact the SSC eventually closed 
due to lack of interest so we took all our technology and turned it into 
SciTech SNAP. 

I see Intel is trying to do something similar with EFI, but when will 
that actually be here?

So for now we have the x86 BIOS and it works today. We should use it.

> Linux far exceeds the hardware support level and flexablity of any
> bios and already does 90% of the job a bios does anyway. In most
> cases better than the bios ever could.  Linux booting Linux is the
> ultimate bios/bootloader. 

That would be nice if you could trim it down ;-) Would certainly save a 
lot of code bloat. But if you do that, then you would need this code in 
the kernel since now it would be the boot loader as well ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


