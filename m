Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSFBHfU>; Sun, 2 Jun 2002 03:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317143AbSFBHfT>; Sun, 2 Jun 2002 03:35:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43022 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317142AbSFBHfS>;
	Sun, 2 Jun 2002 03:35:18 -0400
Message-ID: <3CF9CB92.A6BF921B@zip.com.au>
Date: Sun, 02 Jun 2002 00:38:58 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [patch 1/16] unplugging fix
In-Reply-To: <3CF88852.BCFBF774@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> There's a plugging bug in 2.5.19.  Once you start pushing several disks
> hard, the new unplug code gets confused and queues are left in plugged
> state, but not on the plug list.  They never get unplugged and the
> machine dies mysteriously.
> 

This patch didn't fix it.  It made it tons better, but I again have a
wedged box.  Same symptoms - against IDE this time.

blk_plug_list is empty.  queue_flags=0x03.  Interestingly,
q->plug_list is non-empty, non-zero, both list members pointing at
a list which isn't either itself or blk_plug_list.

I note that the code isn't taking queues off the plug list when the queue
is destroyed.  Guess that doesn't matter - we never destroy a plugged
queue...

This one is killing me.

-
