Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129391AbQK0Imy>; Mon, 27 Nov 2000 03:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129793AbQK0Imp>; Mon, 27 Nov 2000 03:42:45 -0500
Received: from colombina.comedia.it ([213.246.1.10]:24596 "HELO
        colombina.comedia.it") by vger.kernel.org with SMTP
        id <S129391AbQK0Imc>; Mon, 27 Nov 2000 03:42:32 -0500
Date: Mon, 27 Nov 2000 09:12:28 +0100
From: Luca Berra <bluca@comedia.it>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [BUG] 2.4.0-test11-ac3 breaks raid autodetect (was Re: [BUG] raid5 link error? (was [PATCH] raid5 fix after xor.c cleanup))
Message-ID: <20001127091228.A17537@colombina.comedia.it>
Reply-To: bluca@comedia.it
Mail-Followup-To: Luca Berra <bluca@comedia.it>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
In-Reply-To: <20001117234144.A14461@spaans.ds9a.nl> <20001118123536.A5674@spaans.ds9a.nl> <20001118235352.D2226@spaans.ds9a.nl> <14872.29479.901021.472890@notabene.cse.unsw.edu.au> <3A2074CC.8219AB99@fl.priv.at> <14881.50316.705469.752219@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14881.50316.705469.752219@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Mon, Nov 27, 2000 at 01:18:52PM +1100
X-Operating-System: Linux colombina.comedia.it 2.0.36 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 01:18:52PM +1100, Neil Brown wrote:
> > Sorry to tell you that I just tried linux-2.4.0-test11-ac3 (which has this
> > patch) and I couldn't boot because the kernel detects the raid1 devices
> > but kicks the shortly after. I had to back out this code.
> 
> Thanks for this....
> 
> I have looked more deeply, and discovered the error of my ways.
also test11-ac4 contains the following patch which is broken and should
be reversed! (if xor.o is built as a module it will export the symbol
calibrate_xor_block_R??????? and require calibrate_xor_block ?!?)
anyway the only piece of code that uses calibrate_xor_block is
drivers/md/xor.c itself, so why export?

Regards,
L.

--- drivers/md/xor.c    Sun Nov 26 21:35:14 2000
+++ drivers/md/xor.c.ac4.foo    Sun Nov 26 21:43:52 2000
@@ -98,7 +98,7 @@
               speed / 1000, speed % 1000);
 }

-static int
+int
 calibrate_xor_block(void)
 {
        void *b1, *b2;
@@ -139,5 +139,6 @@
 }

 MD_EXPORT_SYMBOL(xor_block);
+MD_EXPORT_SYMBOL(calibrate_xor_block);

 module_init(calibrate_xor_block);


-- 
Luca Berra -- bluca@comedia.it
    Communication Media & Services S.r.l.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
