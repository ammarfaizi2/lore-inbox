Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSDOIFm>; Mon, 15 Apr 2002 04:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313075AbSDOIFl>; Mon, 15 Apr 2002 04:05:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54535 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313070AbSDOIFk>;
	Mon, 15 Apr 2002 04:05:40 -0400
Date: Mon, 15 Apr 2002 10:05:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, mdharm@one-eyed-alien.net
Subject: Re: IDE / SmartMedia
Message-ID: <20020415080540.GD12608@suse.de>
In-Reply-To: <UTC200204150250.CAA625650.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Andries.Brouwer@cwi.nl wrote:
> > The TCQ stuff is definitely experimental, you should probably
> > configure it out for now.
> 
> % grep TCQ .config
> # CONFIG_BLK_DEV_IDE_TCQ is not set
> # CONFIG_BLK_DEV_IDE_TCQ_DEFAULT is not set
> 
> That was not it. I had not selected DMA. Doing so does not help,
> but reveals a new choice, namely support for HPT366.
> Selecting CONFIG_BLK_DEV_HPT366 makes the crash go away.

--- drivers/ide/ide.c~	2002-04-15 10:05:03.000000000 +0200
+++ drivers/ide/ide.c	2002-04-15 10:05:12.000000000 +0200
@@ -2764,7 +2764,6 @@
 	if (i) {
 		drive->queue_depth = i;
 		if (i >= 1) {
-			drive->using_tcq = 1;
 			drive->tcq->queued = 0;
 			drive->tcq->active_tag = -1;
 			return 0;

-- 
Jens Axboe

