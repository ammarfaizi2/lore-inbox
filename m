Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUHBLj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUHBLj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 07:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUHBLjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 07:39:25 -0400
Received: from [195.23.16.24] ([195.23.16.24]:51172 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266469AbUHBLjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 07:39:12 -0400
Message-ID: <410E27DC.4090009@grupopie.com>
Date: Mon, 02 Aug 2004 12:39:08 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David N. Welton" <davidw@dedasys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speedy boot from usb devices
References: <87fz79xk5q.fsf@dedasys.com>
In-Reply-To: <87fz79xk5q.fsf@dedasys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.53; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David N. Welton wrote:
> [ Please CC replies to me - thanks! ]
> 
> Hi,
> 
> I gather that there isn't much interest in this idea on behalf of the
> 'mainstream', because initrd is a far more flexible solution, but I
> happen to like the idea of booting quickly from a USB device, without
> wasting a bunch of time and space for an initrd, and we're using this
> in a product as well, so without further ado, I'll point you at
> 
> http://dedasys.com/freesoftware/patches/
> 
> where you can get blkdev_wakeup.patch
> 
>         Works like so: whenever a block device comes on line, it
>         signals this fact to a wait queue, so that the init process
>         can stop and wait for slow devices, in particular things such
>         as USB storage devices, which are much slower than IDE
>         devices.  The init process checks the list of available
>         devices and compares it with the desired root device, and if
>         there is a match, proceeds with the initialization process,
>         secure in the knowledge that the device in question has been
>         brought up.  This is useful if one wants to boot quickly from
>         a USB storage device without a trimmed-down kernel, and
>         without going through the whole initrd slog.
> 
> Comments, critiques, suggestions and ideas are all welcome.

I find this to be very useful. I always found the "sleep for a while 
until the device we want appears" approach very cumbersome.

However, after looking at your patch, it seems that having a 
get_blkdevs() function that alloc's an array of strings, and return it 
to a function that only compares the strings against the name it is 
looking for and drops the array altogether, is a little overkill.

Why not have a simple blkdev_exists(char *name) function in genhd.c, 
call it directly, and drop the match_root_name() function completely?

Maybe I'm missing something, but it seems much simpler...

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
