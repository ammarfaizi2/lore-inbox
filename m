Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbUBYHDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbUBYHDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:03:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54422 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262643AbUBYHDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:03:49 -0500
Date: Tue, 24 Feb 2004 23:03:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dsw@gelato.unsw.edu.au, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory
 exceeds 2.5GB (correction)
Message-Id: <20040224230318.19a0e6b9.davem@redhat.com>
In-Reply-To: <403C3F04.20601@colorfullife.com>
References: <403AF155.1080305@colorfullife.com>
	<20040223225659.4c58c880.akpm@osdl.org>
	<403B8C78.2020606@colorfullife.com>
	<20040225005804.GE18070@cse.unsw.EDU.AU>
	<403C3F04.20601@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004 07:21:56 +0100
Manfred Spraul <manfred@colorfullife.com> wrote:

> 0x620 (1568) is behind the end of the actual eth frame. Who could modify 
> that?

At the end of the SKB data area is where we keep struct skb_shared_info, something
is messing with the SKB state after a free it appears.

And since it's turning the debugging value 0x6b to 0x6a it must be the
"atomic_t dataref;" that is being mucked with.
