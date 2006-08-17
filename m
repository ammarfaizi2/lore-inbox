Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWHQEJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWHQEJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 00:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWHQEJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 00:09:13 -0400
Received: from ns.suse.de ([195.135.220.2]:22676 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932389AbWHQEJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 00:09:13 -0400
From: Neil Brown <neilb@suse.de>
To: David Chinner <dgc@sgi.com>
Date: Thu, 17 Aug 2006 14:08:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17635.60378.733953.956807@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow writeback.
In-Reply-To: message from David Chinner on Wednesday August 16
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 16, dgc@sgi.com wrote:
> 
> IMO, if you've got slow writeback, you should be reducing the amount
> of dirty memory you allow in the machine so that you don't tie up
> large amounts of memory that takes a long time to clean. Throttle earlier
> and you avoid this problem entirely.

I completely agree that 'throttle earlier' is important.  I just not
completely sure what should be throttled when.

I think I could argue that pages in 'Writeback' are really still
dirty.  The difference is really just an implementation issue.

So when the dirty_ratio is set to 40%, that should apply to all
'dirty' pages, which means both that flagged as 'Dirty' and those
flagged as 'Writeback'.

So I think you need to throttle when Dirty+Writeback hits dirty_ratio
(which we don't quite get right at the moment).  But the trick is to
throttle gently and fairly, rather than having a hard wall so that any
one who hits it just stops.


Thanks,
NeilBrown
