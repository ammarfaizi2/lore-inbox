Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTFBK3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 06:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTFBK3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 06:29:53 -0400
Received: from ns.suse.de ([213.95.15.193]:27149 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262145AbTFBK3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 06:29:52 -0400
Date: Mon, 2 Jun 2003 12:43:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Thomas Tonino <ttonino@users.sf.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030602104314.GA23107@suse.de>
References: <20030527035006$5339@gated-at.bofh.it> <20030527175008$3573@gated-at.bofh.it> <20030527180016$418c@gated-at.bofh.it> <20030527182011$4acb@gated-at.bofh.it> <20030528094008$1500@gated-at.bofh.it> <20030528095014$7b21@gated-at.bofh.it> <3ED50612.40507@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED50612.40507@users.sf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Thomas Tonino wrote:
> Jens Axboe wrote:
> 
> >Lemme guess, hard drive on the same channel as the burner? There's
> >nothing we can do about that, hardware limitation.
> 
> hmmm... most drives these days have a command to read free buffer capacity, 
> so there is no need to send more than the drive can swallow - and no need 
> to tie up the channel.

As we cannot do more than 128kb in a single request (cdrecord uses 63kb
for writing), there's no problem there. I think you are misunderstanding
me. This is not a problem with ide layer starving the hard drive by
continually sending writes to the cd-r, it's a problem with not being
able to preempt service for a single command duration.

> >The reason you see it
> >during fixation is because that's one long single command, and we cannot
> >preempt the channel and service requests while that is going on.
> 
> But this may be the exception that breaks the rule. Bah.

No, that is the entire problem.

-- 
Jens Axboe

