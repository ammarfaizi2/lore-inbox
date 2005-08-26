Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVHZGtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVHZGtn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVHZGtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:49:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61102 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932529AbVHZGtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:49:42 -0400
Date: Fri, 26 Aug 2005 08:49:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Jon Escombe <lists@dresco.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
Message-ID: <20050826064934.GP4018@suse.de>
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <430CEA54.7060803@dresco.co.uk> <1124967468.21456.6.camel@localhost.localdomain> <430E0A84.8080809@dresco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430E0A84.8080809@dresco.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25 2005, Jon Escombe wrote:
> Alan Cox wrote:
> >@@ -1661,6 +1671,9 @@
> >                where = ELEVATOR_INSERT_FRONT;
> >                rq->flags |= REQ_PREEMPT;
> >        }
> >+       if (action == ide_next)
> >+               where = ELEVATOR_INSERT_FRONT;
> >+
> >        __elv_add_request(drive->queue, rq, where, 0);
> >        ide_do_request(hwgroup, IDE_NO_IRQ);
> >        spin_unlock_irqrestore(&ide_lock, flags);
> >
> >Also puzzles me- why is this needed ?
> 
> I wanted the park command to get in at the head of the queue (behind the 
> currently executing request).
> 
> Contrary to the comments for ide_do_drive_cmd(), ide_next didn't appear 
> to do anything to achieve this? At least from my initial testing before 
> I made this change - it could take a second or so for the park command 
> to be issued if the disk was busy....

That part seems to have been lost, apparently. The above patch is
correct.

-- 
Jens Axboe

