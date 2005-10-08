Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVJHNDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVJHNDi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 09:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVJHNDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 09:03:38 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:47522 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932115AbVJHNDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 09:03:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=XhgLoIr8MyOBazK28CoixZ+rWULkR2oThs1Io7wX3BHd5hZpTbfbu7PuLEW6OWC84i2kEikiGf1DHaRb2vvgdRu45b+lHfjgtBD70SByyPDlHbtpaJcaGHi2RGvPKmUceFrRS+YTY5RRaQw02aRgrBAilWhxIj1HGC+vOGD6Wsk=
Message-ID: <4347C39F.2020703@pol.net>
Date: Sat, 08 Oct 2005 21:03:27 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manuel Lauss <mano@roarinelk.homelinux.net>
CC: "Antonino A. Daplas" <adaplas@gmail.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       adaplas@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Modular i810fb broken, partial fix
References: <200510071547.14616.bero@arklinux.org> <4347A1E7.2050201@pol.net> <4347B3D6.5060700@roarinelk.homelinux.net>
In-Reply-To: <4347B3D6.5060700@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Lauss wrote:
> Antonino A. Daplas wrote:
>> Bernhard Rosenkraenzer wrote:
>>
>>> Hi,
>>> i810fb as a module is broken (checked with 2.6.13-mm3 and
>>> 2.6.14-rc2-mm1).
>>> It compiles, but the module doesn't actually load because the kernel
>>> doesn't recognize the hardware (the MODULE_DEVICE_TABLE statement is
>>> missing).
>>
>>
>>
>>> The attached patch fixes this.
>>>
>>> However, the resulting module still doesn't work.
>>> It loads, and then garbles the display (black screen with a couple of
>>> yellow lines, no matter what is written into the framebuffer device).
>>
>>
>> Did you compile CONFIG_FRAMEBUFFER_CONSOLE statically, or did a
>> modprobe fbcon?
>> Does i810fb work if compiled statically?
> 
> I tried the module on my i815 laptop, after modprobe the module does
> nothing.
> The call to pci_register_driver() returns 0, and thats it; the probe
> function
> does not get called. Same thing with Bernhard's patch applied. No problems
> when compiled-in. Kernel 2.6.14-rc2-mm1, AGP compiled in, no DRM.

That's weird.  Can you find out why the probe function is not called? Can
you trace the pci_register_driver call starting in drivers/pci/pci-driver.c, then
in drivers/base/*.c?

(Or you can #define DEBUG somewhere, perhaps in include/linux/device.h?)
 
Tony 
