Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSIERFe>; Thu, 5 Sep 2002 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSIERFd>; Thu, 5 Sep 2002 13:05:33 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:39686 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317892AbSIEREb>; Thu, 5 Sep 2002 13:04:31 -0400
Date: Thu, 5 Sep 2002 18:09:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905180904.A8406@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905165307.GC1254@dualathlon.random>; from andrea@suse.de on Thu, Sep 05, 2002 at 06:53:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 06:53:07PM +0200, Andrea Arcangeli wrote:
> btw, even if xfs is applied before the inode_read_write-atomic,  please
> make sure xfs will learn using the i_size_read when out of the semaphore
> and i_size_write too. I know the locking is different there but I doubt
> you're just managing the i_size without races.

XFS always has the XFS i_lock around accessing it.  Either in read mode
or in write mode for updates (the lock is a so-called mrlock which
basically as a rwsem with a few subtile differences).

Anyway most acceses i_size in the new code are done by the generic
code now as XFS calls it internally.  Take a look at the update I sent
you a few seconds ago :)
