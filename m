Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUD1TRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUD1TRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUD1TRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:17:15 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:11537 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264939AbUD1Qie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:38:34 -0400
Date: Wed, 28 Apr 2004 17:38:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
Message-ID: <20040428173811.A1505@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@osdl.org>, sgoel01@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com> <20040426191512.69485c42.akpm@osdl.org> <1083035471.3710.65.camel@lade.trondhjem.org> <20040426205928.58d76dbc.akpm@osdl.org> <1083043386.3710.201.camel@lade.trondhjem.org> <20040426225834.7035d2c1.akpm@osdl.org> <1083080207.2616.31.camel@lade.trondhjem.org> <20040428062942.A27705@infradead.org> <1083169062.2856.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1083169062.2856.36.camel@lade.trondhjem.org>; from trond.myklebust@fys.uio.no on Wed, Apr 28, 2004 at 12:17:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 12:17:42PM -0400, Trond Myklebust wrote:
> On Wed, 2004-04-28 at 01:29, Christoph Hellwig wrote:
> > There's nothing speaking against probing for more dirty pages before and
> > after the one ->writepage wants to write out and send the big request
> > out.  XFS does this to avoid creating small extents when converting from
> > delayed allocated space to real extents.
> 
> You are referring to xfs_probe_unmapped_page()?

Yes, and the two other functions doing similar stuff.

> True: we could do
> that... In fact we could do it a lot more efficiently now that we have
> the pagevec_lookup_tag() interface.

Yes pagevec are much more efficient for that.  In fact I have a workarea
switching over XFS to use pagevec for that probing.

I'm not yet sure where I'm heading with revamping xfs_aops.c, but what
I'd love to see in the end is more or less xfs implementing only
writepages and some generic implement writepage as writepages wrapper.
