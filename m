Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVD1TDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVD1TDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVD1TDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:03:05 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:55947
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262227AbVD1TDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:03:03 -0400
Date: Thu, 28 Apr 2005 11:53:44 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: James.Bottomley@SteelEye.com, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
Message-Id: <20050428115344.4e10a7f4.davem@davemloft.net>
In-Reply-To: <20050428185956.GD16545@kvack.org>
References: <20050428182926.GC16545@kvack.org>
	<1114714089.5022.3.camel@mulgrave>
	<20050428185956.GD16545@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 14:59:56 -0400
Benjamin LaHaise <bcrl@kvack.org> wrote:

> On Thu, Apr 28, 2005 at 11:48:09AM -0700, James Bottomley wrote:
> > Could you come up with a less monolithic way to share this so that we
> > can still do a spinlock semaphore implementation instead of an atomic op
> > based one?
> 
> As I read the code, it doesn't make a difference: parisc will take a 
> spin lock within the atomic operation and then release it, which makes 
> the old fast path for the semaphores and the new fast path pretty much 
> equivalent (they both take and release one spinlock).

I think parisc should be allowed to choose their implementation of
semaphores.  Look, if you change semaphores in some way it will
be their problem to keep their parisc version in sync.

Or you could provide both a spinlocked and an atomic op based implementation
of generic semaphores, as we do for rwsem already.
