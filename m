Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUCNUzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 15:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUCNUzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 15:55:24 -0500
Received: from ns.suse.de ([195.135.220.2]:62405 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261602AbUCNUzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 15:55:23 -0500
Subject: Re: [PATCH] per-backing dev unplugging #2
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
In-Reply-To: <20040314204701.GA2649@suse.de>
References: <20040311083619.GH6955@suse.de>
	 <1079121113.4181.189.camel@watt.suse.com>
	 <20040312120322.0108a437.akpm@osdl.org> <20040312200253.GA16880@suse.de>
	 <1079123647.4186.211.camel@watt.suse.com> <20040312203452.GD16880@suse.de>
	 <1079124097.4187.216.camel@watt.suse.com> <20040312205104.GE16880@suse.de>
	 <1079297032.4185.277.camel@watt.suse.com>  <20040314204701.GA2649@suse.de>
Content-Type: text/plain
Message-Id: <1079297870.4186.285.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Mar 2004 15:57:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-14 at 15:47, Jens Axboe wrote:

> Thanks for fixing this Chris, I wonder why your back trace from this
> oops was so screwy (->unplug_io_fn() for the swap space was zero-filled,
> no?)

unplug_io_fn was zero filled...RIP was 0, so I knew I was following a
bad function pointer, but the rest of the trace was just handle_mm_fault
and a few others leading to block_sync_page.  

Swap never showed in there, and I was a overly fixated on tracking down
someone calling lock_page without the inode pinned.  The good news is
that I'm now pretty sure we don't call lock_page without the inode
pinned ;-)

-chris


