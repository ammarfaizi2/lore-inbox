Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRCAPpL>; Thu, 1 Mar 2001 10:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRCAPpC>; Thu, 1 Mar 2001 10:45:02 -0500
Received: from [199.183.24.200] ([199.183.24.200]:50521 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129632AbRCAPoq>; Thu, 1 Mar 2001 10:44:46 -0500
Date: Thu, 1 Mar 2001 10:44:38 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Martin Rauh <martin.rauh@gmx.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Writing on raw device with software RAID 0 is slow
In-Reply-To: <20010301121418.A7647@redhat.com>
Message-ID: <Pine.LNX.4.30.0103011035520.13184-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Thu, 1 Mar 2001, Stephen C. Tweedie wrote:

> Raw IO is always synchronous: it gets flushed to disk before the write
> returns.  You don't get any write-behind with raw IO, so the smaller
> the blocksize you write in, the slower things get.

More importantly, the mainstream raw io code only writes in 64KB chunks
that are unpipelined, which can lead to writes not hitting the drive
before the sector passes under the rw head.  You can work around this to
some extent by issuing multiple writes (via threads, or the aio work I've
done) at the expense of atomicity.  Also, before we allow locking of
arbitrary larger ios in main memory, we need bean counting to prevent the
obvious DoSes.

		-ben

