Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWCTUgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWCTUgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWCTUgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:36:02 -0500
Received: from mail.fieldses.org ([66.93.2.214]:50826 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030253AbWCTUgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:36:00 -0500
Date: Mon, 20 Mar 2006 15:35:56 -0500
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: DoS with POSIX file locks?
Message-ID: <20060320203556.GC31512@fieldses.org>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org> <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu> <20060320123950.GF8980@parisc-linux.org> <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu> <20060320153202.GH8980@parisc-linux.org> <E1FLNRi-0000We-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FLNRi-0000We-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 05:41:30PM +0100, Miklos Szeredi wrote:
> > > Things look fairly straightforward if the accounting is done in
> > > files_struct instead of task_struct.  At least for POSIX locks.  I
> > > haven't looked at flocks or leases yet.
> > 
> > I was thinking that would work, yes.  It might not be worth worrying
> > about accounting for leases/flocks since each process can only have one
> > of those per open file anyway.
> 
> Here's a minimally tested patch.  The only tricky part is when the
> unlock splits an existing lock in two.
> 
> Also the limit checking is sloppy when the lock is split, and in that
> case allows the counter to go one above the limit.

Do you need to handle blocks as well as applied locks?

--b.
