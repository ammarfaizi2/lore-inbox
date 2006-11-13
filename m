Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754825AbWKMPDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbWKMPDV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbWKMPDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:03:21 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:31412
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1754825AbWKMPDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:03:20 -0500
Message-ID: <45588895.7010501@microgate.com>
Date: Mon, 13 Nov 2006 09:00:37 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, khc@pm.waw.pl,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de> <4558860B.8090908@garzik.org>
In-Reply-To: <4558860B.8090908@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Toralf Förster wrote:
> 
>> Hello,
>>
>> the build with the attached .config failed, make ends with:
>> ... UPD     include/linux/compile.h
>>   CC      init/version.o
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>> drivers/built-in.o: In function `hdlcdev_open':
>> synclink.c:(.text+0x650d5): undefined reference to `hdlc_open'
>> synclink.c:(.text+0x6510d): undefined reference to `hdlc_open'
>> ...
>> synclink_cs.c:(.text+0x7aece): undefined reference to `hdlc_ioctl'
>> drivers/built-in.o: In function `hdlcdev_init':
>> synclink_cs.c:(.text+0x7b336): undefined reference to `alloc_hdlcdev'
>> drivers/built-in.o: In function `hdlcdev_exit':
>> synclink_cs.c:(.text+0x7b434): undefined reference to 
>> `unregister_hdlc_device'
>> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> Does this patch work for you?
> 
>     Jeff

No, this patch is not acceptable.

This has been beaten to death in previous threads.
The problem is a mismatch in your kernel config between
generic hdlc (M) and synclink (Y).

synclink drivers can *optionally* support generic hdlc.
You *must* be able to build synclink driver without generic hdlc.
Because of this you *can't* just put in the generic hdlc dependency.

Several alternative patches were posted (3 or 4 months) ago.
No particular patch won the approval of all kernel developers,
so nothing was done.

-- 
Paul Fulghum
Microgate Systems, Ltd.
