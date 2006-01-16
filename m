Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWAPKAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWAPKAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 05:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWAPKAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 05:00:10 -0500
Received: from gw.webart.net ([195.30.14.5]:4326 "EHLO gw.webart.net")
	by vger.kernel.org with ESMTP id S932308AbWAPKAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 05:00:08 -0500
Message-ID: <43CB6E96.6030907@packetalarm.com>
Date: Mon, 16 Jan 2006 10:59:50 +0100
From: Nils Rennebarth <nils.rennebarth@packetalarm.com>
Organization: Varysys GmbH & Co. KG
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e100 in 2.6.15 fails unless irqpoll ist used
References: <43C50ED4.3090707@packetalarm.com> <20060111102536.5d91fd92.akpm@osdl.org>
In-Reply-To: <20060111102536.5d91fd92.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2006 09:55:52.0648 (UTC) FILETIME=[0958A480:01C61A83]
X-Commtouch-RefId: str=0001.0A090202.43CB6D80.0030,ss=1,fgs=0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nils Rennebarth <nils.rennebarth@packetalarm.com> wrote:
> 
>>An upgrade from 2.6.14.3 to 2.6.15 on my testmachine disabled my network cards: 
>> no packets are sent or received.
>>
>> There is the following in dmesg:
>>
>> usbcore: registered new driver usbfs
>> usbcore: registered new driver hub
>> USB Universal Host Controller Interface driver v2.3
>> irq 11: nobody cared (try booting with the "irqpoll" option)
>>   [<c012ae21>] __report_bad_irq+0x31/0x77
>>   [<c012aef4>] note_interrupt+0x75/0x99
>>   [<c012a9f0>] __do_IRQ+0x65/0x91
>> ...
>>
>> Rebooting with irqpoll will make the network cards work. The above message will 
>> appeare nonetheless.
> 
> 
> This means that your IRQ routing broke and the card's interrupt requests
> are not getting through.
> 
> This is likely to be an ACPI regression.  Please raise a report at
> bugzilla.kernel.org, generate full `dmesg -s 1000000' output for both
> 2.6.14.3 and for 2.6.15 and attach them to the report, thanks.
Thanks for your fast reply.

As I do not have access to my work machine from home I could only answer today, 
and try what I might, I am not able to reproduce the mentioned behaviour any more.

The first thing I tried last Wednesday was to pull out an unused Adaptec 
AHA-2940U SCSI controller which happened to be in the machine for testing 
purposes only.

This "fixed" the network cards as well and now reinserting the SCSI adapter does 
not break them again, neither can I reproduce the "nobody cared" message. 
Unfortunately I also overwrote the saved dmesg from a boot where the network 
cards *did* break.

So the only thing I have is a dmesg (which I cannot reproduce) where irqpoll 
seems to have fixed the problem, and apart form the missing "nobody cares" plus 
the backtrace, it differs from the current one in the order the hardware is 
detected.

I'll be more cautious to save useful information if said behaviour raises its 
ugly head again, but for now, thanks and sorry for the noise.


-- 

Mit freundlichen Grüßen / with kind regards

Nils Rennebarth
--
VarySys Technologies GmbH & Co. KG
Moenchhaldenstraße 28
70191 Stuttgart
Germany
Tel +49 711 2501198
Fax +49 711 2501197
mailto:Nils.Rennebarth@packetalarm.com
http://www.packetalarm.com

Download the free software trial version of PacketAlarm now
http://www.packetalarm.com/download/
