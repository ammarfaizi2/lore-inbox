Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbTGDLxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbTGDLxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:53:33 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:14283 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266005AbTGDLxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:53:31 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Frank Cusack <fcusack@fcusack.com>
Date: Fri, 4 Jul 2003 22:07:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16133.28181.941806.630834@gargle.gargle.HOWL>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: help backporting workqueue to 2.4; for net/sunrpc/cache.c
In-Reply-To: message from Frank Cusack on Friday July 4
References: <20030704043537.A21552@google.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 4, fcusack@fcusack.com wrote:
> Hi all,
> 
> Should I expect any problems backporting the 2.5 workqueue.c to 2.4?
> It looks pretty straightforward, but I am {naive,novice}.  The only
> interesting looking bit is setting current->flags |= PF_IOTHREAD,
> which doesn't exist in 2.4.  At a glance, it looks like I can ignore
> this; it's used in suspend.c which doesn't exist in 2.4 either.
> 
> The reason I'd like to backport this is because of changes in sunrpc
> which now use the workqueue to clean auth caches.  Related question:
> how is this (periodic cache clean) done in 2.5.73 and earlier?
> net/sunrpc/cache.c didn't use the workqueue until 2.5.74.

The nfsd threads called cache_clean() from nfsd() in nfsd/nfssvc.c,
whenever they didn't have anything else to do, but this wasn't really
often enough.  You could probably get them to do it after every
request as cache_clean() does virtually nothing unless there is
evidence that something needs doing.

NeilBrown


> 
> Any advice is appreciated.
> 
> thanks
> /fc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
