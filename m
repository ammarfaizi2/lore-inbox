Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbTFYRfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264813AbTFYRfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:35:43 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:19206 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264810AbTFYRfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:35:34 -0400
Date: Wed, 25 Jun 2003 13:48:16 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Lou Langholtz <ldl@aros.net>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
In-Reply-To: <3EF94672.3030201@aros.net>
Message-ID: <Pine.LNX.4.10.10306251251410.11076-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou,

a few comments on the patch...


On Wed, 25 Jun 2003, Lou Langholtz wrote:
> Please review and comment...
>
> This is the sixth patch to the NBD driver and it fixes a variety of 
> outstanding locking issues with the ioctl user interface. This patch 

This patch introduces a locking hierarchy between the lo->tx_lock and
lo->queue_lock. The existing driver does not have this limitation.
I would feel a lot better about this patch if you were to recode it
to avoid this.

Also, I noticed that you've removed the forcible shutdown of the
socket at the end of NBD_DO_IT. Was there a particular reason for
that?


> ... the new NBD_DO_IT style interface 
> could be introduced instead as another ioctl completely and these 3 
> ioctls could be maintained for backward compatibility for a while 
> longer. 

It would be really nice if the driver remained (as much as
possible) compatible with the 2.4 version...unless you have
a really good reason to break things... :)

--
Paul

