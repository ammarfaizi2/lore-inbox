Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263928AbRFEIvQ>; Tue, 5 Jun 2001 04:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRFEIvG>; Tue, 5 Jun 2001 04:51:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57760 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263924AbRFEIu6>;
	Tue, 5 Jun 2001 04:50:58 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.40298.80954.434805@pizda.ninka.net>
Date: Tue, 5 Jun 2001 01:50:50 -0700 (PDT)
To: David Woodhouse <dwmw2@infradead.org>
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        bjornw@axis.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush. 
In-Reply-To: <25587.991730769@redhat.com>
In-Reply-To: <15132.22933.859130.119059@pizda.ninka.net>
	<13942.991696607@redhat.com>
	<3B1C1872.8D8F1529@mandrakesoft.com>
	<15132.15829.322534.88410@pizda.ninka.net>
	<20010605155550.C22741@metastasis.f00f.org>
	<25587.991730769@redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Woodhouse writes:
 > What I want is a function like simon_says_flush_page_to_ram(). In
 > this case, I _do_ know better than the CPU. It is _not_ coherent
 > with these devices.

One way to do this, (even portably :-) is via displacement flushes.
Linus mentioned this.

Basically if you know the L2 cache size and the assosciativity you can
do this as long as you can get a "2 * L2 cache size * assosciativity"
piece of contiguous physical memory.  When you need this "simon says"
flush, you basically read this physical memory span and this will
guarentee that all dirty data has exited the L2 cache.

Later,
David S. Miller
davem@redhat.com
