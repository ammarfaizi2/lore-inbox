Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130867AbQK1VJW>; Tue, 28 Nov 2000 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130866AbQK1VJD>; Tue, 28 Nov 2000 16:09:03 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:44795 "EHLO
        vaio.greennet") by vger.kernel.org with ESMTP id <S130299AbQK1VI4>;
        Tue, 28 Nov 2000 16:08:56 -0500
Date: Tue, 28 Nov 2000 15:41:10 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Eli Carter <eli.carter@inet.com>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] lance.c - dev_kfree_skb() then reference skb->len
In-Reply-To: <3A23F490.69688B84@inet.com>
Message-ID: <Pine.LNX.4.10.10011281534540.862-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Eli Carter wrote:

> Patch is against 2.2.17, drivers/net/lance.c.
> I believe this to be "obviously correct," but please correct me if I'm
> wrong.
> This moves a reference to skb->len to before the possible
> dev_kfree_skb(skb) call.  Though it appears to work as is, I suspect it
> is incorrect.

This patch looks reasonable.

Perhaps it would be better to have the driver retain the skbuff until the
transmit succeeds, and only then add the length to the stats.  But this
specific bug is related the ISA bounce buffer code.  Any ISA card is in
the "legacy" category, so it's better to make minimal change needed to
correct the obvious potential problem.



Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
