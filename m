Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUJTR3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUJTR3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUJTR2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:28:01 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:51119 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268812AbUJTR1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:27:15 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Tomas Carnecky <tom@dbservice.com>
Date: Wed, 20 Oct 2004 10:27:08 -0700
MIME-Version: 1.0
Subject: Re: my opinion about VGA devices
CC: <linux-kernel@vger.kernel.org>
Message-ID: <41763D7C.26451.1B52EDE7@localhost>
In-reply-to: <417590F3.1070807@dbservice.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky <tom@dbservice.com> wrote:

> I don't like the framebuffer devices or even the DRI drivers
> because: most applications use a 'high-level' API for rendering
> (OpenGL). These 'high-level commands' are translated to
> 'intermediate commands' (framebuffer/DRI ioctl calls etc.) before
> being send to the card as 'low-level commands'. Why this
> intermediate layer? 

I am not sure what you are trying to propose here, but really you should 
go back and read up on how graphics device drivers work, more 
specifically DRI. If you do that, it will be clear that DRI drivers are 
the internal 'meat' implementation for OpenGL on Linux. DRI is not an 
intermediate layer that can be eliminated at the swish of your hand and 
instantly get more performance! OpenGL drivers on Linux using DRI build 
up packets of 3D commands to be send to the hardware in *user mode* into 
DMA buffers. Then a command is sent to the kernel driver to start sending 
the data to the hardware using DMA. The overhead of the ioctl's to the 
/kernel to start the DMA packets is not very high (although IMHO this 
could all be moved into user space also, but that is a different story).

As for the framebuffer console, it exists purely to get high resolution 
text consoles working with basic graphics capabilities. It was never 
intended to be a complete graphics environment, but just the console that 
can be used in graphics modes. The original versions of the framebuffer 
console code were developed not for x86 machines but for non-x86 machines 
that did not have any VGA capabilities at all (ie: Mac's). For Linux to 
work on such machines, the console needed to be able to output text in 
graphics modes since that is what the machines booted in. Once this was 
done for non-x86 boxes, it was realised this would be a 'cool' feature 
for x86 machines for two reasons. 1 - you get a nice high resolution text 
console, way better than VGA text mode and, 2 - you can display the cool 
penguin logo ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


