Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318881AbSH1QPH>; Wed, 28 Aug 2002 12:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318880AbSH1QPG>; Wed, 28 Aug 2002 12:15:06 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:6413 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318881AbSH1QNz>; Wed, 28 Aug 2002 12:13:55 -0400
Date: Wed, 28 Aug 2002 17:18:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Tweedie <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/8] 2.4.20-pre4/ext3: Fix O_SYNC for non-data-journaled modes.
Message-ID: <20020828171813.A2661@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Tweedie <sct@redhat.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <200208281545.g7SFjKE14338@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208281545.g7SFjKE14338@sisko.scot.redhat.com>; from sct@redhat.com on Wed, Aug 28, 2002 at 04:45:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 04:45:20PM +0100, Stephen Tweedie wrote:
> ext3 has its own code which marks buffers dirty, in addition to the setting
> done by the core generic_commit_write code.  However, the core code does
> 
>                         if (!atomic_set_buffer_dirty(bh)) {
>                                 __mark_dirty(bh);
>                                 buffer_insert_inode_queue(bh, inode);
> 
> so if ext3 marks the buffer dirty itself, the core fails to put it on the
> per-inode list of dirty buffers.  Hence, fsync_inode_buffers() misses it.
> 
> The fix is to let ext3 put the buffer on the inode queue manually when
> walking the page's buffer lists in its page write code.

This patch conflicts with the b_inode as bool patch you recently ACKed..

