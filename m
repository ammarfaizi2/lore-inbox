Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269676AbUICMwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbUICMwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269666AbUICMwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:52:25 -0400
Received: from wasp.net.au ([203.190.192.17]:59799 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S269665AbUICMun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:50:43 -0400
Message-ID: <413868CE.7070303@wasp.net.au>
Date: Fri, 03 Sep 2004 16:51:26 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au> <87u0ugt0ml.fsf@stark.xeocode.com>
In-Reply-To: <87u0ugt0ml.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
> Brad Campbell <brad@wasp.net.au> writes:
> 
> 
>>Greg Stark wrote:
>>
>>
>>>Any clue what I need to do to achieve this? Is this a bug because this isn't a
>>>well-travelled code-path? (Dead drives not being something you can conjure up
>>>on demand)? Or is this indicative of more problems than just a crashed drive?
>>>This is on a stock 2.6.6 kernel tree, btw.
>>>
>>
>>Known issue, fixed in 2.6.9-rc1. Apply this to 2.6.6 and your good to go.
> 
> 
> Hm. I'm running 2.6.0-rc1 now. I'm not sure this really fixed the problem.
> 
> I get the same message and the same basic symptom -- any process touching the
> bad disk goes into disk-wait for a long time. But whereas before as far as I
> know they never came out, now they seem to come out of disk-wait after a good
> long time. But then maybe I just never waited long enough with 2.6.6.
> 
> I do still get the "ATA: abnormal status 0x59 on port 0xEFE7" so if that's a
> sign something's wrong then something's still wrong. I also now get additional
> messages that I don't recall seeing before. They're included below.
> 
> And as I said, every other process touching the drive, even in good areas,
> enters disk-wait. If I kill -9 the process generating the errors and wait a
> few minutes they seem to eventually exit disk-wait though.
> 
> This means I would be able to do the recovery in theory, but in practice it'll
> just take an infeasible length of time. I have gigs of data to go through and
> at the amount of time it takes to time out after each error it'll take me many
> days (years I think) to just to figure out which blocks to avoid.

Yep.. About 30 seconds per sector is the timeout whereas with 2.6.6 it would never do anything after 
the first timeout. Yes it's slow, yes it could probably be sped up but it is certainly indicative of 
a dodgy disk.

Use something like http://www.kalysto.org/utilities/dd_rhelp/index.en.html and you might have better 
results.

Jeff, do we really have to wait 30 seconds for a timeout? If the drive hits an unreadble spot I 
would have thought it would come back to us with a read error rather than timing out the command.

I do have a dodgy drive here that I have kept around for testing, so I'll have a look at it when I 
get a tic.

Regards,
Brad
