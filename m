Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbQKTPMc>; Mon, 20 Nov 2000 10:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbQKTPMW>; Mon, 20 Nov 2000 10:12:22 -0500
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:20110 "EHLO
	fw-cam.cambridge.arm.com") by vger.kernel.org with ESMTP
	id <S129165AbQKTPMD>; Mon, 20 Nov 2000 10:12:03 -0500
Message-Id: <4.3.2.7.2.20001120143746.00c58220@cam-pop.cambridge.arm.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 20 Nov 2000 14:41:07 +0000
To: Jasper Spaans <jasper@spaans.ds9a.nl>,
        Linus Torvalds <torvalds@transmeta.com>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@arm.com>
Subject: Re: [PATCH] Re: What is 2.4.0-test10: md1 has overlapping
  physical units with md2!
Cc: George Garvey <tmwg-linuxknl@inxservices.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        MOLNAR Ingo <mingo@chiara.elte.hu>
In-Reply-To: <14872.29951.707116.16506@notabene.cse.unsw.edu.au>
In-Reply-To: <message from Jasper Spaans on Sunday November 19>
 <20001119033943.C935@inxservices.com>
 <20001119140809.A21693@spaans.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I won't try and invent a patch(1) for this, but might I suggest changing:

    md: serializing resync, md%d has shares one or more physical units with 
md%d!\n

to

    md: serializing resync, md%d shares one or more disk drives with md%d. 
Array performance may suffer.\n

Regards,

Ruth

At 12:49 AM 11/20/00, you wrote:
>  the attached patch, modifies a warning message in md.c which seems to
>  often cause confusion - the following email includes one example
>  there-of (there have been others over the months).
> > What it means is that some partititions in md1 and md2 are on the same 
> disk,
> > and that the md-code will not do the reconstruction of these arrays in
> > parallel [of course, for performance reasons].
> >
>
>
>--- ./drivers/md/md.c   2000/11/20 00:33:08     1.2
>+++ ./drivers/md/md.c   2000/11/20 00:44:19     1.3
>@@ -3279,7 +3279,7 @@
>                 if (mddev2 == mddev)
>                         continue;
>                 if (mddev2->curr_resync && match_mddev_units(mddev,mddev2)) {
>-                       printk(KERN_INFO "md: serializing resync, md%d has 
>overlapping physical units with md%d!\n", mdidx(mddev), mdidx(mddev2));
>+                       printk(KERN_INFO "md: serializing resync, md%d has 
>shares one or more physical units with md%d!\n", mdidx(mddev), mdidx(mddev2));
>                         serialize = 1;
>                         break;
>                 }
>-



-- 

Ruth 
Ivimey-Cook                       ruthc@sharra.demon.co.uk
Technical 
Author, ARM Ltd              ruth.ivimey-cook@arm.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
