Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSIESmO>; Thu, 5 Sep 2002 14:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSIESmO>; Thu, 5 Sep 2002 14:42:14 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:8967 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317986AbSIESmN>; Thu, 5 Sep 2002 14:42:13 -0400
Date: Thu, 5 Sep 2002 19:46:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905194649.A11789@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	lord@sgi.com
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905184125.GA1657@dualathlon.random>; from andrea@suse.de on Thu, Sep 05, 2002 at 08:41:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 08:41:25PM +0200, Andrea Arcangeli wrote:
> maybe I'm overlooking something but after a short read it seems you have
> no lock in do_truncate->setattr like for all the other fs, so the
> vmtruncate can run under reads and the i_size can change under you and
> in turn you must always read it with i_size_read using asm, like all the
> other fs, if you're not holding the i_sem (and you certainly aren't
> holding the i_sem that frequently, you don't even for writes). this
> because i_sem  is the only lock/sem hold by truncate.  Infact I'm unsure
> how you serialize the i_size writes of truncate against the ones from
> writes, that seems problematic too, the i_size could get a value past
> the last block allocated (in turn corrupting the fs). Please double
> check that I'm wrong, thanks.

I think we should take the XFS-specific inode lock around vmtruncate.
Need to double-check with Steve.

