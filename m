Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264664AbUD1F37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbUD1F37 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbUD1F37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:29:59 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:55307 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264664AbUD1F35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:29:57 -0400
Date: Wed, 28 Apr 2004 06:29:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
Message-ID: <20040428062942.A27705@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@osdl.org>, sgoel01@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com> <20040426191512.69485c42.akpm@osdl.org> <1083035471.3710.65.camel@lade.trondhjem.org> <20040426205928.58d76dbc.akpm@osdl.org> <1083043386.3710.201.camel@lade.trondhjem.org> <20040426225834.7035d2c1.akpm@osdl.org> <1083080207.2616.31.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1083080207.2616.31.camel@lade.trondhjem.org>; from trond.myklebust@fys.uio.no on Tue, Apr 27, 2004 at 11:36:47AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 11:36:47AM -0400, Trond Myklebust wrote:
> writepage() only deals with one page at a time, so it will work fine for
> doing stage 1.
> If you also try force it to do stage 2, then you will end up with chunks
> of size <= PAGE_CACHE_SIZE because there will only be 1 page on the NFS
> private list of dirty pages. In practice this again means that you
> usually have to send 8 times as many RPC requests to the server in order
> to process the same amount of data.

There's nothing speaking against probing for more dirty pages before and
after the one ->writepage wants to write out and send the big request
out.  XFS does this to avoid creating small extents when converting from
delayed allocated space to real extents.

