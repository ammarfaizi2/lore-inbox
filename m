Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVLFAsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVLFAsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVLFAsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:48:38 -0500
Received: from pat.uio.no ([129.240.130.16]:35502 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964869AbVLFAsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:48:37 -0500
Subject: Re: nfs unhappiness with memory pressure
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4394CFFF.3080009@yahoo.com.au>
References: <20051205180139.64009.qmail@web34114.mail.mud.yahoo.com>
	 <1133813590.12393.7.camel@lade.trondhjem.org>
	 <1133814806.12393.10.camel@lade.trondhjem.org>
	 <4394A87E.7050507@yahoo.com.au>
	 <1133817536.12393.21.camel@lade.trondhjem.org>
	 <1133817788.12393.26.camel@lade.trondhjem.org>
	 <4394CFFF.3080009@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 19:48:19 -0500
Message-Id: <1133830100.8007.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.001, required 12,
	autolearn=disabled, AWL 1.81, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 10:40 +1100, Nick Piggin wrote:

> > ...and most important of all: 'unstable' does _not_ mean that I/O is
> > active on those pages (unlike the apparent assumption in
> > vm_throttle_write.
> > That is why the choice is either to kick pdflush there, or to remove
> > nr_unstable from the accounting in that loop.
> > 
> 
> Doesn't matter if IO is actually active or not, if you've allocated
> memory for these unstable pages, then page reclaim can scan itself
> to death, which is what seems to have happened here. And which is
> what vm_throttle_write is supposed to help.

Unless someone somehow triggers an NFS commit, then nr_unstable is not
ever going to decrease, and your process will end up looping forever. In
fact, those nr_writeback that refer to NFS pages, will end up being
added to nr_unstable (because they have been written to the server, but
not committed to disk).

Cheers,
  Trond

