Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279614AbRJ2XYk>; Mon, 29 Oct 2001 18:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279615AbRJ2XYc>; Mon, 29 Oct 2001 18:24:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10245 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279614AbRJ2XYT>; Mon, 29 Oct 2001 18:24:19 -0500
Date: Mon, 29 Oct 2001 15:22:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011029.151422.102554141.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0110291520260.16656-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, David S. Miller wrote:
>    Date: Mon, 29 Oct 2001 18:08:37 -0500
>
>    is completely bogus.  Without the tlb flush, the system may never update
>    the accessed bit on a page that is heavily being used.
>
> It's intentional Ben, think about the high cost of the SMP invalidate
> when kswapd is just scanning page tables.

Indeed. I thought it shouldn't mater, but apparently it does..

Does it make the accessed bit less reliable? Sure it does. But basically,
either the page is accessed SO much that it stays in the TLB all the time
(which is basically not really possible if you page heavily, I suspect),
or it will age out of the TLB on its own at which point we get the
accessed bit back.

In the worst case it does generate more noise in the reference bit logic,
but ..

		Linus

