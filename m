Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUL2MtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUL2MtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 07:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbUL2MtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 07:49:24 -0500
Received: from [195.23.16.24] ([195.23.16.24]:57548 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261297AbUL2MtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 07:49:19 -0500
Message-ID: <41D2A7BE.2030806@grupopie.com>
Date: Wed, 29 Dec 2004 12:49:02 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Park <opengeometry@yahoo.ca>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost> <20041229015622.GA2817@node1.opengeometry.net>
In-Reply-To: <20041229015622.GA2817@node1.opengeometry.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.39; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park wrote:
>[...]
> 
> Ideally, motherboard should support booting from USB key drive directly.
> I'm told that most modern motherboards do support usbboot, but my
> machine doesn't.  So, I trying to load the kernel from floppy (harddisk
> for testing purpose).  This is part of my attempt to build Linux
> thin-client out of mini-ITX type of computer (Via CLE266 chipset, Via C3
> cpu).
> 
> Now, I need to find a machine that actually can do usbboot...

You will have the same problem even if the BIOS supports booting from 
USB. The BIOS will load the bootloader and map the USB drive as if it 
were a regular disk, so that the INTxx calls (can't say the number from 
memory) that LILO (or another bootloader) uses to load the kernel and 
initrd into memory will work.

After that, the kernel boots the same way as if it were loaded from a 
floppy. It still needs to discover the USB drive to mount the root 
filesystem, and that will still take the 5 seconds you were complaining 
about.

As Trent Lloyd already mentioned, you could solve this using a small 
initrd and a "nash" script, instead of patching the kernel, although I'm 
in favor of a patch of this sort getting into mainline.

After all, what is the use of kernel saying "Panic, can not mount the 
root filesystem" instead of saying "humm... no root file system there. 
Let me try again in a second or so and see if anything as come up..."?

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

