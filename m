Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUE0OQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUE0OQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUE0OQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:16:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:3470 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264530AbUE0OQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:16:52 -0400
Date: Thu, 27 May 2004 16:15:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
       mingo@elte.hu, riel@redhat.com, torvalds@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527141547.GC23194@wohnheim.fh-wedel.de>
References: <1ZQpn-1Rx-1@gated-at.bofh.it> <1ZQz8-1Yh-15@gated-at.bofh.it> <1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it> <206b3-5WN-33@gated-at.bofh.it> <20baw-1Lz-15@gated-at.bofh.it> <m38yff7zn3.fsf@averell.firstfloor.org> <20040527112705.GA21190@wohnheim.fh-wedel.de> <20040527134950.GB3889@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040527134950.GB3889@dualathlon.random>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 15:49:50 +0200, Andrea Arcangeli wrote:
> On Thu, May 27, 2004 at 01:27:05PM +0200, Jörn Engel wrote:
> > Cool!  If that is included, I don't have any objections against 4k
> > stacks anymore.
> 
> note that it will introduce an huge slowdown, there's no way to enable
> that in production. But for testing it's fine.

Would it be possible to add something short to the function preamble
on x86 then?  Similar to this code, maybe:

if (!(stack_pointer & 0xe00))	/* less than 512 bytes left */
	*NULL = 1;

Not sure how this can be translated into short and fast x86 assembler,
but if it is possible, I would really like to have it.  Then all we
have left to do is make sure no function ever uses more than 512
bytes.  Famous last words, I know.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
