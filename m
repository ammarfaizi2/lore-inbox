Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265067AbUFAORd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbUFAORd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUFAORW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:17:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:1018 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265067AbUFAOO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:14:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16572.36658.944349.27025@alkaid.it.uu.se>
Date: Tue, 1 Jun 2004 16:14:10 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
In-Reply-To: <20040601135737.GA18989@infradead.org>
References: <20040601021539.413a7ad7.akpm@osdl.org>
	<20040601102928.GA16718@infradead.org>
	<16572.34833.366022.48748@alkaid.it.uu.se>
	<20040601135737.GA18989@infradead.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Tue, Jun 01, 2004 at 03:43:45PM +0200, Mikael Pettersson wrote:
 > > Been there, done that. open() on /proc/{$pid,self}/perfctr with
 > > or without O_CREAT was the "get initial access" interface for
 > > several years, until the semantics of /proc/$pid (and /proc/self)
 > > completely changed in 2.6.0-test6.
 > > 
 > > Virtual perfctrs wants something that denotes the real kernel
 > > task, not that process-is-a-group-of-kernel-threads crap.
 > 
 > I'm not on a nptl system here, so no thread groups in use, but don't
 > we have /proc/$pid/$tid/ now?

Maybe. I didn't investigate the subdirectory semantics too
closely because at the time I wanted something that could
work in both 2.6 and 2.4. Hence the self-contained ioctl()
on a char-misc device approach in perfctr-2.6.

A file-system open() solution needs:
1. A simple predictable file name that denotes your own task.
2. Given a task id (however it's retrieved, but it's not getpid()),
   a file name that denotes that and only that task.

 > And yes, I agree with you that the change was utter crap, still wondering
 > how it went in without proper review.

I'm biased :-) but I think the main reason had to do with
systems with many thousands of threads, which may have
made /proc and tools like top and ps behave poorly.

/Mikael
