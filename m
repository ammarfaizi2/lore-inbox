Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132032AbRCVOkK>; Thu, 22 Mar 2001 09:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132033AbRCVOkA>; Thu, 22 Mar 2001 09:40:00 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:61893 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S132032AbRCVOjt>; Thu, 22 Mar 2001 09:39:49 -0500
Message-ID: <3ABA0E89.D3D965B7@inet.com>
Date: Thu, 22 Mar 2001 08:39:05 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <200103220638.HAA16050@green.mif.pg.gda.pl> <3ABA00BB.A9C2DF1B@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> hmm, on second thought, I think I would prefer the attached patch
> (compiled but not tested).
> 
> Hardware usually returns all 1's when it's not present, or not working,
> so think checking for addresses filled with 1's is a good idea too.
> 
> I also took the patch from alan's tree and made the memcmp against
> six-byte 'zaddr' rather than a seven-byte string :)

Jeff,

The "!(addr[0]&1)" part of the test already catches the ff's case, so
that is redundant.
Using 6 bytes instead of 7 is an improvement.

Eli


> Index: include/linux/etherdevice.h
> ===================================================================
> RCS file: /cvsroot/gkernel/linux_2_4/include/linux/etherdevice.h,v
> retrieving revision 1.1.1.14.4.2
> diff -u -r1.1.1.14.4.2 etherdevice.h
> --- include/linux/etherdevice.h 2001/03/21 14:10:50     1.1.1.14.4.2
> +++ include/linux/etherdevice.h 2001/03/22 13:37:15
> @@ -46,6 +46,25 @@
>         memcpy (dest->data, src, len);
>  }
> 
> +/**
> + * is_valid_ether_addr - Determine if the given Ethernet address is valid
> + * @addr: Pointer to a six-byte array containing the Ethernet address
> + *
> + * Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
> + * a multicast address, and is not FF:FF:FF:FF:FF:FF.
> + *
> + * Return true if the address is valid.
> + */
> +static inline int is_valid_ether_addr( u8 *addr )
> +{
> +       const char zaddr[6] = {0,};
> +       const char faddr[6] = {0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};
> +
> +       return !(addr[0]&1) &&
> +              memcmp( addr, zaddr, 6) &&
> +              memcmp( addr, faddr, 6);
> +}
> +
>  #endif
> 
>  #endif /* _LINUX_ETHERDEVICE_H */

-- 
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
