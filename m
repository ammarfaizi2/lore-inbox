Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267171AbSLKOgf>; Wed, 11 Dec 2002 09:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267170AbSLKOgf>; Wed, 11 Dec 2002 09:36:35 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:11526 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267165AbSLKOge>; Wed, 11 Dec 2002 09:36:34 -0500
Message-Id: <200212111435.gBBEYWa06788@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Kevin Corry <corryk@us.ibm.com>
Subject: Re: [PATCH] dm.c - device-mapper I/O path fixes
Date: Wed, 11 Dec 2002 17:24:10 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, lvm-devel@sistina.com
References: <02121016034706.02220@boiler> <02121107165303.29515@boiler> <20021211141820.GA21461@reti>
In-Reply-To: <20021211141820.GA21461@reti>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 December 2002 12:18, Joe Thornber wrote:
> On Wed, Dec 11, 2002 at 07:16:53AM -0600, Kevin Corry wrote:
> > However, it might be a good idea to consider how bio's keep track
> > of errors. When a bio is created, it is marked UPTODATE. Then, if
> > any part of a bio takes an error, the UPTODATE flag is turned off.
> > When the whole bio completes, if the UPTODATE flag is still on,
> > there were no errors during the i/o. Perhaps the "error" field in
> > "struct dm_io" could be modified to use this method of error
> > tracking? Then we could change dec_pending() to be something like:
> >
> > if (error)
> > 	clear_bit(DM_IO_UPTODATE, &io->error);
> >
> > with a "set_bit(DM_IO_UPTODATE, &ci.io->error);" in __bio_split().
>
> The problem with this is you don't keep track of the specific error
> to later pass to bio_endio(io->bio...).  I guess it all comes down to
> just how expensive that spin lock is; and since locking only occurs
> when there's an error I'm happy with things as they are.

lock();
a = b;
unlock();

Store of ints is atomic anyway. You need locking if a is a larger entity,
say, a struct.
--
vda
