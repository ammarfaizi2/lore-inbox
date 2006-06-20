Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWFTNdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWFTNdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWFTNdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:33:14 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:30423 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750830AbWFTNdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:33:13 -0400
Date: Tue, 20 Jun 2006 15:30:12 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: elevator.h problem
Message-ID: <20060620153012.2b50351d@localhost>
In-Reply-To: <Pine.LNX.4.61.0606201126001.2481@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0606201126001.2481@yvahk01.tjqt.qr>
X-Mailer: Sylpheed-Claws 2.3.0-rc3 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 11:28:35 +0200 (MEST)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> I am trying to compile a module that requires elv_requeue_request.
> I include <linux/elevator.h>, but that fails. Now that elevator.h includes 
> blkdev.h (to get at the reqeust_queue_t typedef -- see next post), 
> blkdev.h wants elv_dequeue_request, but which is defined in elevator.h. 
> This circular dependency is really a problem, does anyone have 
> an adequate fix? 2.6.17.

"linux/elevator.h" doesn't include anything
"linux/blkdev.h" defines some typedefs needed by elevator.h and then
		includes it

So if you need "linux/elevator.h" you can just do:

#include <linux/blkdev.h>

or

#include <linux/blkdev.h>
#include <linux/elevator.h>


What's the problem?

-- 
	Paolo Ornati
	Linux 2.6.17 on x86_64
