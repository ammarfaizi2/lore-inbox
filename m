Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268970AbUJQAQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268970AbUJQAQE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUJQAQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:16:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28607 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268977AbUJQAOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:14:11 -0400
Date: Sun, 17 Oct 2004 01:14:09 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Avi Kivity <avi@exanet.com>
Cc: Yasushi Saito <ysaito@hpl.hp.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
Message-ID: <20041017001409.GH17142@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Avi Kivity <avi@exanet.com>, Yasushi Saito <ysaito@hpl.hp.com>,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	suparna@in.ibm.com, Janet Morgan <janetmor@us.ibm.com>
References: <416EDD19.3010200@hpl.hp.com> <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk> <4170AF35.7030806@exanet.com> <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk> <4170DF18.50004@exanet.com> <20041016162836.GG17142@parcelfarce.linux.theplanet.co.uk> <41715A5F.2060006@exanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41715A5F.2060006@exanet.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 07:29:03PM +0200, Avi Kivity wrote:
> No. An iovec is already merged; it is known that adjacent segments of an 
> iovec have adjacent offsets. a single IO_CMD_READV iovec can generate a 
> single bio without any merging.

	A slightly embarrassed glance at the manpage later, I recall
that fact.  Something I never liked about writev(), but that's a moot
point.

> That's not what I meant. If you submit 16 iocbs which are merged by the 
> kernel, and there is an error somewhere within the seventh iocb, I would 
> expect to get 15 success completions and one error completion. so error 
> information from the merged iocb must be demultiplexed into the originals.

	This takes no effort, really, for the kernel.  The block layer
handles it.

> If you have a single iocb, then any error simply fails that iocb.

	True, but in some senses (and this is application specific) you
want to know that 15/16ths succeeded.  But we're talking about
application needs, not kernel design.  So it's moot for the technical
argument of whether READV is a useful operation.  I just wanted to have
the discussion.  It wasn't an objection per se.

> I think what happened was that the number of iocbs submitted (64 iocbs 
> of 4K each) did not merge because the device queue depth was very large; 
> no queuing occured because (I imagine) merging happens while a request 
> is waiting for disk readiness.

	Why did you submit 64 iocbs of 4K?  Was every page virtually
discontiguous, or did you arbitrarily decide to create a worst-case?

Joel

-- 

Life's Little Instruction Book #510

	"Count your blessings."

			http://www.jlbec.org/
			jlbec@evilplan.org
