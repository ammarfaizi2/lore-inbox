Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbRCVPMK>; Thu, 22 Mar 2001 10:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132055AbRCVPLw>; Thu, 22 Mar 2001 10:11:52 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:51912 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S132054AbRCVPL3>; Thu, 22 Mar 2001 10:11:29 -0500
Message-ID: <3ABA15F7.6155F0EE@inet.com>
Date: Thu, 22 Mar 2001 09:10:47 -0600
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
In-Reply-To: <200103220638.HAA16050@green.mif.pg.gda.pl> <3ABA00BB.A9C2DF1B@mandrakesoft.com> <3ABA0E89.D3D965B7@inet.com> <3ABA103A.CB07012D@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Eli Carter wrote:
> > The "!(addr[0]&1)" part of the test already catches the ff's case, so
> > that is redundant.
> > Using 6 bytes instead of 7 is an improvement.
> 
> oops.  Thanks, updated patch attached.  My patch also adds inline source
> docs, and uses 'static inline' instead of 'static __inline__', two small
> style improvements.

Mmmm.... documentation.  Yummy.  ;)

When I submitted the original patch, someone wanted to add the ff's
check as well... to reduce the number of people who make that
suggestion, perhaps the comment should read:

+ * Check that the Ethernet address (MAC) is not a multicast address or 
+ * FF:FF:FF:FF:FF:FF (by checking addr[0]&1) and is not
00:00:00:00:00:00.
+ *

Does that make it clear that both cases are covered by the one test?

Hmm... I used __inline__ because the other function in the same
headerfile used it...  What is the difference between the two, and is
one depricated now?  (And what about in 2.2.x?)

Eli

>   ------------------------------------------------------------------------
> Index: include/linux/etherdevice.h
> ===================================================================
> RCS file: /cvsroot/gkernel/linux_2_4/include/linux/etherdevice.h,v
> retrieving revision 1.1.1.14.4.2
> diff -u -r1.1.1.14.4.2 etherdevice.h
> --- include/linux/etherdevice.h 2001/03/21 14:10:50     1.1.1.14.4.2
> +++ include/linux/etherdevice.h 2001/03/22 14:44:51
> @@ -46,6 +46,22 @@
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
> +
> +       return !(addr[0]&1) && memcmp( addr, zaddr, 6);
> +}
> +
>  #endif
> 
>  #endif /* _LINUX_ETHERDEVICE_H */
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
