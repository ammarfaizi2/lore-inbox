Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVDZQEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVDZQEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDZQEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:04:22 -0400
Received: from mail.shareable.org ([81.29.64.88]:17577 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261625AbVDZP4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:56:25 -0400
Date: Tue, 26 Apr 2005 16:56:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       John Stoffel <john@stoffel.org>, Ville Herva <v@iki.fi>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050426155615.GE14297@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <1114528782.13568.8.camel@lade.trondhjem.org> <20050426154708.GC14297@mail.shareable.org> <426E638B.9070704@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E638B.9070704@oktetlabs.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artem B. Bityuckiy wrote:
> Jamie Lokier wrote:
> >The problem with making them exclusive locks is that you halt the
> >system for the duration of the transaction.  If it's a big transaction
> >such as updating 1000 files for a package update, that blocks a lot of
> >programs for a long time, and it's not necessary.
> 
> Surely we'll anyway block others if we have a kernel-level
> transaction support?  What is the difference in which layer to
> block?

No.  Why would you block?  You can have transactions without blocking
other processes.

When updating, say, the core-utils package (which contains cat),
there's no reason why a program which executes "cat" should have to
block during the update.  It can simply execute the old one until the
new one is committed at the end of the update.

It's analogous to RCU for protecting kernel data structures without
blocking readers.

-- Jamie
