Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbUJ1SY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUJ1SY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUJ1SY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:24:29 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:31628
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262813AbUJ1SYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:24:16 -0400
Date: Thu, 28 Oct 2004 11:15:54 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@muc.de>
Cc: prasanna@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, suparna@in.ibm.com,
       dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [0/3] PATCH Kprobes for x86_64- 2.6.9-final
Message-Id: <20041028111554.6879f3ca.davem@davemloft.net>
In-Reply-To: <20041028113744.GA82042@muc.de>
References: <20041028113208.GA11182@in.ibm.com>
	<20041028113744.GA82042@muc.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Oct 2004 13:37:44 +0200
Andi Kleen <ak@muc.de> wrote:

> Like I still would like to have the page fault notifier
> completely moved out of the fast path into no_context 
> (that i386 has it there is also wrong). Adding kprobe_runn 
> doesn't make a difference.

You can't do that actually Andi.

The kprobe notifier has to run for the case where the kernel
does a userspace access and faults.  This is to handle the
case of setting a kprobe on a userspace access instruction.
In such a event, we must unwind the reset the program counter
so that exception table processing is done with the correct
PC not the temporary one kprobes is using to execute the
instruction where the breakpoint currently lives.
