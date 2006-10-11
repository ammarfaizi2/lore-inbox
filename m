Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWJKLXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWJKLXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWJKLXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:23:10 -0400
Received: from brick.kernel.dk ([62.242.22.158]:10564 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030235AbWJKLXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:23:08 -0400
Date: Wed, 11 Oct 2006 13:23:14 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Vasily Tarasov <vtaras@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       OpenVZ Developer List <devel@openvz.org>
Subject: Re: [PATCH] block layer: elv_iosched_show should get elv_list_lock
Message-ID: <20061011112314.GP6515@kernel.dk>
References: <200610111119.k9BBJhls004763@vass.7ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610111119.k9BBJhls004763@vass.7ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11 2006, Vasily Tarasov wrote:
> elv_iosched_show function iterates other elv_list,
> hence elv_list_lock should be got.

Indeed, that's a bug. Thanks!

> Also the question is: in elv_iosched_show, elv_iosched_store
> q->elevator->elevator_type construction is used without locking
> q->queue_lock.  Is it expected?..

As long as the queue doesn't go away, we should be safe enough.

-- 
Jens Axboe

