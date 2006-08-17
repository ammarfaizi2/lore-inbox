Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWHQMhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWHQMhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWHQMhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:37:10 -0400
Received: from pat.uio.no ([129.240.10.4]:25315 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932351AbWHQMhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:37:08 -0400
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
	writeback.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, David Chinner <dgc@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060816231448.cc71fde7.akpm@osdl.org>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	 <20060815010611.7dc08fb1.akpm@osdl.org>
	 <20060815230050.GB51703024@melbourne.sgi.com>
	 <17635.60378.733953.956807@cse.unsw.edu.au>
	 <20060816231448.cc71fde7.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 08:36:19 -0400
Message-Id: <1155818179.5662.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.802, required 12,
	autolearn=disabled, AWL 0.69, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 23:14 -0700, Andrew Morton wrote:
> btw, one thing which afaik NFS _still_ doesn't do is to wake up processes
> which are stuck in blk_congestion_wait() when NFS has retired a bunch of
> writes.  It should do so, otherwise NFS write-intensive workloads might end
> up sleeping for too long.  I guess the amount of buffering and hysteresis
> we have in there has thus far prevented any problems from being observed.

Are we to understand it that you consider blk_congestion_wait() to be an
official API, and not just another block layer hack inside the VM?

'cos currently the only tools for waking up processes in
blk_congestion_wait() are the two routines:

   static void clear_queue_congested(request_queue_t *q, int rw)
and
   static void set_queue_congested(request_queue_t *q, int rw)

in block/ll_rw_blk.c. Hardly a model of well thought out code...

  Trond

