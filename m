Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTDYLVS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTDYLVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:21:18 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:35580 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263518AbTDYLVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:21:15 -0400
Subject: Re: [RFC/PATCH] IDE Power Management try 1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Atanasov <alex@ssi.bg>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <3EA90176.2080304@ssi.bg>
References: <1051189194.13267.23.camel@gaston>  <3EA90176.2080304@ssi.bg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051270378.15078.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 13:32:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 		What about this - add __REQ_DRIVE_INTERNAL, and carry args in 
> rq->cmd[16] [0] = PM, [1] = SUSPEND/RESUME, [2]= STATE ? IDE can use it 
> for power managment, error handling (do not do it from interrupt 
> context, but queue it), may be more. This way it would really makes 
> things a bit better with the complicated IDE locking. SCSI and probably 
> other block devices can benefit from this internal requests too, so the 
> bit is not wasted.

I agree. IDE locking isn't _that_ complicated ;) Though currently, we do
handle requests right on interrupt completion so error handling wouldn't
be deferred by this trick.

Jens, what do you think ? You are the blkdev.h guy :)

Ben.

