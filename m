Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUCLPsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUCLPsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:48:45 -0500
Received: from ns.suse.de ([195.135.220.2]:8161 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262220AbUCLPsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:48:35 -0500
Subject: Re: [PATCH] lockfs patch for 2.6
From: Chris Mason <mason@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040312093146.A13678@infradead.org>
References: <1078867885.25075.1458.camel@watt.suse.com>
	 <20040312093146.A13678@infradead.org>
Content-Type: text/plain
Message-Id: <1079106653.4185.171.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 10:50:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 04:31, Christoph Hellwig wrote:

> Can we please rename write_super_lockfs to a sane name?
> 
> freeze_fs/thaw_fs sounds like a good name.
> 
Sure.

> This looks ugly.  What about returning the superblock from the freeze
> routine so you can simply pass it into the thaw routine?
> 
I like it, will do.

> 
> This looks grossly misnamed again.  And why do you need to have
> sync_super_locks splitted out?  Calling it on it's own doesn't make much
> sense.
> 

Would you like this better:

device mapper code:
	fsync_bdev(bdev);
	s = freeze_fs(bdev);
	< create snap shot >
	thaw_fs(bdev, s);

thaw_fs needs the bdev so it can up the bdev mount semaphore.

-chris


