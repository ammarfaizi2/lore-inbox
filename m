Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUAPSnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUAPSnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:43:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:52457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265622AbUAPSnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:43:03 -0500
Date: Fri, 16 Jan 2004 10:43:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: hugh@veritas.com, marcel@kriminell.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: kernel BUG at mm/swapfile.c:806
Message-Id: <20040116104310.0a5e70cd.akpm@osdl.org>
In-Reply-To: <20040116182915.GL1748@srv-lnx2600.matchmail.com>
References: <400787F7.4030005@kriminell.com>
	<Pine.LNX.4.44.0401161618310.7487-100000@localhost.localdomain>
	<20040116182915.GL1748@srv-lnx2600.matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> On Fri, Jan 16, 2004 at 05:05:55PM +0000, Hugh Dickins wrote:
> > On Fri, 16 Jan 2004, marcel cotta wrote:
> > > i just tried to less it - the process went right into D state :p
> > 
> > That sounds like an issue that came up a month or two back: seems that
> > sys_swapon intentionally leaves a semaphore down on a swapfile, until
> > sys_swapoff.  I don't like that at all!  The noble reason was to stop
> > that file from being deleted or truncated while in use for swap,
> > but perhaps we can devise a better way to achieve that sometime -
> > set S_IMMUTABLE?
> 
> Can't the kernel just keep a reference to the inode while it is used for
> swap, and let it unlink after swapoff (and all other refs are gone) using
> normal unix semantics? 

Unlink is not the problem.  The problem is truncation.  swapon holds i_sem
to prevent people from adding or removing blocks while the swapfile is in
use.

