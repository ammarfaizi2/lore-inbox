Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbSJJOdy>; Thu, 10 Oct 2002 10:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSJJOdr>; Thu, 10 Oct 2002 10:33:47 -0400
Received: from smtp07.iddeo.es ([62.81.186.17]:46273 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S261598AbSJJOdq>;
	Thu, 10 Oct 2002 10:33:46 -0400
Date: Thu, 10 Oct 2002 16:39:27 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Robert Love <rml@tech9.net>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on O_STREAMING (goodby read pauses)
Message-ID: <20021010143927.GA2193@werewolf.able.es>
References: <20021009222349.GA2353@werewolf.able.es> <1034203433.794.152.camel@phantasy> <20021010034057.GC8805@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021010034057.GC8805@mark.mielke.cc>; from mark@mark.mielke.cc on Thu, Oct 10, 2002 at 05:40:57 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.10 Mark Mielke wrote:
>On Wed, Oct 09, 2002 at 06:43:52PM -0400, Robert Love wrote:
>> On Wed, 2002-10-09 at 18:23, J.A. Magallon wrote:
>> > But I did the test with an addition: read a 1Gb file and print an '*'
>> > after every 10M. Without O_STREAMING, when memory fills, the 'progress
>> > bar' stalls for a few seconds while pages are sent to disk.
>> > So the patch also favours a constant sustained rate of read from the
>> > disk. Very interesting for things like video edition and so on.
>> > I like it ;).
>> This is 100% the point of the patch and hopefully the point I proved
>> when I first posted it.
>
>I assume the stall is not 'while pages are sent to disk', but rather
>until kswapd gets around to freeing enough pages to allow memory to
>fill again. The stall is due to the pages being fully analyzed to
>determine which ones should go, and which ones shouldn't. O_STREAMING
>removes the pages ahead of time, so no analysis is ever required.
>

I can _hear_ the disk activity when the stall happens, so selecting what
to drop is fast, but then you have to write it...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
