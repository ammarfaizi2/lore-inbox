Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318046AbSG2GTt>; Mon, 29 Jul 2002 02:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318045AbSG2GTt>; Mon, 29 Jul 2002 02:19:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11785 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318043AbSG2GTn>; Mon, 29 Jul 2002 02:19:43 -0400
Date: Sun, 28 Jul 2002 23:23:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Marcin Dalecki <dalecki@evision.ag>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
In-Reply-To: <20020729075520.C4445@suse.de>
Message-ID: <Pine.LNX.4.44.0207282319590.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jul 2002, Jens Axboe wrote:
> >
> > I think you are missing the point. The stuff should not be in the
> > _generic_ blk_insert_request(). As I posted in my first reply to Martin,
> > SCSI needs to clear the tag before calling blk_insert_request() if it
> > needs to.
>
> Here's the patch to fix it, btw. Linus, please apply.

I can't apply this while I think it looks horribly broken.

Your patch makes scsi_lib call blk_queue_end_tag() without holding the
queue spinlock.

Which looks horribly broken, since it _will_ corrupt the queues.

In fact, it looks about a million times more broken than the code that
Martin submitted.

Please explain to me why I am wrong.

		Linus

PS. I actually do tend to look as the patches I apply. Right now it looks
like you're wrong, and Martin is right.

