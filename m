Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUJTPHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUJTPHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUJTPCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:02:20 -0400
Received: from neopsis.com ([213.239.204.14]:41603 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S267686AbUJTPBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:01:11 -0400
Message-ID: <41767DB4.9040008@dbservice.com>
Date: Wed, 20 Oct 2004 17:01:08 +0200
From: Tomas Carnecky <tom@dbservice.com>
Organization: none
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my opinion about VGA devices
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org> <41765A8C.2020309@dbservice.com> <Pine.LNX.4.61.0410200851080.10711@chaos.analogic.com> <417672BF.5040708@dbservice.com> <Pine.LNX.4.61.0410201022370.12062@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410201022370.12062@chaos.analogic.com>
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

>> Why do you let user-mode programs access the hardware directly?
>> You don't do this with network devices (there you have syscalls), you 
>> don't do this with sound devices (alsa).
> 
> 
> Any root process can mmap() any of the memory-mapped hardware
> including network devices. This isn't normally done because
> handling interrupts from such hardware isn't very efficient
> in user-mode, and redistributing data meant for another
> process would be a nightmare. However, it can be done.
> 
>> IMO it makes a proper power managment implementation impossible.
>>
> 
> Wrong. The 'normal' user can't do such I/O, root can. See iopl(), which
> sets the I/O privilege level. This has nothing to do with power-
> management.

Power managment should be done in the kernel, that's why there is sysfs 
and the kobjects. But it can't be done properly if some process from 
user-mode (even root processes) do access the hardware directly.
Power managment isn't the only reason why it shouldn't be done, but also 
everything related to the device managment etc. There should always be a 
driver between a process and the hardware as a protection.

> 
>> Last time I've tried a LiveCD distro I've seen a nice boot console 
>> with background picture, high resolution (1024x768) and nice small 
>> font. That means that the framebuffer driver had to be initialized at 
>> that time. I don't have framebuffer drivers compiled into my kernel so 
>> I don't know at which point these are initialized, but it must be at a 
>> quite early point in the boot process.
> 
> 
> Even Fedora, which boots in a 'graphical' mode, really boots standard
> text-mode until 'init' gets control. They just hide the console output
> by setting the grub command-line parameter, "quiet".
> 
> The kernel messages are still available using `dmesg`. If you want
> to eliminate any possibility of losing kernel messages because
> the kernel failed to get up all the way, just use /dev/ttyS0 as
> your console during boot.

Well... that's why I don't understand why we should keep the VGA code in 
the kernel. It's very unlikely that the kernel crashes before a graphics 
driver can be initialized (if you do this as soon as possible) unless 
you have a bad CPU etc.

tom
