Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWCEXAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWCEXAl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCEXAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:00:41 -0500
Received: from rtr.ca ([64.26.128.89]:63181 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751901AbWCEXAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:00:40 -0500
Message-ID: <440B6D83.1070900@rtr.ca>
Date: Sun, 05 Mar 2006 18:00:19 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com> <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34> <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca>
In-Reply-To: <440B6CFE.4010503@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Justin Piszcz wrote:
>>
>>> Using 2.6.16-rc5-git4 and removing a directory of around 5.0GB of 
>>> files while streaming a 1MB/s video stream on another (SATA disk), 
>>> the I/O seemed to freeze up for a moment and I got this error:
>>>
>>> [4342671.839000] ata1: command 0x35 timeout, stat 0x50 host_stat 0x22
>>>
>>> Only 1 in dmesg, any idea what causes this error?
>>
>> The drive it occured on was a 74GB raptor on an ICH5 controller.
>>
>> [4294673.245000]   Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
>> 0000:00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA 
>> Controller (rev 02)
> 
> SCSI opcode 0x35 is SYNCHRONIZE_CACHE.

Oh, wait a sec.. on that path, libata actually does show the ATA opcode,
which would have been WRITE_DMA_EXT.  Not an FUA command.

Dunno what it's complaining about, though.
