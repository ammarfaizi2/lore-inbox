Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUBPMZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 07:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUBPMZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 07:25:34 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:52434
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265193AbUBPMZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 07:25:32 -0500
Message-ID: <4030B259.1070805@tmr.com>
Date: Mon, 16 Feb 2004 07:06:49 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Valdis.Kletnieks@vt.edu, Chip Salzenberg <chip@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com> <40302783.6020505@pobox.com> <20040216033740.GE3789@perlsupport.com>            <40303D59.4030605@pobox.com> <200402160358.i1G3wC6W013389@turing-police.cc.vt.edu> <40304290.7090207@pobox.com>
In-Reply-To: <40304290.7090207@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Valdis.Kletnieks@vt.edu wrote:
> 
>> On Sun, 15 Feb 2004 22:47:37 EST, Jeff Garzik said:
>>
>>> One for the todo list, I suppose...  a useable workaround for this is 
>>> probably good ole 'e2fsck -c', i.e. badblocks...  That says "check 
>>> again to see if this sector is bad", and -hopefully- will unmark bad 
>>> blocks that were incorrectly marked bad.
>>
>>
>>
>> Does e2fsck/badblocks issue the right ioctls/etc to make the disk read 
>> the
>> *original* block, or will the disk simply check the *redirected* block?
> 
> 
> 
> I'm not sure your question has meaning.
> 
> Consider:  ext2 reads sector 1234.  drive returns "media error", and 
> then swaps the bad sector for a good one.  Reboot and run badblocks. 
> badblocks reads sector 1234, in whatever manner the drive chooses to 
> present sector 1234 to the OS.

That's the point, the original 1234 may not really be bad.
> 
> "original" versus "redirected" block is invisible to the OS.  The OS 
> only knows that an event occured at a single point in time -- the media 
> error.

It's invisible unlesss the o/s chooses to see. By default there would 
never be an attempt to recheck the original sector 1234 unless the o/s 
tells the drive to do so. It may be that a write to the sector will work 
and there is nothing wrong with the sector (transient errors could be 
caused by mechanical or electrical transients, more likely in a laptop).

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
