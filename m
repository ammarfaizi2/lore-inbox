Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWC1Rzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWC1Rzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWC1Rzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:55:47 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:44434 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932120AbWC1Rzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:55:45 -0500
Date: Tue, 28 Mar 2006 12:55:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Detecting I/O error and Halting System
In-reply-to: <20060328150712.85169.qmail@web30602.mail.mud.yahoo.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200603281255.42705.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <20060328150712.85169.qmail@web30602.mail.mud.yahoo.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 10:07, zine el abidine Hamid wrote:
>First of all, thank you for your analysis.
>
>I don't think that it's a HDD problem nor a cable
>problem because the servers are new. We have tried
>different HDD (seagate, maxtor) but it has not help
>anyway.
>It's perhaps a temperature problem but we make a lot
>tests in hard condition (high temperature)
>successfuly...
>
>One thinks that the problem comes from the VIA chipset
>VT82c686 (it's also the opinion of Dick Johnson
>(linux-os) whom advised me to try UDMA33 instead of
>UDMA66).
>
>How can I determine the problem?
>
>I want to add that the HDD seems to be disconnected
>(the BIOS can't find any drive for boot) after a
>simple reset. We must switch off the servers to get
>them work again.
>However, it takes a long time (4 mounths and more)
>before the HDD fell down. I want to work around by
>write a module which will supervise the HDD. I know
>how to write a module (I used the lkmpg guide
>(http://www.tldp.org/LDP/lkmpg/) but how can I
>shutdown Linux from inside a module...?
>
>best regards.
>
>Zine.

I take it that you are aware of a drive monitoring utility called 
smartd?  By querying the drive after a new powerup, you may be able to 
extract usefull information about its health.

>--- Alan Cox <alan@lxorguk.ukuu.org.uk> a écrit :
>> On Llu, 2006-03-27 at 16:55 +0200, zine el abidine
>>
>> Hamid wrote:
>> > hda: status timeout: status=0xd0 { Busy }
>>
>> adapter
>>
>> > disque annonce un status busy du DMA
>>
>> If I'm reading the translation right then your hard
>> disk decided
>> it was busy and then never came back
>>
>> > Feb 12 04:46:23 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > ide0: reset: success
>>
>> So the IDE layer tried to reset it
>>
>> > Feb 12 10:22:38 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > hda: timeout waiting for DMA
>>
>> Which didnt help
>>
>> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > ide0: reset: success
>>
>> Still trying
>>
>> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > hda: irq timeout: status=0xd0 { Busy }
>> >
>> >
>> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > hda: DMA disabled
>>
>> We gave up on DMA to see if PIO would help
>>
>> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > ide0: reset timed-out, status=0x80
>> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > hda: status timeout: status=0x80 { Busy }
>> > nouvel échec de reset
>> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > hda: drive not ready for command
>> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > ide0: reset: success
>>
>> And reset..
>>
>> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > hda: status timeout: status=0x80 { Busy }
>> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > hda: drive not ready for command
>> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > ide0: reset timed-out, status=0x80
>> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > end_request: I/O error, dev 03:02 (hda), sector
>>
>> 102263
>>
>> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
>>
>> syslogd:
>> > /var/log/maillog: Input/output error
>> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > end_request: I/O error, dev 03:02 (hda), sector
>>
>> 110720
>>
>> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
>>
>> kernel:
>> > end_request: I/O error, dev 03:02 (hda), sector
>>
>> 110728
>>
>> Eventually we give up.
>>
>>
>> First thing to check would be the disk and the
>> temperature, then the
>> cabling. In particular make sure the *long* part of
>> the cable is between
>> the drive and the controller.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
