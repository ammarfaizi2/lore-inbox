Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUHSBUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUHSBUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 21:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUHSBUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 21:20:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10371 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267808AbUHSBUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 21:20:35 -0400
Date: Wed, 18 Aug 2004 18:19:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Hugh Dickins <hugh@veritas.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for
 8,32 and    512 cpu SMP
In-Reply-To: <Pine.LNX.4.44.0408181807500.15027-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408181816330.8185@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0408181807500.15027-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - One could avoid pte locking by introducing a pte_cmpxchg. cmpxchg
> > seems to be supported by all ia64 and i386 cpus except the original 80386.
>
> I do think this will be a more fruitful direction than pte locking:
> just looking through the arches for spare bits puts me off pte locking.

Thanks for the support. Got a V3 here (not ready to post yet) that throws
out the locks and uses cmpxchg instead. It also removes the use of
page_table_lock completely from handle_mm_fault.
