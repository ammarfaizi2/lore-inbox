Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbULaL1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbULaL1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbULaL1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:27:00 -0500
Received: from [195.23.16.24] ([195.23.16.24]:25559 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261851AbULaL0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:26:55 -0500
Message-ID: <41D5376A.8000705@grupopie.com>
Date: Fri, 31 Dec 2004 11:26:34 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: William Park <opengeometry@yahoo.ca>, juhl-lkml@dif.dk,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
References: <20041227195645.GA2282@node1.opengeometry.net>	<20041227201015.GB18911@sweep.bur.st>	<41D07D56.7020702@netshadow.at>	<20041229005922.GA2520@node1.opengeometry.net>	<20041230152531.GB5058@logos.cnet>	<Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost>	<Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost>	<20041231035834.GA2421@node1.opengeometry.net> <20041231014905.30b05a11.akpm@osdl.org>
In-Reply-To: <20041231014905.30b05a11.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> William Park <opengeometry@yahoo.ca> wrote:
> 
>>-		printk("VFS: Cannot open root device \"%s\" or %s\n",
>> -				root_device_name, b);
>> -		printk("Please append a correct \"root=\" boot option\n");
>> +		if (--tryagain) {
>> +		    printk (KERN_WARNING "VFS: Waiting %dsec for root device...\n", tryagain);
>> +		    ssleep (1);
>> +		    goto retry;
>> +		}
>> +		printk (KERN_CRIT "VFS: Cannot open root device \"%s\" or %s\n", root_device_name, b);
>> +		printk (KERN_CRIT "Please append a correct \"root=\" boot option\n");
> 
> 
> Why is this patch needed?  If it is to offer the user a chance to insert
> the correct medium or to connect the correct device, why not rely upon the
> user doing that thing and then hitting reset?

No, no. The problem is not user interaction.

The problem is that the USB subsystem takes a lot of time to go through 
the hostcontrollers -> hubs -> devices. By the time it finds the USB 
mass storage that is supposed to be used as root filesystem, the kernel 
had already panic'ed.

IMHO the kernel should handle this case just fine, without the need for 
initrd's. After all the user says "my root filesystem is /dev/sda1", and 
the kernel panic's even though the filesystem is there. This doesn't 
seem like a correct bahavior.

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

