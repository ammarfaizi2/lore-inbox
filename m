Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUAaLsI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 06:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUAaLsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 06:48:07 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:61850 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S264547AbUAaLrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 06:47:45 -0500
Date: Sat, 31 Jan 2004 12:46:38 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: nathans@sgi.com
Cc: hch@infradead.org, miquels@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040131114638.GA29609@drinkel.cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org> <20040130225353.A26383@infradead.org> <20040130151316.40d70ed3.akpm@osdl.org> <20040131012507.GQ25833@drinkel.cistron.nl> <20040130173851.2cc5938f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040130173851.2cc5938f.akpm@osdl.org> (from akpm@osdl.org on Sat, Jan 31, 2004 at 02:38:51 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jan 2004 02:38:51, Andrew Morton wrote:
> Miquel van Smoorenburg <miquels@cistron.nl> wrote:
> > But the XFS problem appears to be vn_revalidate which calls i_size_write()
> > without holding i_sem:
> 
> There's your bug.

Okay. It seems that XFS uses its own locking with xfs_ilock() etc,
so I am not sure if this should be fixed by using down(&inode->i_sem)
or by using xfs_ilock().

Perhaps xfs_ilock() should also get the inode->i_sem semaphore
in the XFS_ILOCK_EXCL case ?

Also, there are one or two more places that call i_size_write()
that should be looked at I guess.

Ofcourse I'll test any patches you send me.

Mike.
