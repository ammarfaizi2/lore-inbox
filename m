Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288284AbSBDDs2>; Sun, 3 Feb 2002 22:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287478AbSBDDsT>; Sun, 3 Feb 2002 22:48:19 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:52998 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S287467AbSBDDsO>; Sun, 3 Feb 2002 22:48:14 -0500
Date: Sun, 3 Feb 2002 20:47:59 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Symbol troubles in 2.4.18pre... kernels
Message-ID: <20020203204759.A14119@mail.harddata.com>
In-Reply-To: <20020203171615.A12981@mail.harddata.com> <E16XXIq-0005ml-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16XXIq-0005ml-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 04, 2002 at 12:48:12AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 12:48:12AM +0000, Alan Cox wrote:
> 
> > 'isa_eth_io_copy_and_sum' is defined only for some architectures but
> > assorted modules, like drivers/net/3c503.o and few others, can be
> > configured, say, for Alpha and 'depmod' once again complains about
> > unresolved symbols.  I do not think that anybody will really miss that
> > on Alpha but maybe configuring them in should be disallowed?
> 
> This is a bug in the Alpha port. Fix the port. Its not ecactly the
> most complex function to implement.

Well, the best I can tell by looking at other implementations and
comparing there is not much to implement and the fix looks like
that:

--- linux-2.4.18p7/include/asm-alpha/io.h~	Sun Feb  3 16:42:17 2002
+++ linux-2.4.18p7/include/asm-alpha/io.h	Sun Feb  3 20:35:13 2002
@@ -432,6 +432,8 @@
 #define eth_io_copy_and_sum(skb,src,len,unused) \
   memcpy_fromio((skb)->data,(src),(len))
 
+#define isa_eth_io_copy_and_sum(a,b,c,d) eth_copy_and_sum((a),(b),(c),(d))
+
 static inline int
 check_signature(unsigned long io_addr, const unsigned char *signature,
 		int length)

But I really have no way to test that on a real, live, hardware.
It compiles. :-)

  Michal
