Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265645AbUAGVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUAGVl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:41:56 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:57477 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265645AbUAGVlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:41:55 -0500
Subject: Re: 2.6.1-rc1-tiny2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Matt Mackall <mpm@selenic.com>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040107201056.GE18208@waste.org>
References: <20040106054859.GA18208@waste.org>
	 <20040107140640.GC16720@suse.de> <20040107185039.GC18208@waste.org>
	 <20040107192732.GA13240@gaz.sfgoth.com>  <20040107201056.GE18208@waste.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073511697.1242.105.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 16:41:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 07/01/2004 klokka 15:10, skreiv Matt Mackall:
> NFS is a good example of why the guarantees of mempool are being
> overstated - it still needs to allocate SKBs to make progress and
> preallocating a pool for other data structures can make that fail
> where it otherwise might not. The pool size for NFS (32) is also
> completely arbitrary as far as I can tell.

If you are in a hardware situation where you actually care about the
permanent size of that mempool, then you're barking up entirely the
wrong tree: there is a hell of a lot more memory to reclaim from not
having to build up all those nfs_page lists in the first place.

i.e. Rip out the entire asynchronous NFS read/write support, not just
the mempools.

As for the usefulness of the mempools in the situation where you have
asynchronous I/O: I agree that the socket layer screws any chance of a
guarantee. So does the server if it goes down, the network itself can
screw you,.... All in all, it is surprising how few guarantees NFS
offers you.
I therefore see the mempools as more of an optimization that mainly
avoid sleeping under a certain limited set of "reasonable"
circumstances.

Cheers,
  Trond
