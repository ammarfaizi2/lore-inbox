Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317577AbSGZKb4>; Fri, 26 Jul 2002 06:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSGZKb4>; Fri, 26 Jul 2002 06:31:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36104 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317577AbSGZKbz>; Fri, 26 Jul 2002 06:31:55 -0400
Message-ID: <3D4124B0.2060901@evision.ag>
Date: Fri, 26 Jul 2002 12:30:08 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: lkml <linux-kernel@vger.kernel.org>, axboe@suse.de, torvalds@transmeta.com
Subject: Re: IDE lockups with 2.5.28...
References: <322E1A1760@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> Well, no. Both of these loop have completely different terminating conditions.
> You exit when IDE hardware is busy, while SCSI exits if hardware is busy,
> or when there is nothing to do. Fundamental difference.

Shit - you are right. We look until the next request sets IDE_BUSY as a 
side effect.... I just wanted to close the window between clear we clear
IDE_BUSY in ata_irq_handler just before recalling do_request to set it 
immediately on again.
Should be both of course.

>>Same allies to blk_stop_queue().
> 
> 
> So your request_fn is invoked for each of queues which had pending
> requests. Upper layer cannot expect that you are using two queues,
> but hardware really wants to use only one. Shared queue_lock is there
> for hardware which can start one request at a time (one set of
> registers...), but can have requests to the different devices
> in progress.

Yes theoretically yes. The problem is only that queue_lock doesn't as
advertized becouse the request_fn are *releasing* the spin lock at a 
point where the QUEUE_FLAG_STOP doesn't have any usefull value.


> P.S.: I did not saw IDE 105. Does it exist?

I think I did send it under a wrong topic. Please look for Re:
Linux-2.5.28.


