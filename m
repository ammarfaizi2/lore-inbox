Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVKVAZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVKVAZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVKVAZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:25:39 -0500
Received: from pat.uio.no ([129.240.130.16]:62915 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964792AbVKVAZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:25:38 -0500
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1132618731.8011.46.camel@lade.trondhjem.org>
References: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
	 <1132612974.8011.12.camel@lade.trondhjem.org>
	 <20051121153454.1907d92a.akpm@osdl.org>
	 <1132617503.8011.35.camel@lade.trondhjem.org>
	 <20051121160913.6d59c9fa.akpm@osdl.org>
	 <1132618731.8011.46.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 19:25:13 -0500
Message-Id: <1132619113.8011.48.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.894, required 12,
	autolearn=disabled, AWL 1.92, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 19:18 -0500, Trond Myklebust wrote:
> On Mon, 2005-11-21 at 16:09 -0800, Andrew Morton wrote:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > >
> > > The only difference I can see between the two paths is the call to
> > >  unmap_mapping_range(). What effect would that have?
> > 
> > It shoots down any mapped pagecache over the affected file region.  Because
> > the direct-io write is about to make that pagecache out-of-date.  If the
> > application tries to use that data again it'll get a major fault and will
> > re-read the file contents.
> 
> I assume then, that this couldn't be the cause of the
> invalidate_inode_pages() failing to complete? Unless there is some
  ^^^^^^^^^^^^^^^^^^^^^^^^ invalidate_inode_pages2(), sorry....

> method to prevent applications from faulting in the page while we're
> inside generic_file_direct_IO(), then the same race would be able to
> occur there.

Cheers,
  Trond

