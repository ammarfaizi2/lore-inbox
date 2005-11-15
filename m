Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVKOCJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVKOCJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVKOCJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:09:52 -0500
Received: from mx1.suse.de ([195.135.220.2]:59559 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932278AbVKOCJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:09:51 -0500
From: Neil Brown <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Tue, 15 Nov 2005 13:09:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.17257.418305.280087@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ] Fix some problems with truncate and mtime semantics.
In-Reply-To: message from Trond Myklebust on Monday November 14
References: <20051115125657.9403.patches@notabene>
	<1051115020002.9459@suse.de>
	<1132020190.8802.28.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 14, trond.myklebust@fys.uio.no wrote:
> On Tue, 2005-11-15 at 13:00 +1100, NeilBrown wrote:
> > Resubmitting this patch to fix truncate/mtime semantics.  
> > 
> > It is against 2.6.14-mm2 and is probably suitable for 2.6.15, but can
> > be held over to 2.6.16 if you are feeling cautious.
> > 
> > NeilBrown
> > 
> > ### Comments for Changeset
> > 
> > SUS requires that when truncating a file to the size that it currently
> > is:
> >   truncate and ftruncate should NOT modify ctime or mtime
> >   O_EXCL SHOULD modify ctime and mtime.
>     ^^^^^ O_CREAT ;-)

Groan... thanks Trond.
Andrew .. if you could just do a little edit there for me, I'd really
appreciate it :-(

NeilBrown

> 
> > Currently mtime and ctime are always modified on most local
> > filesystems (side effect of ->truncate) or never modified (on NFS).
> > 
> > With this patch:
> >   ATTR_CTIME|ATTR_MTIME are sent with ATTR_SIZE precisely when 
> >     an update of these times is required whether size changes or not 
> >     (via a new argument to do_truncate).  This allows NFS to do
> >     the right thing for O_EXCL.
>                           ^^^^^
> 
> Cheers,
>   Trond
