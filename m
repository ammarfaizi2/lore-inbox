Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVHXBUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVHXBUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHXBUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:20:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:13252 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751326AbVHXBUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:20:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <430BCB41.5070206@s5r6.in-berlin.de>
Date: Wed, 24 Aug 2005 03:20:01 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
References: <355e5e5e05080103021a8239df@mail.gmail.com>	 <4789af9e050823124140eb924f@mail.gmail.com> <4789af9e050823154364c8e9eb@mail.gmail.com> <430BA990.9090807@mvista.com>
In-Reply-To: <430BA990.9090807@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.55) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Jim Ramsay wrote:
>> On 8/23/05, Jim Ramsay <jim.ramsay@gmail.com> wrote:
>>> I've applied this set
>>> of patches to a 2.6.11 kernel (with few problems) and ran into a bunch
>>> of "scheduling while atomic" errors when hotplugging a drive, culprit
>>> being probably scsi_sysfs.c
...
>> After further debugging, it appears that the problem is the debounce
>> timer in libata-core.c.
>>
>> Timers appear to operate in an atomic context, so timers should not be
>> allowed to call scsi_remove_device, which eventually schedules.
>>
>> Any suggestions on the best way to fix this?
> 
> Workqueue, perhaps.

The USB and IEEE 1394 subsystems have kernel threads which manage node 
additions and removals (usb/storage/usb.c, ieee1394/nodemgr.c). The add 
and remove functions of their storage drivers are called from these 
threads' non-atomic context. However if you don't need an own thread for 
any further bus management purposes, a workqueue looks suitable for hot 
plugging and unplugging.
-- 
Stefan Richter
-=====-=-=-= =--- ==---
http://arcgraph.de/sr/
