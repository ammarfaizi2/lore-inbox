Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSGIV5E>; Tue, 9 Jul 2002 17:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSGIV5D>; Tue, 9 Jul 2002 17:57:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317430AbSGIV5C>; Tue, 9 Jul 2002 17:57:02 -0400
Subject: Re: BKL removal
To: rml@mvista.com (Robert Love)
Date: Tue, 9 Jul 2002 23:21:25 +0100 (BST)
Cc: wli@holomorphy.com (William Lee Irwin III),
       ricklind@us.ibm.com (Rick Lindsley), greg@kroah.com (Greg KH),
       haveblue@us.ibm.com (Dave Hansen),
       kernel-janitor-discuss@lists.sourceforge.net (kernel-janitor-discuss),
       linux-kernel@vger.kernel.org
In-Reply-To: <1026249175.1033.1178.camel@sinai> from "Robert Love" at Jul 09, 2002 02:12:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17S3MM-0005qO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Places that call schedule() explicitly holding the BKL are rare enough
> we can probably handle them.  I have a patch that does so (thus turning
> all cond_resched() calls into no-ops with the preemptive kernel -- my
> goal).  The other implicit situations are near impossible to handle.

There are lots of them hiding 8)

> Summary is, I would love to do things like dismantle the BKLs odd-ball
> features... cleanly and safely.  Good luck ;)

You can actually do it with some testing to catch the missed cases. Move
them to spinlocks, lob a check if the lock is held into the schedule code
run it for a while through its various code paths, then remove the debug
once you trust it
