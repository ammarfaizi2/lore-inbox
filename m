Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbUCJVAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUCJVAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:00:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:26284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262833AbUCJU6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:58:45 -0500
Date: Wed, 10 Mar 2004 13:00:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-Id: <20040310130046.2df24f0e.akpm@osdl.org>
In-Reply-To: <20040310124507.GU4949@suse.de>
References: <20040310124507.GU4949@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Here's a first cut at killing global plugging of block devices to reduce
> the nasty contention blk_plug_lock caused.

Shouldn't we take read_lock(&md->map_lock) in dm_table_unplug_all()?

If so, what are the lock ranking issues here?  The queue lock is not held
yet, so it seems pretty simple?
