Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264752AbUEKOHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264752AbUEKOHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbUEKOHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:07:39 -0400
Received: from nevyn.them.org ([66.93.172.17]:27025 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S264752AbUEKOHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:07:31 -0400
Date: Tue, 11 May 2004 10:07:22 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
Message-ID: <20040511140722.GA13568@nevyn.them.org>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Andi Kleen <ak@muc.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1UlcA-6lq-9@gated-at.bofh.it> <m365b4kth8.fsf@averell.firstfloor.org> <1084220684.1798.3.camel@slack.domain.invalid> <877jvkx88r.fsf@devron.myhome.or.jp> <873c67yk5v.fsf@devron.myhome.or.jp> <20040510225818.GA24796@nevyn.them.org> <1084236054.1763.25.camel@slack.domain.invalid> <Pine.LNX.4.58.0405102253480.1156@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0405102324350.1156@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0405102340260.1156@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405102340260.1156@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 11:41:53PM -0700, Davide Libenzi wrote:
> On Mon, 10 May 2004, Davide Libenzi wrote:
> 
> > On Mon, 10 May 2004, Davide Libenzi wrote:
> > 
> > > On the kernel side, this would be pretty much solved by issuing a ptrace 
> > > op, with a modified EIP (+2) on return from a syscall (if in single-step 
> > > mode).
> > 
> > Actaully, the EIP should not be changed (since it already points to the 
> > intruction following INT 0x80) and I believe it is sufficent to replace 
> > the test for _TIF_SYSCALL_TRACE with (_TIF_SYSCALL_TRACE | TIF_SINGLESTEP) 
> > in the system call return path. This should generate a ptrace trap with 
> > EIP pointing to the next instruction following INT 0x80.
> 
> The patch below (for i386) should work.

Yeah, that's what I was suggesting.  I think the patch is right.

-- 
Daniel Jacobowitz
