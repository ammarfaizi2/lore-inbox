Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbTC0LLW>; Thu, 27 Mar 2003 06:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261930AbTC0LLW>; Thu, 27 Mar 2003 06:11:22 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:3021 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S261897AbTC0LLU>; Thu, 27 Mar 2003 06:11:20 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: Delaying writes to disk when there's no need
Date: Thu, 27 Mar 2003 11:22:33 +0000 (UTC)
Message-ID: <slrnb85nno.1q6.usenet@bender.home.hensema.net>
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net> <3E82BF2D.8080508@aitel.hist.no>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting (helgehaf@aitel.hist.no) wrote:
> Erik Hensema wrote:
>> In all kernels I've tested writes to disk are delayed a long time even when
>> there's no need to do so.
>> 
> Short answer - it is supposed to do that!
> 
>> A very simple test shows this: on an otherwise idle system, create a tar of
>> a NFS-mounted filesystem to a local disk. The kernel starts writing out the
>> data after 30 seconds, while a slow and steady stream would be much nicer
>> to the system, I think.
>>
> You're wrong then.  There's no need for a slow steady stream, why do
> you want that.  Of course you can set up cron to run sync at
> regular (short) intervals to achieve this.
> 
>> On 2.4.x this can block the system for several seconds. 2.5.6x and
>> 2.5.6x-mm (with AS) also show this behaviour, but the system doesn't block
>> anymore. I'm using a preemtable kernel.
>> 
> Writing out stuff is not supposed to block the machine, and as you say,
> it is fixed in 2.5.  No need for the steady writing.
> 
>> I only started to notice this behaviour when I upgraded from 256 MB ram to
>> 512 MB. In other words: Linux behaves more nicely with 256 MB.
>> 
> Why do you think that is more nice?

Because the interactivity of the system is better with less memory.

> Writing is delayed because that accumulate bigger writes and
> fewer seeks.  This helps performance a lot.  Delaying writes
> has another advantage - somw writes won't be done at all,
> saving 100% writing time.  This is the case for temporary
> files that gets written to, read, and deleted before they
> get written to disk. It all happens in cache, improving
> performance tremendously.  To see the alternative,
> try booting with mem=4M or 16M or some such, with _no_ swapping.

I see that. However, I don't see why the kernel is writing out data
as agressively as it does now. Delaying a write for 30 seconds isn't the
problem: the aggressive writes are. Since the disks are otherwise idle, the
kernel can gently start writing out the dirty cache. No need to try and
write 40 MB in 1 sec when you can write 10 MB/sec in 4 seconds.

[...]

> For more detailed information, read a book about how filesystems and
> disk caching works.

I'm just reporting what's happening to me in practice, I don't really care
about what should happen in theory.

-- 
Erik Hensema <erik@hensema.net>
