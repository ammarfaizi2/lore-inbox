Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269540AbRHHSnH>; Wed, 8 Aug 2001 14:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269541AbRHHSm6>; Wed, 8 Aug 2001 14:42:58 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:42999 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S269540AbRHHSmn>; Wed, 8 Aug 2001 14:42:43 -0400
Date: Wed, 8 Aug 2001 19:42:01 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bvermeul@devel.blackstar.nl, Hans Reiser <reiser@namesys.com>,
        Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>, Steve Kieu <haiquy@yahoo.com>,
        Sam Thompson <samuelt@cervantes.dabney.caltech.edu>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010808194201.A4982@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0107271533330.10602-100000@devel.blackstar.nl> <E15Q7q5-0005e9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15Q7q5-0005e9-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 27, 2001 at 02:39:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 27, 2001 at 02:39:37PM +0100, Alan Cox wrote:

> > I've been doing that most of the time. But I sometimes forget that.
> > But as I said, it's not something I expected from a journalled filesystem.
> 
> You misunderstand journalling then
> 
> A journalling file system can offer different levels of guarantee. With 
> metadata only journalling you don't take any real performance hit but your
> file system is always consistent on reboot (consistent as in fsck would pass
> it) but it makes no guarantee that data blocks got written.

The default behaviour of ext3 does make this guarantee, for what it's
worth.  If you want the more relaxed mode which doesn't enforce the
flushing of data blocks before a commit, you need to mount with "-o
data=writeback".

> Full data journalling will give you what you expect but at a performance hit
> for many applications.

You can achieve the necessary ordering to avoid stale data blocks
after a crash without the penalty of writing all the data to the
journal.

Cheers,
 Stephen
