Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSHMR32>; Tue, 13 Aug 2002 13:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSHMR32>; Tue, 13 Aug 2002 13:29:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318282AbSHMR2Z>; Tue, 13 Aug 2002 13:28:25 -0400
Date: Tue, 13 Aug 2002 10:34:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 2/21] reduced locking in buffer.c
In-Reply-To: <3D561473.40A53C0D@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208131032210.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Aug 2002, Andrew Morton wrote:
> 
> Resend.  Replace the buffer lru spinlock protection with
> local_irq_disable and a cross-CPU call to invalidate them.

This almost certainly breaks on sparc, where CPU cross-calls are 
non-maskable, so local_irq_disable doesn't do anything for them.

Talk to Davem about this - there may be some workaround.

		Linus

