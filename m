Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290962AbSBLKxJ>; Tue, 12 Feb 2002 05:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290965AbSBLKw7>; Tue, 12 Feb 2002 05:52:59 -0500
Received: from [195.63.194.11] ([195.63.194.11]:17932 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S290962AbSBLKwx>; Tue, 12 Feb 2002 05:52:53 -0500
Message-ID: <3C68F3F3.8030709@evision-ventures.com>
Date: Tue, 12 Feb 2002 11:52:35 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>This is slightly longer but also simple cleanup. It kills code
>duplication and removes unneccessary assignments/casts. Please apply,
>	
>
If you are already at it, I would like to ask to you consider seriously 
the removal of the
following entries in the ide drivers /proc control files:

    ide_add_setting(drive,    "breada_readahead",    ...         1,    
2,    &read_ahead[major],        NULL);
    ide_add_setting(drive,    "file_readahead",   ...    
&max_readahead[major][minor],    NULL);

Those calls can be found in ide-cd.c, ide-disk,c and ide-floppy.c

The first does control an array of values, which doesn't make sense in 
first place. I.e. changing it doesn't
change ANY behaviour of the kernel.

The second of them is trying to control a file-system level constant 
inside the actual block device driver.
This is a blatant violation of the layering principle in software 
design, and should go as soon as
possible.

BTW.> The wole IDE /proc stuff found there makes me vommit...
Both in terms of interface and in terms of coding style.
Apparently Andre Hendrick doesn't know what ioctrl are about and is 
missing the windows
registry greatly.



