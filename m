Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUIAP3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUIAP3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUIAP33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:29:29 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:19687 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S266892AbUIAP2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:28:52 -0400
Message-ID: <4135EAAE.3030605@softhome.net>
Date: Wed, 01 Sep 2004 17:28:46 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.7.1 (Macintosh/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>, arjanv@redhat.com,
       viro@parcelfarce.linux.theplanet.co.uk
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
References: <courier.41359B53.00007549@softhome.net>            <20040901095229.GA11908@devserv.devel.redhat.com> <courier.4135A19B.00007EA5@softhome.net> <4135B9FC.7050602@hist.no> <4135CEB4.5020102@softhome.net>
In-Reply-To: <4135CEB4.5020102@softhome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:
> 
> P.P.S. Hm. Why not implement ioctl2()? which will be linked directly to 
> device by its driver? - numbering will be internal to driver, and 
> provide entry point into driver for user space applications. No one 
> likes mess with ioctl()s in Linux - no device driver developers, nor 
> users. But what is really needed - is just call into driver. Paramenter 
> - single pointer have being proved to be sufficient.
> 

   Ok. Now I recalled those mess with ioctl()s - someone have tryed to 
implement virtual methods from OO languages with file descriptors and 
miserably failed.

   I have never used ioctl()s for anything asides calling my drivers. I 
have seens people using ioctl codes for special functionality for block 
devices.

   Position "ioctl()s bad" is not related to drivers per se. People 
decided to not introduce another calls like eject_media(fd) or 
get_info(fd) - but instead implement ioctl() which will magically work 
on all fd's of block devices.
   That where mistake is. That the kind of ioctl()s, which are bad. 
ioctl() is for something what doesn't have interface. If something have 
stable interface - it must be moved over to sys/library calls.

   Instead of "painful ioctl()s" - I would rather start with solving 
this problem for standard devices: making a way to implement efficiently 
common functions for device classes. (terminals, block devices, network 
interfaces, etc). And start obsoleting/removing ioctl()s.

   I like aproach of *BSD - they routinely implement library/sys calls 
for things like that. I used if_*/getif* calls to find/operate network 
interfaces - it is much more usable & better documented, than Linux' 
bunch of magic ioctl()s (again) on _any_ network socket. Why on any? Why 
we cannot have special device to operate on list of interfaces?

   I believe people here on LKML identified problem incorrectly.
