Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSKRO6t>; Mon, 18 Nov 2002 09:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSKRO6t>; Mon, 18 Nov 2002 09:58:49 -0500
Received: from host194.steeleye.com ([66.206.164.34]:37382 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262472AbSKRO6n>; Mon, 18 Nov 2002 09:58:43 -0500
Message-Id: <200211181505.gAIF5am02001@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: scsi in 2.5.48 
In-Reply-To: Message from Jens Axboe <axboe@suse.de> 
   of "Mon, 18 Nov 2002 14:56:14 +0100." <20021118135614.GA834@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Nov 2002 09:05:34 -0600
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@digeo.com said:
> > Andrew Morton wrote:
> 
> > Appears to be DOA.  Just a simple mke2fs hangs in get_request_wait().
> This makes it work again. 

That can't be entirely right, because we can't exit the request function with 
pending requests and something like an unplugged queue to start them.  It will 
work for the adaptec because the prep defer is caused by the huge queue depth 
running us out of command blocks, so the queues would get re-run by a 
returning command.  If the failure were caused by zero outstanding commands, 
this would hang the system forever.

axboe@suse.de said:
> Right fix would be something ala: 

That looks about right.  On returning I/O we need to unplug and restart.

However, with regard to Andrew's problem, how can the queue plug indefinitely? 
 I thought it was guaranteed to be unplugged and run eventually?

James


