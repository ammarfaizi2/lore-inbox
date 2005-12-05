Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVLEVX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVLEVX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVLEVX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:23:28 -0500
Received: from pat.uio.no ([129.240.130.16]:31701 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932481AbVLEVX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:23:27 -0500
Subject: Re: nfs unhappiness with memory pressure
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1133817536.12393.21.camel@lade.trondhjem.org>
References: <20051205180139.64009.qmail@web34114.mail.mud.yahoo.com>
	 <1133813590.12393.7.camel@lade.trondhjem.org>
	 <1133814806.12393.10.camel@lade.trondhjem.org>
	 <4394A87E.7050507@yahoo.com.au>
	 <1133817536.12393.21.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 16:23:08 -0500
Message-Id: <1133817788.12393.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.712, required 12,
	autolearn=disabled, AWL 1.29, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 16:18 -0500, Trond Myklebust wrote:
> On Tue, 2005-12-06 at 07:52 +1100, Nick Piggin wrote:
> 
> > The VM doesn't expect to have to rely on pdflush to write out pages
> > for it. ->writepage should be enough. Adding wakeup_pdflush here
> > actually could do the wrong thing for non-NFS filesystems if it
> > starts more writeback.
> 
> nr_unstable is not going to be set for non-NFS filesystems. 'unstable'
> is a caching state in which pages have been written out to the NFS
> server, but the server has not yet flushed the data to disk.

...and most important of all: 'unstable' does _not_ mean that I/O is
active on those pages (unlike the apparent assumption in
vm_throttle_write.
That is why the choice is either to kick pdflush there, or to remove
nr_unstable from the accounting in that loop.

Cheers,
  Trond

