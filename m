Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVBCWfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVBCWfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVBCWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:31:46 -0500
Received: from [211.58.254.17] ([211.58.254.17]:6638 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261898AbVBCWUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:20:20 -0500
Message-ID: <4202A39E.8020004@home-tj.org>
Date: Fri, 04 Feb 2005 07:20:14 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
References: <20050202024017.GA621@htj.dyndns.org>	 <20050202025448.GL621@htj.dyndns.org>	 <58cb370e05020216476a8f403c@mail.gmail.com>	 <20050203113710.GV5710@suse.de>	 <58cb370e05020305304e5d504@mail.gmail.com>	 <20050203133228.GA2816@suse.de> <58cb370e05020305354cbb16ee@mail.gmail.com>
In-Reply-To: <58cb370e05020305354cbb16ee@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Thu, 3 Feb 2005 14:32:29 +0100, Jens Axboe <axboe@suse.de> wrote:
> 
>>On Thu, Feb 03 2005, Bartlomiej Zolnierkiewicz wrote:
>>
>>>On Thu, 3 Feb 2005 12:37:10 +0100, Jens Axboe <axboe@suse.de> wrote:
>>>
>>>>On Thu, Feb 03 2005, Bartlomiej Zolnierkiewicz wrote:
>>>>
>>>>>On Wed, 2 Feb 2005 11:54:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
>>>>>
>>>>>>>11_ide_drive_sleeping_fix.patch
>>>>>>>
>>>>>>>      ide_drive_t.sleeping field added.  0 in sleep field used to
>>>>>>>      indicate inactive sleeping but because 0 is a valid jiffy
>>>>>>>      value, though slim, there's a chance that something can go
>>>>>>>      weird.  And while at it, explicit jiffy comparisons are
>>>>>>>      converted to use time_{after|before} macros.
>>>>>
>>>>>Same question as for "add ide_hwgroup_t.polling" patch.
>>>>>AFAICS drive->sleep is either '0' or 'timeout + jiffies' (always > 0)
>>>>
>>>>Hmm, what if jiffies + timeout == 0?
>>>
>>>Hm, jiffies is unsigned and timeout is always > 0
>>>but this is still possible if jiffies + timeout wraps, right?
>>
>>Precisely, if jiffies is exactly 'timeout' away from wrapping to 0 it
>>could happen. So I think the fix looks sane.
> 
> 
> agreed

Actually, jiffies is initialized to INITIAL_JIFFIES which is defined in 
such a way that it overflows after 5 min after boot to help finding bugs 
related to jiffies wrap.  So, the chance of something weird happening in 
the bugs fixed in patches 11 and 12 isn't that exteremely slim.  :-)

-- 
tejun

