Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKBUgt>; Thu, 2 Nov 2000 15:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKBUgj>; Thu, 2 Nov 2000 15:36:39 -0500
Received: from gauss.dmf.bs.unicatt.it ([193.205.41.243]:45574 "EHLO
	gauss.dmf.bs.unicatt.it") by vger.kernel.org with ESMTP
	id <S129061AbQKBUgZ>; Thu, 2 Nov 2000 15:36:25 -0500
Date: Thu, 2 Nov 2000 21:36:14 +0100
From: Luca Giuzzi <giuzzi@dmf.bs.unicatt.it>
Message-Id: <200011022036.eA2KaEg15907@gauss.dmf.bs.unicatt.it>
To: linux-kernel@vger.kernel.org, mallen@byte-me.org
Subject: Re: test 10 breaks on alpha
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The clock on some alpha systems might be at 1200 Hz...
you've rather to use HZ:

   --- /usr/src/linux/include/asm-alpha/param.h.orig Wed Nov 1 12:31:56
   2000
   +++ /usr/src/linux/include/asm-alpha/param.h Wed Nov 1 12:33:22 2000
   @@ -27,4 +27,8 @@

    #define MAXHOSTNAMELEN 64 /* max length of hostname */

   +#ifdef __KERNEL__
   +# define CLOCKS_PER_SEC HZ
   +#endif
   +
    #endif /* _ASM_ALPHA_PARAM_H */


and, yes... this patch works, at least on a 500au I've got
 2.4.0t10 running on.
[BTW: the 500au is a Miata, hence the frequency is 1024 Hz]

Cheers,
 lg

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
