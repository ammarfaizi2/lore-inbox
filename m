Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263859AbRFDKHV>; Mon, 4 Jun 2001 06:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264167AbRFDJfV>; Mon, 4 Jun 2001 05:35:21 -0400
Received: from colorfullife.com ([216.156.138.34]:47117 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S264166AbRFDJfQ>;
	Mon, 4 Jun 2001 05:35:16 -0400
Message-ID: <3B1B564E.D83A741A@colorfullife.com>
Date: Mon, 04 Jun 2001 11:35:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: multicast hash incorrect on big endian archs
In-Reply-To: <3B1A9558.2DBAECE7@colorfullife.com> <15130.61778.471925.245018@pizda.ninka.net> <3B1B3268.2A02D2C@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> "David S. Miller" wrote:
> >
> > Many big-endian systems already need to provide little-endian bitops,
> > for ext2's sake for example.
> >
> > We should formalize this, with {set,clear,change,test}_le_bit which
> > technically every port has implemented in some for or another already.
> >

That could cause alignment problems.
<<< from starfire.c
{
     long filter_addr;
     u16 mc_filter[32] __attribute__ ((aligned(sizeof(long)))); 
<<<
set_bit requires word alignment, but without the __attibute__ the
compiler would only guarantee 16-bit alignment. IMHO ugly.

Should I add __set_bit_{8,16,32} into <linux/bitops.h>, overridable with
__HAVE_ARCH_SET_BIT_n?

Default implementation for the nonatomic __set_bit could be added into
<linux/bitops.h>, too.

Btw, the correct name would be __set_bit_n: the function don't guarantee
atomicity.

--
	Manfred
