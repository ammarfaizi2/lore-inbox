Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVHYSQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVHYSQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVHYSQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:16:15 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:51356 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751402AbVHYSQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:16:14 -0400
Message-ID: <430E0A84.8080809@dresco.co.uk>
Date: Thu, 25 Aug 2005 19:14:28 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jens Axboe <axboe@suse.de>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
References: <1124205914.4855.14.camel@localhost.localdomain>	 <20050816200708.GE3425@suse.de>  <430CEA54.7060803@dresco.co.uk> <1124967468.21456.6.camel@localhost.localdomain>
In-Reply-To: <1124967468.21456.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Heisenberg-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> @@ -1661,6 +1671,9 @@
>                 where = ELEVATOR_INSERT_FRONT;
>                 rq->flags |= REQ_PREEMPT;
>         }
> +       if (action == ide_next)
> +               where = ELEVATOR_INSERT_FRONT;
> +
>         __elv_add_request(drive->queue, rq, where, 0);
>         ide_do_request(hwgroup, IDE_NO_IRQ);
>         spin_unlock_irqrestore(&ide_lock, flags);
> 
> Also puzzles me- why is this needed ?

I wanted the park command to get in at the head of the queue (behind the 
currently executing request).

Contrary to the comments for ide_do_drive_cmd(), ide_next didn't appear 
to do anything to achieve this? At least from my initial testing before 
I made this change - it could take a second or so for the park command 
to be issued if the disk was busy....

Regards,
Jon.

______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
