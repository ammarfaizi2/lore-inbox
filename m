Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUCVTdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUCVTdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:33:12 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:17540 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262322AbUCVTdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:33:06 -0500
Message-ID: <405F3F71.9090604@namesys.com>
Date: Mon, 22 Mar 2004 22:33:05 +0300
From: Hans Reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Jens Axboe <axboe@suse.de>, Heikki Tuuri <Heikki.Tuuri@innodb.com>,
       linux-kernel@vger.kernel.org, Alexander Zarochentcev <zam@namesys.com>
Subject: Re: True  fsync() in Linux (on IDE)
References: <023001c4100e$c550cd10$155110ac@hebis> <20040322132307.GP1481@suse.de> <20040322151712.GB32519@merlin.emma.line.org>
In-Reply-To: <20040322151712.GB32519@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>Jens Axboe schrieb am 2004-03-22:
>
>  
>
>>There's no such thing as atomic writes bigger than a sector really, we
>>just pretend there is. Timing usually makes this true.
>>    
>>
Can you explain about the timing?

>
>If there is no such atomicity (except maybe in ext3fs data=journal or
>the upcoming reiserfs4 - isn't there?), then nobody should claim so.
>
Well, nobody is going to use anything except reiser4 are they?;-).....

I think that we are able to guarantee that the write is fully atomic 
regardless of what the block layer does, so long as the block layer 
respects our ordering and does not cache it where it should not.

zam, you are watching this thread about flushing the ide cache I hope....

> If
>the kernel cannot 100.00000000% guarantee the write is atomic, claiming
>otherwise is plain fraud and nothing else.
>
>Some people bet their whole business/company and hence a fair deal of
>their belongings on a single data base, and making them believe facts
>that simply aren't reality is dangerous. These people will have very
>little understanding for sloppiness here. Linux has no obligation to be
>fast or reliable, but it MUST PROPERLY AND TRUTHFULLY state what it can
>guarantee and what it cannot guarantee.
>
>  
>
>>For bigger atomic writes, 2.4 SUSE kernel had some nasty hack (called
>>blk-atomic) to prevent reordering by the io scheduler to avoid partial
>>blocks from databases.
>>    
>>
>
>That does not make a write atomic if the scheduled blocks are still
>written one at a time (and I believe tagged command queueing won't help
>to unroll partial writes either).
>
>If the hardware support is missing, it is prudent to say just that and
>not make any bogus promises about platter inertia and "it usually
>works". (who says that the filter curves adjust to the decreasing
>platter speed and the electronics are sustained for long enough? how
>about write verify and remapping broken blocks?)
>
>So we only write one hardware block size atomically, usually 512 bytes
>on ATA and SCSI disk drives (MO might do 2048 at a time, but why
>introduce complexity).  That's a data point in this whole fsync()
>discussion.
>
>  
>


-- 
Hans

