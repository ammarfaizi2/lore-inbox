Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUJOPfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUJOPfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUJOPfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:35:13 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:39686 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267976AbUJOPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:34:43 -0400
Date: Fri, 15 Oct 2004 16:34:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RESEND][PATCH 4/6] Add page becoming writable notification
Message-ID: <20041015153440.GA22607@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20041014203545.GA13639@infradead.org> <24449.1097780701@redhat.com> <28544.1097852703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28544.1097852703@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 04:05:03PM +0100, David Howells wrote:
> 
> > > +	/* notification that a page is about to become writable */
> > > +	int (*page_mkwrite)(struct page *page);
> > 
> > This doesn't fit into address_space operations at all.  The vm_operation
> > below is enough.
> 
> Filesystems shouldn't be overloading vm_operations on ordinary files, or so
> I've been instructed.

huh?  that doesn't make any sense.  if a filesystem needs to do something
special win regards to the VM it should overload vm_operations.  Currently
that's only ncpfs and xfs.

> > This prototype shows pretty much that splitting it out doesn't make much
> > sense.  Why not add a goto reuse_page; where you call it currently and
> > append it at the end of do_wp_page?
> 
> Judging by the CodingStyle doc - which you like throwing at me - it should be
> split into a separate inline function. I could come up with a better name, I
> suppose to keep Willy happy too - perhaps make_pte_writable(); it's just that
> I wanted to name it to show its derivation.

Splitting in helpers makes sense if there's a sane interface.  The number of
arguments doesn't exactly imply that it's the case here.

