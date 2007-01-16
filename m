Return-Path: <linux-kernel-owner+w=401wt.eu-S1751016AbXAPKaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbXAPKaj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbXAPKag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:30:36 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:50088 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbXAPKaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:30:06 -0500
Date: Tue, 16 Jan 2007 13:24:21 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Nate Diller <nate@agami.com>, Nate Diller <nate.diller@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Subject: Re: [PATCH -mm 2/10][RFC] aio: net use struct socket for io
Message-ID: <20070116102421.GA17284@2ka.mipt.ru>
References: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com> <20070116015450.9764.24404.patchbomb.py@nate-64.agami.com> <20070115214427.7fc55a6c@oldman>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20070115214427.7fc55a6c@oldman>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 16 Jan 2007 13:24:31 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 09:44:27PM -0800, Stephen Hemminger (shemminger@osdl.org) wrote:
> > The sendmsg and recvmsg socket operations take a kiocb pointer, but none of
> > the functions actually use it.  There's really no need even theoretically,
> > it's really quite ugly having it there at all.  Also, removing it will pave
> > the way for a more generic completion path in the file_operations.
> > 
> > ---
> 
> Would getting rid of these make later implementation of AIO networking
> harder?

Depending on what AIO it will be.
Mainstream AIO does stand on kiocb, but if socket operations will be
extended to have additional async_read/write (like it as done in kevent
AIO) there is no need to have this pointer in sync operations (until
people want to have sync aio just as async with waiting for completion).

So, real question is, what next - how network AIO will be implemented?

-- 
	Evgeniy Polyakov
