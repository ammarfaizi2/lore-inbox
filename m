Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUC3TGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbUC3TGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:06:47 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:55238 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263832AbUC3TGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:06:43 -0500
Date: Tue, 30 Mar 2004 20:06:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
In-Reply-To: <20040330190102.GD3808@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403302002090.23584-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Andrea Arcangeli wrote:
> On Tue, Mar 30, 2004 at 07:48:42PM +0100, Hugh Dickins wrote:
> > 
> > Do you have enough evidence that it's the very same bug?
> 
> yes, see the two stack traces, they trigger in the same place and it's
> the very same workload. Andrew just noticed that xfs indeed calls
> truncate_inode_pages before vmtruncate. It will trigger with your
> patches too.

Yes, Andrew has got it (and I agree XFS is wrong to be doing that).

> Ok I see what you mean, this should fix it, agreed?

Yes, that's exactly the fix (for when COWing a reserved page).

Hugh

