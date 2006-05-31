Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWEaABQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWEaABQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWEaABP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:01:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:24025 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932538AbWEaABP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:01:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mS0P0wCSjw6Ptj/Fivnn2VkCRTyqhFyxNjDoSOy1XgjQl0Mgt5EnI7xkzalHzLLu34gQcFiRyjfxpzTmBLm5BTjM2ttOfcWJZmFdcVBCfiLJJW9znqFJQN7tw1XFdHoaPPfm+SrXs6ED2yCGWGFADgrDrzqLu4IMztlY48aViRY=
Message-ID: <447CDCB7.8080708@gmail.com>
Date: Wed, 31 May 2006 08:00:55 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com> <20060529124840.GD746@elf.ucw.cz> <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com> <20060530202401.GC16106@elf.ucw.cz> <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com> <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com> <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com> <20060530233826.GE16106@elf.ucw.cz>
In-Reply-To: <20060530233826.GE16106@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> Actually the suspend/resume has to be in userspace, X just re-posts
>>> the video ROM and reloads the registers... so the repost on resume has
>>> to happen... so some component needs to be in userspace..
>> I'd like to see the simple video POST program get finished. All of the
>> pieces are lying around. A key step missing is to getting klibc added
>> to the kernel tree which is being worked on.
>>
>> BenH has the emu86 code. I agree that is simpler to always use emu86
>> and not bother with vm86. He also pointed out that we need to copy the
>> image back into the kernel after the ROM runs. Right now you can only
>> read the ROM image from the sysfs attribute. The ROM code has support
>> for keeping an image in RAM, it just isn't hooked up to the sysfs
>> attribute for writing it.
> 
> Actually, vbetool is the piece of puzzle we currently use to
> reinitialize graphics cards after resume. (suspend.sf.net).

But vbetool can only handle primary cards, can't it?

> 
> We currently do it all in userspace; it would be cleaner to do it as
> call_usermodehelper() from kernel.

I had a patch sometime before, vm86d.  It's a daemon in userspace that
accepts requests from the kernel which executes x86 instructions using
lrmi, then pushes the result back to the kernel.  I modified vesafb
so that it uses this daemon which makes vesafb acquire the capability
to do on the fly mode switching (similar in functionality with
vesafb-tng which uses a different method).

I abandoned this patch, but it seems there's might be at least one user.

spblinux (http://spblinux.sourceforge.net/)

Tony
