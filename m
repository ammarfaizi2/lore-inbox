Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUJVEtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUJVEtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270403AbUJTO0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:26:10 -0400
Received: from neopsis.com ([213.239.204.14]:899 "EHLO matterhorn.neopsis.com")
	by vger.kernel.org with ESMTP id S270326AbUJTOO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:14:28 -0400
Message-ID: <417672BF.5040708@dbservice.com>
Date: Wed, 20 Oct 2004 16:14:23 +0200
From: Tomas Carnecky <tom@dbservice.com>
Organization: none
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my opinion about VGA devices
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org> <41765A8C.2020309@dbservice.com> <Pine.LNX.4.61.0410200851080.10711@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410200851080.10711@chaos.analogic.com>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On ix86 machines, regardless of whatever code initialized the
> hardware, if the screen-card is not put into graphics mode,
> anybody can write characters and attributes at 0xb8000 directly
> to the screen. Even user-mode code can mmap() that area and write
> to it. So, the key seems to be to get out of graphics mode
> before suspend, and go back later after resume.

Why do you let user-mode programs access the hardware directly?
You don't do this with network devices (there you have syscalls), you 
don't do this with sound devices (alsa).
IMO it makes a proper power managment implementation impossible.

You can say that there are two different drivers for screen-cards in the 
kernel. One is the VGA which enables the card during early boot time to 
display the first text messages and the other is fb/DRI or even an 
nvidia/ati kernel module which is enabled later on.
Last time I've tried a LiveCD distro I've seen a nice boot console with 
background picture, high resolution (1024x768) and nice small font. That 
means that the framebuffer driver had to be initialized at that time. I 
don't have framebuffer drivers compiled into my kernel so I don't know 
at which point these are initialized, but it must be at a quite early 
point in the boot process.
When looking at the output of dmesg I can see that the first thing that 
is initialized are the CPU's, ACPI, IRQ's and then the PCI bus is 
scanned. Did anyones machine crash during these steps? I don't think a 
healthy box will crash here. And at this point you can initialize your 
graphics card driver like it is done in the LiveCD distro.

tom
