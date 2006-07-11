Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWGKH5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWGKH5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWGKH5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:57:45 -0400
Received: from wasp.net.au ([203.190.192.17]:17891 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1750717AbWGKH5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:57:44 -0400
Message-ID: <44B359F7.3050500@wasp.net.au>
Date: Tue, 11 Jul 2006 11:57:43 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: suspend2-devel@lists.suspend2.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: /dev/rtc not suspending/resuming properly
References: <44B24CEB.9010103@wasp.net.au> <20060710223629.GA7443@elf.ucw.cz>
In-Reply-To: <20060710223629.GA7443@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>> I've had a pretty good look at drivers/char/rtc.c and I can't see anywhere 
>> it would actually suspend/resume in the code, and investigation shows it 
>> does not appear to re-init the hardware on resume.
> 
> Well, you probably need to write suspend/resume support for it...

So it would seem..

I know absolutely nothing about the driver model (let alone C or kernel voodo in general) and have 
been investigating Documentation/driver-model. Would I be close if I were to suggest this needs to 
be a platform_driver? I'll certainly have a crack at it if I'm on the right track.

I've been having a look at some of the other drivers that use platform_driver however I'm a bit 
stumped at how I go about iterating through the various sparc buses using the platform_driver 
resource allocation functions.

#ifdef __sparc__
         struct linux_ebus *ebus;
         struct linux_ebus_device *edev;
#ifdef __sparc_v9__
         struct sparc_isa_bridge *isa_br;
         struct sparc_isa_device *isa_dev;
#endif
#endif

Or, do I just dodgy it up as the rtc is a legacy device, and leave the probe/allocation code alone 
and just add the pm stuff?

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
