Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261828AbSJQGjZ>; Thu, 17 Oct 2002 02:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSJQGjZ>; Thu, 17 Oct 2002 02:39:25 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:4266 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S261828AbSJQGjY>; Thu, 17 Oct 2002 02:39:24 -0400
Date: Wed, 16 Oct 2002 23:45:10 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021017064510.GX22117@nic1-pc.us.oracle.com>
References: <20021014135100.GD28283@suse.de> <20021017005109.GV22117@nic1-pc.us.oracle.com> <20021017055942.GC9245@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017055942.GC9245@suse.de>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 07:59:42AM +0200, Jens Axboe wrote:
> Eh no, it actually doesn't bounce anything! I added a test to bypass
> bouncing temporarily in blk_queue_bounce() (see the BH_Super test in
> there), but forgot to replace it with the real thing. The superbh
> contains no data, so is not a candidate for bouncing.

	I understand that the superbh isn't a candidate for bouncing.
The problem is that the rest of the bhs are, and they never get bounced.
scsi_merge.c checks "if (PageHighMem(bh->b_page)) BUG();" in
__init_io(), and that obviously crashes.

Joel

-- 

"Conservative, n.  A statesman who is enamoured of existing evils,
 as distinguished from the Liberal, who wishes to replace them
 with others."
	- Ambrose Bierce, The Devil's Dictionary

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
