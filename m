Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUHPAAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUHPAAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUHPAAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:00:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40352 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267276AbUHPAAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:00:32 -0400
Date: Sun, 15 Aug 2004 16:58:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte locks?
Message-Id: <20040815165827.0c0c8844.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
	<20040815130919.44769735.davem@redhat.com>
	<Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 15:58:27 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Sun, 15 Aug 2004, David S. Miller wrote:
> 
> >
> > Is the read lock in the VMA semaphore enough to let you do
> > the pgd/pmd walking without the page_table_lock?
> > I think it is, but just checking.
> 
> That would be great.... May I change the page_table lock to
> be a read write spinlock instead?

No, I means "is the read long _ON_ the VMA semaphore".
The VMA semaphore is a read/write semaphore, and we grab
it for reading in the code path you're modifying.

Please don't change page_table_lock to a rwlock, it's
only needed for write accesses.
