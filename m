Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266385AbUBQSJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 13:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266413AbUBQSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 13:09:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20102 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266385AbUBQSJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 13:09:01 -0500
Date: Tue, 17 Feb 2004 10:08:52 -0800
From: "David S. Miller" <davem@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: mort@wildopensource.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce TLB flushing during process migration
Message-Id: <20040217100852.2eb50c4b.davem@redhat.com>
In-Reply-To: <40323FB6.1030208@colorfullife.com>
References: <40323FB6.1030208@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 17:22:14 +0100
Manfred Spraul <manfred@colorfullife.com> wrote:

> >+		 * we want a new context here. This eliminates TLB
> >+		 * flushes on the cpus where the process executed prior to
> >+		 * the migration.
> >+		 */
> >+		flush_tlb_mm(current->mm);
 ...
> I think flush_tlb_mm() is the wrong function - e.g. for i386, it's a 
> wasted flush, because i386 disconnects previous cpus from the tlb flush 
> automatically.
> And it's always the wrong thing if you've migrated one thread of a task 
> that runs on multiple cpus. I think you need a new hook.

Yes, you're probably right.  Just name it tlb_migrate_prepare(mm) or
something like that.

I think most if not all non-x86 platforms will define this straight
to flush_tlb_mm().
