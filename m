Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWBMTpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWBMTpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWBMTpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:45:20 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:16701 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964818AbWBMTpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:45:18 -0500
In-Reply-To: <58cb370e0602130853s4ce767c6j57337a9587cc2963@mail.gmail.com>
References: <58cb370e0602130235h3ab521cep47584ee634e8fc7f@mail.gmail.com> <Pine.LNX.4.44.0602131020370.30316-100000@gate.crashing.org> <58cb370e0602130853s4ce767c6j57337a9587cc2963@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E02DAB4-8DCE-42AA-8F47-080636F78E4C@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
Date: Mon, 13 Feb 2006 13:45:32 -0600
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 13, 2006, at 10:53 AM, Bartlomiej Zolnierkiewicz wrote:

> On 2/13/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>>> +static void cfide_outsl(unsigned long port, void *addr, u32 count)
>>>> +{
>>>> +       panic("outsl unsupported");
>>>> +}
>>>
>>> This will panic as soon as somebody tries to enable 32-bit I/O
>>> using hdparm.  Please add ide_hwif_t.no_io_32bit flag and teach
>>> ide-disk.c:ide_disk_setup() about it (separate patch).
>>
>> I'm not sure I follow this, can you expand.
>
> Do "hdparm -c 2 /dev/hdx" first and then read/write to the device
> and you should see it. :)
>
> We need to make "hdparm -c 2" (and "hdparm -c 3") unsupported
> (see how "io_32bit" setting is handled in ide_add_generic_settings()
> and how it can be read-only or read-write setting depending on the
> value of drive->no_io_32bit).
>
> To do this we need to set drive->no_io_32bit to 1 (see how
> ide_disk_setup() handles it).  Unfortunately 32-bit I/O capability
> is based on capabilities of both host and device so we have to
> add new flag hwif->no_io_32bit to indicate that host doesn't
> support 32-bit I/O.

This all make sense, should I check for hwif->no_io_32bit in  
idedisk_setup() and set drive->no_io_32bit to 1 if hwif->no_io_32bit  
is 1 or do this the test in ide_add_generic_settings()?

- kumar
