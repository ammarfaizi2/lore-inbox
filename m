Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUAGULM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 15:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265575AbUAGULM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 15:11:12 -0500
Received: from waste.org ([209.173.204.2]:35755 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265572AbUAGULK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 15:11:10 -0500
Date: Wed, 7 Jan 2004 14:10:56 -0600
From: Matt Mackall <mpm@selenic.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040107201056.GE18208@waste.org>
References: <20040106054859.GA18208@waste.org> <20040107140640.GC16720@suse.de> <20040107185039.GC18208@waste.org> <20040107192732.GA13240@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107192732.GA13240@gaz.sfgoth.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:27:33AM -0800, Mitchell Blank Jr wrote:
> Matt Mackall wrote:
> > When I merge
> > CONFIG_BLOCK, it'll be more generally useful.
> 
> Maybe it would make more sense to have CONFIG_MEMPOOL=n just remove
> the mempool API entirely and have it imply CONFIG_BLOCK=n, CONFIG_NFS_FS=n,
> and CONFIG_NFSD=n?  Just a thought.

NFS is a good example of why the guarantees of mempool are being
overstated - it still needs to allocate SKBs to make progress and
preallocating a pool for other data structures can make that fail
where it otherwise might not. The pool size for NFS (32) is also
completely arbitrary as far as I can tell.

> It seems like a reasonalbe thing to omit for some tiny configs that don't
> need it, but if the API is provided it should probably work as expected.

The API _does_ work. It was a best effort with buffering before, it's
a best effort without buffering now.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
