Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUBKM04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 07:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbUBKM04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 07:26:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15762 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264310AbUBKM0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 07:26:53 -0500
Date: Wed, 11 Feb 2004 13:27:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: open-scale-2.6.2-A0
Message-ID: <20040211122753.GA15129@elte.hu>
References: <20040211115828.GA13868@elte.hu> <20040211122031.GC15127@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211122031.GC15127@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jamie Lokier <jamie@shareable.org> wrote:

> Ingo Molnar wrote:
> > i've attached an obvious scalability improvement for write()s. We in
> > essence used a system-global lock for every open(WRITE) - argh!
> 
> I wonder if the "rip the second arsehole" is there for a reason.

these days i dont think the comment is justified.

> Does this scalability improvement make any measured difference in any
> conceivable application, or is it just making struct inode larger?

i've not added any new lock, i'm merely reusing the existing ->i_lock. 
So there's no data or code bloat whatsoever.

one doesnt need any measurements to tell that a global cacheline
dirtying for every (most of the time completely unrelated) open(WRITE)
will hurt workloads that do that, especially on NUMA systems. I'd not be
surprised if it showed up in dbench/netbench.

	Ingo
