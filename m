Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUHSOu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUHSOu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUHSOud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:50:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266344AbUHSOqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:46:44 -0400
Date: Thu, 19 Aug 2004 07:42:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, viro@parcelfarce.linux.theplanet.co.uk,
       olof@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Alignment of bitmaps for ext2_set_bit et al.
Message-Id: <20040819074255.00e27060.davem@redhat.com>
In-Reply-To: <20040819042234.75020cbc.akpm@osdl.org>
References: <16676.35837.215958.814591@cargo.ozlabs.ibm.com>
	<20040819042234.75020cbc.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004 04:22:34 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Paul Mackerras <paulus@samba.org> wrote:
> >
> > What can we assume about the alignment of the bitmap pointer passed to
> > the ext2_{set,clear}_bit_atomic functions?  Can we assume that they
> > will be aligned to an long boundary (8 bytes on 64-bit)?
> 
> For ext2 and ext3 it's safe to assume that they are 1024-byte aligned.
> 
> But it's possible that other filesystems are using these (awfully named)
> functions.

FWIW, I've been using 4-byte word atomics for those routines
on sparc64 and have never gotten an unaligned trap for it yet.
