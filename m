Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUGGVGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUGGVGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265484AbUGGVGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:06:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44252 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265492AbUGGVGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:06:01 -0400
Date: Wed, 7 Jul 2004 14:02:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: wli@holomorphy.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: 2.6.7-mm6
Message-Id: <20040707140249.2bfe0a4b.davem@redhat.com>
In-Reply-To: <20040707073510.GA27609@elte.hu>
References: <20040705023120.34f7772b.akpm@osdl.org>
	<20040706125438.GS21066@holomorphy.com>
	<20040706233618.GW21066@holomorphy.com>
	<20040706170247.5bca760c.davem@redhat.com>
	<20040707073510.GA27609@elte.hu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004 09:35:10 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> the patch below should solve this. Is it safe on sparc to do a
> fork_by_hand() like this?

If the regs are garbage, copy_thread() will explode as it tries
to interpret the stack pointer in that regs value.

The parent's regs (stored in current_thread_info() at trap time,
and also needed by copy_thread() processing) will also be garbage
since we're avoiding the fork syscall trap.

In short, this won't work :)

This is why I use kernel_thread().  Why is that so bad?
