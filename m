Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWCTSXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWCTSXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWCTSXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:23:09 -0500
Received: from pat.uio.no ([129.240.130.16]:31216 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751193AbWCTSXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:23:08 -0500
Subject: Re: DoS with POSIX file locks?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060320153202.GH8980@parisc-linux.org>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <20060320153202.GH8980@parisc-linux.org>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 13:22:55 -0500
Message-Id: <1142878975.7991.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.003, required 12,
	autolearn=disabled, AWL 1.00, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 08:32 -0700, Matthew Wilcox wrote:
> On Mon, Mar 20, 2006 at 01:52:39PM +0100, Miklos Szeredi wrote:
> > Things look fairly straightforward if the accounting is done in
> > files_struct instead of task_struct.  At least for POSIX locks.  I
> > haven't looked at flocks or leases yet.
> 
> I was thinking that would work, yes.  It might not be worth worrying
> about accounting for leases/flocks since each process can only have one
> of those per open file anyway.
> 
> > steal_locks() might cause problems, but that function should be gotten
> > rid of anyway.
> 
> I quite agree.  Now we need to find a better way to solve the problem it
> papers over.

The _only_ sane way to solve it is to decree that you lose your locks if
you clone(CLONE_FILES) and then call exec(). If there are any
applications out there that rely on the current behaviour, then they are
doomed anyway since there is no way to implement it safely on non-local
filesystems.

Cheers,
  Trond

