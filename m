Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUH0RCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUH0RCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUH0RCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:02:49 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:12948 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S266622AbUH0RCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:02:38 -0400
Date: Fri, 27 Aug 2004 19:01:43 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [0/2][ANNOUNCE] nproc: netlink access to /proc information
Message-ID: <20040827170143.GA31918@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827162308.GP2793@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 09:23:08 -0700, William Lee Irwin III wrote:
> These are many of the same issues raised in rusty's "current /proc/ of
> shit" thread from a while back.

The problems are not new. The driver stuff has been outsourced to /sysfs
in the meantime, though, and the information that is being added to
/proc these days is usually human-readable and a pain to parse.

> On Fri, Aug 27, 2004 at 02:24:12PM +0200, Roger Luethi wrote:
> > Another problem with /proc is speed. If we put all information in a few
> > large files, the kernel needs to calculate many fields even if a tool
> > is only interested in one of them. OTOH, if the informations is split
> > into many small files, VFS and related overhead increases if a tool
> > needs to read many files just for the information on one single process.
> > In summary, /proc suffers from diverging goals of its two groups of
> > users (human readers and parsers), and it doesn't scale well for tools
> > monitoring many fields or many processes.
> 
> There are more maintainability benefits from the interface improvement
> than speed benefits.

Agreed. That has been my initial motivation. Speed is a bonus.

> How many processes did you microbenchmark with?

Nothing worth mentioning. I have nothing in /proc space to compare
to. I was hoping someone would suggest a /proc based benchmark.

> I see no evidence that this will be a speedup with large numbers of
> processes, as the problematic algorithms are preserved wholesale.

It doesn't fundamentally change the complexity, but I expect the
reduction in overhead to be noticeable, mostly due to:
- no more string parsing.
- fewer system calls.
- fewer cycles wasted on calculating unnecessary data fields.

Roger
