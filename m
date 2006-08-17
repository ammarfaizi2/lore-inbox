Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWHQQXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWHQQXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWHQQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:23:20 -0400
Received: from pat.uio.no ([129.240.10.4]:14253 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965061AbWHQQXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:23:19 -0400
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
	writeback.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, David Chinner <dgc@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060817081415.f48fbb37.akpm@osdl.org>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	 <20060815010611.7dc08fb1.akpm@osdl.org>
	 <20060815230050.GB51703024@melbourne.sgi.com>
	 <17635.60378.733953.956807@cse.unsw.edu.au>
	 <20060816231448.cc71fde7.akpm@osdl.org>
	 <1155818179.5662.19.camel@localhost>
	 <20060817081415.f48fbb37.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:22:59 -0400
Message-Id: <1155831779.5620.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.986, required 12,
	autolearn=disabled, AWL 0.50, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 08:14 -0700, Andrew Morton wrote:
> Take a look at blk_congestion_wait().  It doesn't know about request
> queues.  We'd need a new
> 
> void writeback_congestion_end(int rw)
> {
> 	wake_up(congestion_wqh[rw]);
> }
> 
> or similar.

...and how often do you want us to call this? NFS doesn't know much
about request queues either: it writes out pages on a per-RPC call
basis. In the worst case that could mean waking up the VM every time we
write out a single page.

Cheers,
  Trond

