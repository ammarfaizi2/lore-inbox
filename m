Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVCBTEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVCBTEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVCBTEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:04:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53400 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262409AbVCBTEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:04:33 -0500
Message-ID: <42260E2D.2080407@pobox.com>
Date: Wed, 02 Mar 2005 14:04:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl>	 <200502271731.29448.bzolnier@elka.pw.edu.pl>	 <422337A1.4060806@gmail.com>	 <200502281714.55960.bzolnier@elka.pw.edu.pl>	 <20050301042116.GA9001@htj.dyndns.org>	 <58cb370e05030100424d98c85c@mail.gmail.com>	 <20050301092914.GA14007@htj.dyndns.org>	 <58cb370e05030101592a46c258@mail.gmail.com>	 <42255878.7080908@pobox.com> <58cb370e050302020950da588a@mail.gmail.com>
In-Reply-To: <58cb370e050302020950da588a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 02 Mar 2005 01:08:56 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>>Yes but it seems that you've assumed that ioctl == flagged taskfile
>>>and fs/internal == normal taskfile which is _not_ what I aim for.
>>>
>>>I want fully-flagged taskfile handling like flagged_taskfile() and "hot path"
>>>simpler taskfile handling like do_rw_taskfile() (at least for now - we can
>>>remove "hot path" later) where both can be used for fs/internal/ioctl requests
>>>(depending on the flags).
>>
>>There is no effective difference in performance between
>>
>>        writeb()
>>        writeb()
>>        writeb()
>>        writeb()
>>
>>and
>>
>>        if (bit 1)
>>                writeb()
>>        if (bit 2)
>>                writeb()
>>        if (bit 3)
>>                writeb()
>>        if (bit 4)
>>                writeb()
>>
>>The cost of a repeated bit test on the same unsigned long is _zero_.
>>It's already in L1 cache.  The I/Os are slow, and adding bit tests will
> 
> 
> certainly it is not _zero_ ;-)
> 
> I agree that it is negligible compared to the cost of I/O

True :)

	Jeff



