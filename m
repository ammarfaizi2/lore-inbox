Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTFYRn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTFYRn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:43:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19365 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264891AbTFYRmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:42:39 -0400
Date: Wed, 25 Jun 2003 18:56:49 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Paul.Clements@steeleye.com
Cc: Lou Langholtz <ldl@aros.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl UI
Message-ID: <20030625175649.GA27348@parcelfarce.linux.theplanet.co.uk>
References: <3EF94672.3030201@aros.net> <Pine.LNX.4.10.10306251251410.11076-100000@clements.sc.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10306251251410.11076-100000@clements.sc.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 01:48:16PM -0400, Paul Clements wrote:

> This patch introduces a locking hierarchy between the lo->tx_lock and
> lo->queue_lock. The existing driver does not have this limitation.
> I would feel a lot better about this patch if you were to recode it
> to avoid this.

?????

One of them is a semaphore, another - a spinlock.  Of course there always
had been a hierarchy - you can't call down() under a spinlock, the damn
thing can schedule.
