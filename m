Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVAHTbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVAHTbD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 14:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVAHTbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 14:31:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61120 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261284AbVAHTbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 14:31:01 -0500
Date: Sat, 8 Jan 2005 19:31:01 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Export get_sb_pseudo()?
Message-ID: <20050108193101.GD26051@parcelfarce.linux.theplanet.co.uk>
References: <52k6qn229h.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52k6qn229h.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 10:40:10AM -0800, Roland Dreier wrote:
> I'm planning on implementing some modular driver code and I think it
> makes sense to have a non-mountable pseudofs.  Especially with the
> recent MVFS controversy, it seems prudent to find out whether this
> usage would merit exporting get_sb_pseudo(), so I'll describe my
> current plans below.

No objections; it certainly falls under "general-purpose library
helper".  Moreover, in this case I _insist_ on use of normal
export; it is a convenience helper that
	a) can be trivially reimplemented by anyone who cares; any
number of filesystems is open-coding far more than that in their
->get_sb(), so there's nothing to protect here.
	b) can be trivially simulated by simple_fill_super() followed
by a bit of tweaking the result.
	c) does not shove any pitchforks into the kernel guts - resulting
superblock does not require any special treatment.

So feel free to go ahead and export it; as the matter of fact, if you
don't do it, I will.  And that puppy is my code except for one line
from Andi Kleen (sb->s_time_gran = 1; ;-).  Since we both are OK with
full export (I'd just asked him), anybody who has objections to that
can take 'em and shove 'em...
