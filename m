Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271418AbTHDJAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTHDJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:00:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17041 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271418AbTHDJAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:00:47 -0400
Date: Mon, 4 Aug 2003 11:00:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Harald Dunkel <harri@synopsys.COM>
Cc: Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: crash in reiserfs at shutdown
Message-ID: <20030804090040.GC854@suse.de>
References: <3F2B9823.7010503@Synopsys.COM> <200308030649.h736nbcj013727@car.linuxhacker.ru> <3F2CBD0C.4040603@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2CBD0C.4040603@Synopsys.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03 2003, Harald Dunkel wrote:
> Oleg Drokin wrote:
> >Hello!
> >
> >Harald Dunkel <harri@synopsys.com> wrote:
> >
> >HD> Final words are
> >HD>         kernel BUG at fs/reiserfs/prints.c: 339
> >
> >There should be one line prior to that.
> >This line explains what went wrong in reiserfs opinion.
> >Can you please say us what was the line?
> >
> It said
> 
> 	unmounting local filesystems... bio too big device sdc1 (8 > 0)
> 	bio too big device sdc1 (8 > 0)
> 	journal - 601, buffer write failed

reiser most likely tried to flush its journal after the device had
disappeared, the queue has been memset it seems. not a reiser problem
per se.

> To me the problem seems that the USB stuff is shutdown
> without unmounting the external USB disk first. Later, at
> the "unmounting all disks" step in the shutdown procedure
> the USB storage device can't be accessed anymore.

Seems about right.

-- 
Jens Axboe

