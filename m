Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbRB0BAt>; Mon, 26 Feb 2001 20:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRB0BAj>; Mon, 26 Feb 2001 20:00:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17824 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129374AbRB0BAX>;
	Mon, 26 Feb 2001 20:00:23 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.64299.147336.376138@pizda.ninka.net>
Date: Mon, 26 Feb 2001 16:56:11 -0800 (PST)
To: Reto Baettig <baettig@scs.ch>
Cc: mingo@elte.hu, MM Linux <linux-mm@kvack.org>,
        Kernel Linux <linux-kernel@vger.kernel.org>, Martin Frey <frey@scs.ch>
Subject: Re: RFC: vmalloc improvements
In-Reply-To: <3A9AF9E7.D0924A4C@scs.ch>
In-Reply-To: <Pine.LNX.4.30.0102240129200.5327-100000@elte.hu>
	<3A9AF9E7.D0924A4C@scs.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reto Baettig writes:
 > The RPC server needs lots of 2MB receive buffers which are
 > allocated using vmalloc because the NIC has its own pagetables.

Why not just allocate the page seperately and keep track of
where they are, since the NIC has all the page tabling facilities
on it's end, the cpu side is just a software issue.  You can keep
an array of pages how ever large you need to keep track of that.

vmalloc() was never meant to be used on this level and doing
so is asking for trouble (it's also deadly expensive on SMP due
to the cross-cpu tlb invalidates using vmalloc() causes).

Later,
David S. Miller
davem@redhat.com
