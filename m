Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264214AbUDOOwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbUDOOwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:52:15 -0400
Received: from pop.gmx.de ([213.165.64.20]:41131 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264257AbUDOOwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:52:08 -0400
X-Authenticated: #4512188
Message-ID: <407EA194.20904@gmx.de>
Date: Thu, 15 Apr 2004 16:52:04 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Konstantin Sobolev <kos@supportwizard.com>
CC: Justin Cormack <justin@street-vision.com>,
       Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: poor sata performance on 2.6
References: <200404150236.05894.kos@supportwizard.com> <200404151826.54488.kos@supportwizard.com> <1082039593.19568.75.camel@lotte.street-vision.com> <200404151848.05857.kos@supportwizard.com>
In-Reply-To: <200404151848.05857.kos@supportwizard.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Sobolev wrote:
> On Thursday 15 April 2004 18:33, Justin Cormack wrote:
> 
>>On Thu, 2004-04-15 at 15:26, Konstantin Sobolev wrote:
>>
>>>On Thursday 15 April 2004 18:00, Justin Cormack wrote:
>>>
>>>>hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks,
>>>>and Seagate from the same controller. Can you send lspci,
>>>>/proc/interrupts and dmesg...
>>>
>>>Attached are files for 2.6.5-mm5 with highmem, ACPI and APIC turned off.
>>
>>ah. Make a filesystem on it and mount it and try again. I see you have
>>no partition table and so probably no filesystem. This means the block
>>size is set to default 512byte not 4k which makes disk operations slow.
>>Any filesystem should default to block size of 4k, eg ext2.
> 
> 
> Very interesting!
> created partition table,
> kos sata # mkfs.ext2 /dev/sda1
> [..skipped..]
> kos mnt # cd /
> kos / # mkdir wd
> kos / # mount /dev/sda1 /wd
> kos / # hdparm -t -a8192 /dev/sda

[snip]

> So first time it gave the same loosy 27 MB/s and subsequent tests give pretty 
> good 68 MB/s! Why?

I once reported that to lkml but got no reaction. siimage.c doesn't show 
this behaviour.

Prakash
