Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263842AbUECSjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUECSjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUECSiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:38:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:64130 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263850AbUECSiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:38:15 -0400
Date: Mon, 3 May 2004 11:37:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: davidm@hpl.hp.com
cc: Andrew Morton <akpm@osdl.org>, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <16534.36778.587011.400850@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0405031134160.1589@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
 <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de>
 <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org>
 <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org>
 <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031109520.1589@ppc970.osdl.org>
 <16534.36778.587011.400850@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 May 2004, David Mosberger wrote:
> 
> Yes.  On ia64, I held off on getting rid of kernel-internal syscalls
> entirely because I was too lazy to do kernel_thread().

Yeah, there's a few special calls that need more than just a simple 
C-level call. kernel_thread() and execve() ends up being the main ones, I 
think.

On alpha, you could never do the "system call from kernel space" thing in
the first place, so alpha has always just open-coded the things rather
than play games with the "legacy way". Not hugely difficult, at most it
requires one or two assembler wrappers for those special calls that want a
"struct pt_regs" thing passed into them.

		Linus
