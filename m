Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267320AbUHPB6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267320AbUHPB6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 21:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUHPB6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 21:58:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267320AbUHPB6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:58:51 -0400
Date: Sun, 15 Aug 2004 18:56:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte locks?
Message-Id: <20040815185644.24ecb247.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
	<20040815130919.44769735.davem@redhat.com>
	<Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
	<20040815165827.0c0c8844.davem@redhat.com>
	<Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 17:11:53 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> pgd/pmd walking should be possible always even without the vma semaphore
> since the CPU can potentially walk the chain at anytime.

munmap() can destroy pmd and pte tables.  somehow we have
to protect against that, and currently that is having the
VMA semaphore held for reading, see free_pgtables().

