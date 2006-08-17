Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWHQQTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWHQQTH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWHQQTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:19:06 -0400
Received: from pat.uio.no ([129.240.10.4]:37796 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932558AbWHQQTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:19:04 -0400
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
	writeback.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060817083035.8b775b12.akpm@osdl.org>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	 <20060815010611.7dc08fb1.akpm@osdl.org>
	 <17635.59821.21444.287979@cse.unsw.edu.au>
	 <1155820912.5662.39.camel@localhost>
	 <20060817083035.8b775b12.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:18:52 -0400
Message-Id: <1155831532.5620.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.783, required 12,
	autolearn=disabled, AWL 0.71, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 08:30 -0700, Andrew Morton wrote:
> On Thu, 17 Aug 2006 09:21:51 -0400
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > Exactly how would a request limit help? All that boils down to is having
> > the VM monitor global_page_state(NR_FILE_DIRTY) versus monitoring
> > global_page_state(NR_FILE_DIRTY)+global_page_state(NR_WRITEBACK).
> > 
> 
> I assume that if NFS is not limiting its NR_WRITEBACK consumption and block
> devices are doing so, we could get in a situation where NFS hogs all of the
> fixed-size NR_DIRTY+NR_WRITEBACK resource at the expense of concurrent
> block-device-based writeback.

Since NFS has no control over NR_DIRTY, how does controlling
NR_WRITEBACK help? The only resource that NFS shares with the block
device writeout queues is memory.

IOW: The resource that needs to be controlled is the dirty pages, not
the write-out queue. Unless you can throttle back on the creation of
dirty NFS pages in the first place, then the potential for unfairness
will exist.

Trond

