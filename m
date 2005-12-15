Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbVLOJGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbVLOJGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbVLOJGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:06:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:63981 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161086AbVLOJG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:06:29 -0500
Message-ID: <43A13206.3080704@suse.de>
Date: Thu, 15 Dec 2005 10:06:14 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] uml: Framebuffer driver for UML
References: <439EE38C.6020602@suse.de> <439EE5B0.2030709@suse.de> <20051213221548.GB9769@ccure.user-mode-linux.org>
In-Reply-To: <20051213221548.GB9769@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> On Tue, Dec 13, 2005 at 04:16:00PM +0100, Gerd Knorr wrote:
>> $subject says pretty much all: This adds a framebuffer driver for UML.
> 
>> please apply,
>>
>>   Gerd
> 
> Please don't.  This patch fails to link for me in -rc5 - the errors start like
> 
> drivers/built-in.o(.text+0x18b): In function `vgacon_deinit':
> /home/jdike/linux/2.6/linux-2.6.15/drivers/video/console/vgacon.c:151: undefined reference to `outw'

Uh, I havn't even tried to build vgacon, it doesn't make sense for UML 
anyway.  It's not needed, my .config looks like this:

CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y

Should be trivially fixable with some Kconfig tweaks, I'll have a look.

> IIRC, I found fixes for these when I merged this into my tree.  It's a nice 
> addition, but there are aspects of this that I don't like, which is why I
> haven't sent it in myself.

What exactly?

> Again, IIRC, enabling this disables the normal 
> consoles, which is fairly unfriendly.

Yep, there is no way around that because the uml consoles hijacked the 
vt subsystem's major #5.  Unlike in older versions of that patch this 
isn't a compile time but a runtime option, so it's much less annonying. 
The uml consoles are present unless you activate the vt subsystem and 
the framebuffer console by boot the kernel with x11=something.

cheers,

   Gerd
