Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTJNPNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTJNPNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:13:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36545 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262562AbTJNPNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:13:37 -0400
Date: Tue, 14 Oct 2003 17:12:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide barrier support, #2
Message-ID: <20031014151230.GS1107@suse.de>
References: <GurO.7cg.43@gated-at.bofh.it> <m3zng4ou90.fsf@averell.firstfloor.org> <20031014125723.GR1107@suse.de> <20031014150807.GA99122@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014150807.GA99122@colin2.muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14 2003, Andi Kleen wrote:
> > Uh be careful! It must be WRITEBARRIER, not WRITESYNC. I think I'll kill
> > WRITEBARRIER and just call it WRITESYNC, it's more logical. I've added
> > the modified variant, thanks.
> 
> Why? The journaling just checks if the write finished and then submits
> the dependent writes. It doesn't care about reordering.

See the patch, WRITESYNC is used solely internally in raid1.
WRITEBARRIER is a bitmask of BIO_RW and BIO_RW_BARRIER and that is what
you want. I'll make that more clear. Writes will not be reordered around
the barrier either, btw.

> As long as WRITESYNC guarantees that the data hit disk when completed
> then it should be ok.

Yep.

-- 
Jens Axboe

