Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbUEJXAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUEJXAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUEJW6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:58:46 -0400
Received: from nevyn.them.org ([66.93.172.17]:61577 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263041AbUEJW6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:58:33 -0400
Date: Mon, 10 May 2004 18:58:19 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Fabiano Ramos <ramos_fabiano@yahoo.com.br>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
Message-ID: <20040510225818.GA24796@nevyn.them.org>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Fabiano Ramos <ramos_fabiano@yahoo.com.br>, Andi Kleen <ak@muc.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1UlcA-6lq-9@gated-at.bofh.it> <m365b4kth8.fsf@averell.firstfloor.org> <1084220684.1798.3.camel@slack.domain.invalid> <877jvkx88r.fsf@devron.myhome.or.jp> <873c67yk5v.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873c67yk5v.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 07:47:08AM +0900, OGAWA Hirofumi wrote:
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
> 
> > So single-step exception happen *after* executed the "mov ...".
> > Probably you need to use the breakpoint instead of single-step.
> 
> Ah, sorry. Just use PTRACE_SYSCALL instead of PTRACE_SINGLESTEP.
> It's will stop before/after does syscall.

Doing it this way is pretty lousy - you have to inspect the code after
every step to see if it's an int $0x80.  Is there some reason not to
report a trap on the syscall return path if single-stepping?

-- 
Daniel Jacobowitz
