Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUJOXC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUJOXC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUJOXC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 19:02:58 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:15779 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266687AbUJOXC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 19:02:56 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R0WPoKBzjQIp+EsnrpSuClyIrOmfR+d+SomaHnLpfTtMW9cyFgwQ8GnsKEarErTe1vtXTinjT1pvpAr2wBAX62YRkCKQ0j4e2kmKSrFITOaZNHSd21ftNcnEikv3pMsyub4TJFvh8F89Z0bhBFjtzAYU4Ot+0yx03YhnZMx3KaQ
Message-ID: <9e47339104101516027860bb1e@mail.gmail.com>
Date: Fri, 15 Oct 2004 19:02:55 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Kendall Bennett <kendallb@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <416FEB4B.9875.2A1DBFE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <416FB275.6425.1C3D985@localhost>
	 <9e4733910410151319159482ce@mail.gmail.com>
	 <416FEB4B.9875.2A1DBFE@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004 15:22:51 -0700, Kendall Bennett
<kendallb@scitechsoft.com> wrote:
> What about non-x86 platforms such as PowerPC and MIPS embedded devices
> that want video (TiVo type platforms, media players etc). How would these
> fit into the picture? Would this require the boot loader (ie: U-Boot or
> whatever) to have the ability to POST the card?

There is the assumption that whatever BIOS the device has can get up a
very early console that can output critical error messages before the
kernel and early user space is loaded. For example the "I can't find
the kernel" or  "initramfs is missing" error message. This also
assumes that the BIOS can post whatever display it is using.

I'm not trying to fix the problem of getting early boot messages out
of a Mac with an x86 card plugged into it. The card will work after
early user space initializes. The right way to fix that would be to
switch to something like LinuxBIOS and build the x86 emulator into it.

Also note that a lot of what you think are early boot messages are not
really being printed out during early boot. The kernel queues printks
until a console is running and then outputs them. An example of
queuing is the processor initialization messages for the first
processor. I believe there is a way to force messages like this to
print as they occur using the BIOS on x86.

> Or perhaps the VideoBoot module would be a useful addition to the VGA
> boot driver compiled into the kernel to bring up the video card into a
> sane state on any system (even a dumb framebuffer linear mode) so a fully
> accelerated console driver in user space can take over later on?

-- 
Jon Smirl
jonsmirl@gmail.com
