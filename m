Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUCLUAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbUCLTwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:52:40 -0500
Received: from ns.suse.de ([195.135.220.2]:20366 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262465AbUCLTtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:49:35 -0500
Subject: Re: [PATCH] per-backing dev unplugging #2
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       kenneth.w.chen@intel.com
In-Reply-To: <20040311083619.GH6955@suse.de>
References: <20040311083619.GH6955@suse.de>
Content-Type: text/plain
Message-Id: <1079121113.4181.189.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 14:51:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 03:36, Jens Axboe wrote:
> Hi,
> 
> Final version, unless something stupid pops up. Changes:

During a mixed load test including fsx-linux and a bunch of procs
running cp/read/rm loops, I got a null pointer deref with the call
trace:

__lock_page->sync_page->block_sync_page

I don't see how we can trust page->mapping in this path, can't it
disappear?  If so, it would be a bug without Jens' patch too, just
harder to hit.

-chris


