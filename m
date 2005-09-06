Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVIFBUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVIFBUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVIFBUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:20:30 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:15837 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965025AbVIFBUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:20:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bOTVVZKU/ssQAPcG0DH246Wls3Ln/WpRBUDPJ0byxd+TOVtMfh8fJ1k8q+K/K4UQtsboiGBEAI1uHZSbEEjhkYEbumOhLJp7i/k7dB4kDGG6s/CLSo161bZcZNUVjQb8jAnM3DujeSRXTYQO7c+EakjudIoBB/JTIMdXeW139eU=
Message-ID: <431CEEAF.5090701@gmail.com>
Date: Tue, 06 Sep 2005 09:19:43 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gl@dsa-ac.de
CC: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: who sets boot_params[].screen_info.orig_video_isVGA?
References: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de> <E1ECIub-00088O-00@chiark.greenend.org.uk> <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de>
In-Reply-To: <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gl@dsa-ac.de wrote:
> Thanks for the reply, Matthew.
> 
> On Mon, 5 Sep 2005, Matthew Garrett wrote:
> 
>> gl@dsa-ac.de <gl@dsa-ac.de> wrote:
>>> I am trying to get intelfb running on a system with a 855GM onboard
>>> chip,
>>> and the driver exits at intelfbdrv.c::intelfb_pci_register() (2.6.13,
>>> line
>>> 814:
>>>
>>>      if (FIXED_MODE(dinfo) && ORIG_VIDEO_ISVGA != VIDEO_TYPE_VLFB) {
>>>          ERR_MSG("Video mode must be programmed at boot time.\n");
>>>          cleanup(dinfo);
>>>          return -ENODEV;
>>>      }
>>
>> This ought to be done by the bootloader if you pass a vga=foo argument.
>> The framebuffer driver doesn't know how to switch resolutions (primarily
>> because Intel won't tell anyone how to do it, so the only method is a
>> real-mode BIOS call to the VESA BIOS)
> 
> Do I get it right, that, say, if I tell grub to load a kernel and
> specify "vga=xxx" on the kernel command line, grub will interpret it,
> issue some VESA BIOS calls and fill in the screen_info struct? If so,
> the card often supports several modes (VGA, SVGA, VESA, different
> resolutions, colour depths, etc.), right? So, which one will be chosen?
> Does it depend on the specific value I give to "vga="? How do I force
> VIDEO_TYPE_VLFB (VESA VGA in graphic mode) mopde then?
> 
> BTW, I didn't find any code in grub that sets up screen_info, or it's
> very well hidden:-)

One good method is to use the "vesa" driver of Xorg/Xfree86.  Check
/var/log/X*.log and it should have a nice list of vesa mode id's that
are supported.

Then add 0x200 to any of them and use it in your vga= parameter.

Tony 
