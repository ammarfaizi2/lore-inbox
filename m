Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272644AbTG1D5M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 23:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272646AbTG1D5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 23:57:12 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:29969
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272644AbTG1D5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 23:57:08 -0400
Message-ID: <3F24A548.2040202@rogers.com>
Date: Mon, 28 Jul 2003 00:23:36 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yifang Dai <daiy@attbi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 - VFS: Cannot open root device "NULL" or sda1
References: <bg1df5$1c2$1@ask.hswn.dk> <20030728022818.GA7221@yahoo.com>
In-Reply-To: <20030728022818.GA7221@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Mon, 28 Jul 2003 00:11:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yifang Dai wrote:
> On Sun, Jul 27, 2003 at 08:42:13PM +0000, Henrik Storner wrote:
> 
>>So I know 2.6.0-test1 works for me. But 2.6.0-test2 with the same
>>configuration (just a "make oldconfig" in between) stops during boot
>>with:
>>
>>VFS: Cannot open root device "NULL" or sda1
>>Please append a correct "root=" boot option
>>Kernel panic: Unable to mount root fs on sda1
>>
> 
> 
> I've got the same error, except my root device is /dev/hda3. It also
> worked in 2.6.0-test1 :)
> 

I believe you need to change in your grub.conf file the root=/dev/hda3 
to a root=### ie root=0307

The number is composed of 3 pieces

(a) major device number ie. 3 above (leading zero is ignored)
(b) minor device number ie. 0 above
(c) partition on device ie. 7 above

I use hdb. hda and hdb are both major device number 3

hda is minor device number 0
hdb is minor device number 64
BUT minor device number is in base 16
so in base 16, hda is 0 (0x16=0) and hdb is 4 (4x16=64)

THUS

my root=/dev/hdb4 becomes root=344 (ie. maj device 3, minor device 64 
(4x16) and partition #4.

Examples:

hda1 = 301
hda3 = 303
hdb1 = 341
hdb4 = 344 etc.

Pardon if this is obvious. To determine linux device numbers, google. 
there's a list out there. I found a list below:

http://www.lanana.org/docs/device-list/devices.txt

