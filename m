Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUIAPbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUIAPbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUIAP3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:29:37 -0400
Received: from zeus.kernel.org ([204.152.189.113]:23234 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266894AbUIAP3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:29:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Driver retries disk errors.
Date: Wed, 01 Sep 2004 11:18:30 -0400
Organization: TMR Associates, Inc
Message-ID: <ch4oq3$fse$1@gatekeeper.tmr.com>
References: <20040831170016.GF17261@harddisk-recovery.com><20040830163931.GA4295@bitwizard.nl> <1093968767.597.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1094051460 16270 192.168.12.100 (1 Sep 2004 15:11:00 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <1093968767.597.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2004-08-31 at 18:00, Erik Mouw wrote:
> 
>>>For non hard disk cases many devices do want and need retry.
>>
>>And many others do not. CompactFlash readers are usually implemented as
>>a USB storage device, which on its turn is implemented as a SCSI
>>"disk". So far I haven't seen a CompactFlash which could be "fixed" by
>>retries.
> 
> 
> It does no harm trying. It does real harm not being conservative and
> losing peoples data. You recover people's data after its lost, the
> IDE layer's job is to make sure it doesn't get lost in the first place.
> 
> 
>>(1) Imagine an application doing a linear read on a file with an 8
>>block read ahead and the last block being bad. The kernel will try to
>>read that bad block 16 times, but because the IDE driver also has 8
>>retries, the kernel will try to read that bad block *64* times. It
>>usually takes an IDE drive about 2 seconds to figure out a block is
>>bad, so the application gets stuck for 2 minutes in that single bad
>>block.
> 
> 
> Right now I know of no way to tell which is readahead for a failed
> command or of telling the block layer to forget them. Fix this at the
> block layer and IDE can abort the readahead sequence happily enough
> because IDE is too dumb to have issued further commands to the drive at
> this point.

If would probably be good to retry "read what you were asked, nothing 
more" on error, to avoid passing back errors caused by readahead. I 
suspect this would avoid some issues reading data off CD as well, where 
one software can read clean and another ends with a short image and error.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
