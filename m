Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132730AbRDDCT1>; Tue, 3 Apr 2001 22:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132733AbRDDCTS>; Tue, 3 Apr 2001 22:19:18 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11396 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132730AbRDDCTI>;
	Tue, 3 Apr 2001 22:19:08 -0400
Date: Tue, 3 Apr 2001 22:18:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac2
In-Reply-To: <E14kbMB-0000r8-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0104032216021.17127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan, please, replace the unmap_buffer() in fs/buffer.c with

static void unmap_buffer(struct buffer_head * bh)
{
        if (buffer_mapped(bh)) {
                mark_buffer_clean(bh);
                lock_buffer(bh);
                clear_bit(BH_Uptodate, &bh->b_state);
                clear_bit(BH_Mapped, &bh->b_state);
                clear_bit(BH_Req, &bh->b_state);
                clear_bit(BH_New, &bh->b_state);
                unlock_buffer(bh);
        }
}
Current tree has wait_on_buffer() instead of lock/unlock, which is racey on
SMP.

