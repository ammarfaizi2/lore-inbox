Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWHYOQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWHYOQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWHYOQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:16:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40596 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751462AbWHYOQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:16:46 -0400
Date: Fri, 25 Aug 2006 15:16:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] BLOCK: Dissociate generic_writepages() from mpage stuff [try #2]
Message-ID: <20060825141625.GI10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213310.21323.91875.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213310.21323.91875.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:33:11PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Dissociate the generic_writepages() function from the mpage stuff, moving its
> declaration to linux/mm.h and actually emitting a full implementation into
> mm/page-writeback.c.
> 
> The implementation is a partial duplicate of mpage_writepages() with all BIO
> references removed.
> 
> It is used by NFS to do writeback.

This duplication is rather unfortunate, but I don't see a way to distangle
this any better, so ok.

> @@ -693,6 +693,8 @@ out:
>   * the call was made get new I/O started against them.  If wbc->sync_mode is
>   * WB_SYNC_ALL then we were called for data integrity and we must wait for
>   * existing IO to complete.
> + *
> + * !!!! If you fix this you should check generic_writepages() also!!!!

This isn't very elegant comment style :)  What about a little less shouting..

>  int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
> +extern int generic_writepages(struct address_space *mapping,
> +			      struct writeback_control *wbc);
>  int do_writepages(struct address_space *mapping, struct writeback_control *wbc);

please try to fit the style of the surrounding prototypes, that is no
'extern'

