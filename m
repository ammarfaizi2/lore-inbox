Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263926AbRFEJGJ>; Tue, 5 Jun 2001 05:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263929AbRFEJF7>; Tue, 5 Jun 2001 05:05:59 -0400
Received: from t2.redhat.com ([199.183.24.243]:44785 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263926AbRFEJFn>; Tue, 5 Jun 2001 05:05:43 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15132.40298.80954.434805@pizda.ninka.net> 
In-Reply-To: <15132.40298.80954.434805@pizda.ninka.net>  <15132.22933.859130.119059@pizda.ninka.net> <13942.991696607@redhat.com> <3B1C1872.8D8F1529@mandrakesoft.com> <15132.15829.322534.88410@pizda.ninka.net> <20010605155550.C22741@metastasis.f00f.org> <25587.991730769@redhat.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        bjornw@axis.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Jun 2001 10:05:35 +0100
Message-ID: <25831.991731935@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>  One way to do this, (even portably :-) is via displacement flushes.
> Linus mentioned this.

> Basically if you know the L2 cache size and the assosciativity you can
> do this as long as you can get a "2 * L2 cache size * assosciativity"
> piece of contiguous physical memory.  When you need this "simon says"
> flush, you basically read this physical memory span and this will
> guarentee that all dirty data has exited the L2 cache. 

Fine. So it should be possible to do it on all architectures with 
physically-indexed caches - that's good. Architectures with 
virtually-indexed caches are going to have explicit cache management 
functionality anyway, presumably :)

Obviously the algorithm you describe should not be implemented in
arch-independent drivers. It should be in include/asm-*, for those
architectures which _can't_ do it with a single cache management instruction
(or loop of same).

What shall we call this function? The intuitive "flush_dcache_range" appears
to have already been taken.

--
dwmw2


