Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVJOPhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVJOPhI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 11:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJOPhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 11:37:08 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:65486 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751155AbVJOPhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 11:37:06 -0400
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange>
	<m3slvtzf72.fsf@telia.com>
	<Pine.LNX.4.60.0509252026290.3089@poirot.grange>
	<m34q873ccc.fsf@telia.com>
	<Pine.LNX.4.60.0509262122450.4031@poirot.grange>
	<m3slvr1ugx.fsf@telia.com>
	<Pine.LNX.4.60.0509262358020.6722@poirot.grange>
	<m3hdc4ucrt.fsf@telia.com>
	<Pine.LNX.4.60.0509292116260.11615@poirot.grange>
	<m3k6gw86f0.fsf@telia.com>
	<Pine.LNX.4.60.0510092304550.14767@poirot.grange>
	<m3psqewe30.fsf@telia.com>
	<Pine.LNX.4.60.0510112325410.19291@poirot.grange>
	<m37jcjiula.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Oct 2005 17:36:52 +0200
In-Reply-To: <m37jcjiula.fsf@telia.com>
Message-ID: <m3acharduz.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
> 
> > Well, I've had this patch (to 2.6.13) failing once, whereas I still 
> > haven't been able to reproduce the error with your previous patch. What 
> > now? A bit worrying is that test results are not 100% deterministic now... 
> > Which means, until recently my standard test (copy about 150M co the 
> > CD-RW && sync) produced always consistent results, now I've seen a couple 
> > of times the same driver version either failing or succeeding...
> 
> My current theory is that there is something wrong with the firmware
> or hardware in your drive, and different I/O patterns have different
> probabilities of triggering this problem.
> 
> Maybe you could use Jens' IO tracing patch to identify the sequence of
> commands that make the drive fail. See subject "[PATCH] Block device
> io tracing" posted by Jens earlier today.
> 
> If the problem is always caused by some well defined sequence of
> commands, it might be possible to implement a workaround in the
> pktcdvd driver.

I have found a problem on one of my drives. On my FC4 system, hald and
kded are constantly doing something with the drive, and this makes it
fail when I try to do packet writing. Killing those processes make
that drive work correctly. Maybe this helps in your case too. Try
packet writing from single user mode to see if it helps.

I don't know yet how to make hald and kded stay away from the drive
while packet writing is in progress.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
