Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUIISs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUIISs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUIISpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:45:15 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:32922 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S266631AbUIISoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:44:05 -0400
Date: Thu, 9 Sep 2004 20:43:01 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909184300.GA28278@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909003529.GI3106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2004 17:35:29 -0700, William Lee Irwin III wrote:
> On Wed, Sep 08, 2004 at 08:41:30PM +0200, Roger Luethi wrote:
> > A few notes:
> > - Access control can be implemented easily. Right now it would be bloat,
> >   though -- the vast majority of fields in /proc are world-readable
> >   (/proc/pid/environ being the notable exception).
> > - Additional process selectors (e.g. select by UID) are not hard to
> >   add, either, should there ever be a need.
> > - There are a few things I'm not sure about: For instance, what is a good
> >   return value for mm_struct related fields wrt kernel threads? I picked
> >   0, but ~(0) might be preferable because it's distinct.
> > Signed-off-by: Roger Luethi <rl@hellgate.ch>
> 
> Any chance you could convert these to use the new vm statistics
> accounting?

Mea culpa. I copied the routines wholesale from 2.6.7 when I started
work on nproc. They still seemed to work with 2.6.9-rc1-bk13, I hadn't
noticed the work that had gone into field computation already. So for
CONFIG_MMU, values in both __task_mem and __task_mem_cheap are cheap
now. The routines can be merged.

!CONFIG_MMU is a different story. Presumably, it needs a change in the
fields that are offered (cp. task_mem in fs/proc/task_nommu.c).

FWIW, my prefered solution would be to have only one routine task_mem
to fill the respective struct for nproc and /proc.

There seems to be a discrepancy between current task_mem in
fs/proc/task_nommu.c and the __task_mem{,_cheap} routines you wrote
for the nproc !CONFIG_MMU case. Can you explain?

Roger
