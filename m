Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262030AbSJNQpf>; Mon, 14 Oct 2002 12:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbSJNQpe>; Mon, 14 Oct 2002 12:45:34 -0400
Received: from zok.SGI.COM ([204.94.215.101]:10160 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S262030AbSJNQpa>;
	Mon, 14 Oct 2002 12:45:30 -0400
Subject: Re: [patch] remove BKL from inode_setattr
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hugh Dickins <hugh@veritas.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <3DAAF3B2.24158D49@digeo.com>
References: <3DAA6587.2A4C24B0@digeo.com>
	<1034604439.25231.9.camel@jen.americas.sgi.com> 
	<3DAAF3B2.24158D49@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Oct 2002 11:49:00 -0500
Message-Id: <1034614140.30453.6.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 11:41, Andrew Morton wrote:
> > 
> > XFS deliberately does not take the BKL - anywhere. Our setattr
> > code is doing its own locking. You just added the BKL to a
> > bunch of xfs operations which do not need it. Now, vmtruncate
> > may need it, itself, but if vmtruncate does not, then the xfs
> > callout from vmtruncate certainly does not.
> > 
> 
> Sorry, but that is standard "bkl migration" methodology.  You had it
> before, so you get it after.  It is not my role to change XFS locking.

But you did .... my point was, XFS does not use the BKL at all, has
never needed it and never will. The setattr call you added it to
meant you added it to chown, chmod etc. When the BKL was migrated
down below the vfs layer in all those places I deliberately did not
add it to the XFS calls.

> 
> Anyway, I don't think these patches are going anywhere.

No problem,

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
