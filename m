Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQKTRxJ>; Mon, 20 Nov 2000 12:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbQKTRxA>; Mon, 20 Nov 2000 12:53:00 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:41684 "EHLO
	mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S129379AbQKTRwx>; Mon, 20 Nov 2000 12:52:53 -0500
Date: Mon, 20 Nov 2000 17:15:40 +0000
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: [PATCH] Re: What is 2.4.0-test10: md1 has overlapping physical
 unitswith md2!
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Jasper Spaans <jasper@spaans.ds9a.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        George Garvey <tmwg-linuxknl@inxservices.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Message-id: <3A195C3C.6539D0CE@Mutz.com>
Organization: University of Bielefeld - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17i10-0001 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <20001119033943.C935@inxservices.com>
 <20001119140809.A21693@spaans.ds9a.nl>
 <14872.29951.707116.16506@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> Linus, Ingo:
> 
>  the attached patch, modifies a warning message in md.c which seems to
>  often cause confusion - the following email includes one example
>  there-of (there have been others over the months).
> 
>  Hopefully the new text is clearer.
> 
>  (patch against 2.4.0-test11-pre7)
> 
There is a 'has' left in the text of the corrected line.

> NeilBrown
> 
This patch will has it fixed:

Marc

--- ./drivers/md/md.c   2000/11/20 00:33:08     1.2
+++ ./drivers/md/md.c   2000/11/20 00:44:19     1.3
@@ -3279,7 +3279,7 @@
                if (mddev2 == mddev)
                        continue;
                if (mddev2->curr_resync && match_mddev_units(mddev,mddev2)) {
-                       printk(KERN_INFO "md: serializing resync, md%d has overlapping physical units with md%d!\n", mdidx(mddev), mdidx(mddev2));
+                       printk(KERN_INFO "md: serializing resync, md%d shares one or more physical units with md%d!\n", mdidx(mddev), mdidx(mddev2));
                        serialize = 1;
                        break;
                }


-- 
Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
University of Bielefeld, Dep. of Mathematics / Dep. of Physics

PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
