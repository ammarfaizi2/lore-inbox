Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268864AbRHKVoY>; Sat, 11 Aug 2001 17:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268862AbRHKVoP>; Sat, 11 Aug 2001 17:44:15 -0400
Received: from mail.zmailer.org ([194.252.70.162]:60175 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S268860AbRHKVoD>;
	Sat, 11 Aug 2001 17:44:03 -0400
Date: Sun, 12 Aug 2001 00:44:05 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Cc: Ben LaHaise <bcrl@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mike@bigstorage.com,
        kevin@bigstorage.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010812004405.W11046@mea-ext.zmailer.org>
In-Reply-To: <20010703065312.J4841@vestdata.no> <Pine.LNX.4.33.0107032211120.30968-100000@toomuch.toronto.redhat.com> <20010726041821.C19238@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010726041821.C19238@vestdata.no>; from kernel@ragnark.vestdata.no on Thu, Jul 26, 2001 at 04:18:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2001 at 04:18:21AM +0200, Ragnar Kjørstad wrote:
> On Tue, Jul 03, 2001 at 10:19:36PM -0400, Ben LaHaise wrote:
> > Here's the [completely untested] generic scsi fixup, but I'm told that
> > some controllers will break with it.  Give it a whirl and let me know how
> > many pieces you're left holding. =)  Please note that msdos partitions do
> > *not* work on devices larger than 2TB, so you'll have to use the scsi disk
> > directly.  This patch applies on top of v2.4.6-pre8-largeblock4.diff.
> 
> I just trid this, but when I can't load the md modules becuase of
> missing symbols for __divdi3 and __umoddi3. 

   This should, most likely, be linux-kernel FAQ item -- it might even be
   there..

   You need to develop an additional patch to the MD module code so
   that it won't do careless arbitrary divisions of  long64 / int32  kind.
   It will be more efficient to do that with suitable shifts, after all.

/Matti Aarnio

> /lib/modules/2.4.6-pre8/kernel/drivers/md/linear.o
> depmod: 	__udivdi3
> depmod: 	__umoddi3
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre8/kernel/drivers/md/lvm-mod.o
> depmod: 	__udivdi3
> depmod: 	__umoddi3
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre8/kernel/drivers/md/md.o
> depmod: 	__udivdi3
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre8/kernel/drivers/md/raid0.o
> depmod: 	__udivdi3
> depmod: 	__umoddi3
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre8/kernel/drivers/md/raid5.o
> depmod: 	__udivdi3
> depmod: 	__umoddi3
> 
> 
> Did you forget something in your patch, or was it not supposed to work
> on ia32?
> 
> This is kind of urgent, because I will temporarely be without testing
> equipment pretty soon. Tips are appreciated!
> 
> 
> 
> -- 
> Ragnar Kjorstad
> Big Storage
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
