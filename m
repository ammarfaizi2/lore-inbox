Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUAPS33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbUAPS32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:29:28 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:34202 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265745AbUAPS3Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:29:24 -0500
Date: Fri, 16 Jan 2004 10:29:15 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: marcel cotta <marcel@kriminell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1: kernel BUG at mm/swapfile.c:806
Message-ID: <20040116182915.GL1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	marcel cotta <marcel@kriminell.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <400787F7.4030005@kriminell.com> <Pine.LNX.4.44.0401161618310.7487-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401161618310.7487-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 05:05:55PM +0000, Hugh Dickins wrote:
> On Fri, 16 Jan 2004, marcel cotta wrote:
> > i just tried to less it - the process went right into D state :p
> 
> That sounds like an issue that came up a month or two back: seems that
> sys_swapon intentionally leaves a semaphore down on a swapfile, until
> sys_swapoff.  I don't like that at all!  The noble reason was to stop
> that file from being deleted or truncated while in use for swap,
> but perhaps we can devise a better way to achieve that sometime -
> set S_IMMUTABLE?

Can't the kernel just keep a reference to the inode while it is used for
swap, and let it unlink after swapoff (and all other refs are gone) using
normal unix semantics? 
