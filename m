Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUIITQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUIITQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIITNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:13:21 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:14499 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S266741AbUIITMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:12:44 -0400
Date: Thu, 9 Sep 2004 21:11:42 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909191142.GA30151@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909184933.GG3106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 11:49:33 -0700, William Lee Irwin III wrote:
> I'll follow up shortly with a task_mem()/task_mem_cheap() consolidation
> patch atop the others I sent.

I have a few minor changes coming up as well.

One nitpick: As vmexe and vmlib are always 0 for !CONFIG_MMU, we should
ifdef them out of the list of offered fields for that configuration (and
maybe in nproc_ps_field as well).

> On Thu, Sep 09, 2004 at 08:43:01PM +0200, Roger Luethi wrote:
> > There seems to be a discrepancy between current task_mem in
> > fs/proc/task_nommu.c and the __task_mem{,_cheap} routines you wrote
> > for the nproc !CONFIG_MMU case. Can you explain?
> 
> I'm not aware of a discrepancy with the fs/proc/task_nommu.c code; I
> did, however, have to mangle the things via guesswork to avoid adding
> the new fields, which I really wanted you to arrange for or comment on
> as they are a matter of interface. Also, could you be more specific
> about these discrepancies?

task_nommu.c offers Mem, Slack, and Shared. __task_mem for !CONFIG_MMU
offers VmData, VmStack, VmRSS, VmSize.

Roger
