Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266882AbRGKXR0>; Wed, 11 Jul 2001 19:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbRGKXRQ>; Wed, 11 Jul 2001 19:17:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48000 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266882AbRGKXRE>;
	Wed, 11 Jul 2001 19:17:04 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15180.56942.143741.645963@pizda.ninka.net>
Date: Wed, 11 Jul 2001 16:17:02 -0700 (PDT)
To: Chris Wedgwood <cw@f00f.org>
Cc: Jes Sorensen <jes@sunsite.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Ben LaHaise <bcrl@redhat.com>,
        "\"MEHTA,HIREN (A-SanJose,ex1)\"" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
In-Reply-To: <20010712095421.A2298@weta.f00f.org>
In-Reply-To: <3B46FDF1.A38E5BB6@mandrakesoft.com>
	<E15Ir5R-0005lR-00@the-village.bc.nu>
	<15175.2003.773317.101601@pizda.ninka.net>
	<d3y9pv8ee5.fsf@lxplus015.cern.ch>
	<20010712095421.A2298@weta.f00f.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wedgwood writes:
 > What kind of packing makes a 32-bit value take 8-bytes on any
 > currently supported archicture? The worst-case I can think of is
 > 7-bytes in the case of misaligned by 3 (e.g. __attribute__((packed))
 > struct blah { char foo[3]; long bar }; sort of thing).

If you have this:

struct {
	u32	foo;
	void	*bar;
};

"bar" will be at offset 8 on a 64-bit platforms since it must be
aligned on a 64-byte boundary, so what Jes is saying is that for:

struct {
	dma_addr_t	foo;
	void		*bar;
};

the "dma_addr_t" is already consuming 8 bytes of space on 64-bit
systems.

Later,
David S. Miller
davem@redhat.com

