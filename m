Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbTFYT0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbTFYT0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:26:52 -0400
Received: from dm2-55.slc.aros.net ([66.219.220.55]:29371 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264965AbTFYT0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:26:51 -0400
Message-ID: <3EF9FACC.80503@aros.net>
Date: Wed, 25 Jun 2003 13:41:00 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
References: <Pine.LNX.4.10.10306251251410.11076-100000@clements.sc.steeleye.com> <3EF9F094.3030506@aros.net>
In-Reply-To: <3EF9F094.3030506@aros.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz wrote:

> . . . On the other hand I've been thinking that I might be able to 
> take advantage of the irq locked condition imposed by the 
> q->queue_lock and just use nbd_lock to replace q->queue_lock then. Al 
> and Andrew seem to have a much deeper understanding though for 
> spinlocking though so I'll defer to there comments on this idea (of 
> replacing lo->queue_lock by use of nbd_lock). This has the added 
> attraction of already having nbd_lock locked when in do_nbd_request.. . .

Typo! Above should have read "just use nbd_lock to replace 
lo->queue_lock" (another spinlock_t per nbd_device). Anyways... would 
using the one nbd_lock to also protect the lo->queue_list work better 
than using the queue_lock per nbd_device I'm wondering. According to the 
prior discusions about spinlocks this should be better. I don't have a 
picture right now of wether that even works or not. Gotta run though, 
thanks!


