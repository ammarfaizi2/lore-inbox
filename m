Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTD1MdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTD1MdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:33:08 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:8199 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263199AbTD1MdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:33:07 -0400
Date: Mon, 28 Apr 2003 14:45:14 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <20030428124514.GA12662@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, Mark Grosberg wrote:

> Is there any interest in a single system call that will perform both a
> fork() and exec()? Could this save some extra work of doing a
> copy_mm(), copy_signals(), etc?

How about doing vfork() right (fixing the "what if execve(2) fails"
race) instead?

> I know almost all of my fork()-exec() code does almost the same thing. I
> guess vfork() was a potential solution, but this somehow seems cleaner
> (and still may be more efficient than having to issue two syscalls)...
> the downside is, of course, another syscall.

Which is a major showstopper, because it'd only be useful to
non-portable, Unix-specific applications (thus it wouldn't be put to
much use). OTOH, copy-on-write pages will eliminate much of the overhead
already.
