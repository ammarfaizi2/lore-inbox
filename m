Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263894AbRFIWpR>; Sat, 9 Jun 2001 18:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263895AbRFIWpI>; Sat, 9 Jun 2001 18:45:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64903 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263894AbRFIWox>;
	Sat, 9 Jun 2001 18:44:53 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15138.42357.146305.892652@pizda.ninka.net>
Date: Sat, 9 Jun 2001 15:38:45 -0700 (PDT)
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Paulo Afonso Graner Fessel <pafessel@zaz.com.br>,
        linux-kernel@vger.kernel.org, hollis@austin.rr.com,
        torben.mathiasen@compaq.com
Subject: Re: Probable endianess problem in TLAN driver
In-Reply-To: <3B21F918.4090101@humboldt.co.uk>
In-Reply-To: <3B21A790.63F428CE@zaz.com.br>
	<3B21F918.4090101@humboldt.co.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian Cox writes:
 > > +#if defined(__powerpc__)
 > > +#define inw(addr)                      le32_to_cpu(inw(addr))
 > > +#define inl(addr)                      le32_to_cpu(inl(addr))
 > > +#define outw(val, addr)                outw(cpu_to_le32(val), addr)
 > > +#define outl(val, addr)                outl(cpu_to_le32(val), addr)
 > > +#endif
 > 
 > On ppc the inw, inl, outw, and outl functions already byteswap, so by 
 > adding the extra byteswap you're now passing unswapped data to the chip. 

Yes, and this is true for every architecture.

All of {in,out}{b,w,l}() and {read/write}{b,w,l}() swap to/from
bus endianness for you.

Later,
David S. Miller
davem@redhat.com
