Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129677AbRCAQEf>; Thu, 1 Mar 2001 11:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRCAQEa>; Thu, 1 Mar 2001 11:04:30 -0500
Received: from zeus.kernel.org ([209.10.41.242]:41417 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129677AbRCAQEJ>;
	Thu, 1 Mar 2001 11:04:09 -0500
Date: Thu, 1 Mar 2001 16:02:01 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Martin Rauh <martin.rauh@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Writing on raw device with software RAID 0 is slow
Message-ID: <20010301160201.P26280@redhat.com>
In-Reply-To: <20010301121418.A7647@redhat.com> <Pine.LNX.4.30.0103011035520.13184-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0103011035520.13184-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Thu, Mar 01, 2001 at 10:44:38AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 01, 2001 at 10:44:38AM -0500, Ben LaHaise wrote:
> 
> On Thu, 1 Mar 2001, Stephen C. Tweedie wrote:
> 
> > Raw IO is always synchronous: it gets flushed to disk before the write
> > returns.  You don't get any write-behind with raw IO, so the smaller
> > the blocksize you write in, the slower things get.
> 
> More importantly, the mainstream raw io code only writes in 64KB chunks
> that are unpipelined, which can lead to writes not hitting the drive
> before the sector passes under the rw head.  You can work around this to
> some extent by issuing multiple writes (via threads, or the aio work I've
> done) at the expense of atomicity.  Also, before we allow locking of
> arbitrary larger ios in main memory, we need bean counting to prevent the
> obvious DoSes.

Yep.  There shouldn't be any problem increasing the 64KB size, it's
only the lack of accounting for the pinned memory which stopped me
increasing it by default.

--Stephen
