Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRAXRYO>; Wed, 24 Jan 2001 12:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132662AbRAXRYE>; Wed, 24 Jan 2001 12:24:04 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:14499 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132418AbRAXRXz>; Wed, 24 Jan 2001 12:23:55 -0500
Message-Id: <5.0.2.1.2.20010124170609.00a0c190@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 24 Jan 2001 17:23:49 +0000
To: Timur Tabi <ttabi@interactivesi.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: NTFS safety and lack thereof - Was: Re: Linux 2.4.0ac11
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010124170337Z129710-18594+930@vger.kernel.org>
In-Reply-To: <5.0.2.1.2.20010124162842.00a48720@pop.cus.cam.ac.uk>
 <E14LOAm-0006z0-00@the-village.bc.nu>
 <E14LOAm-0006z0-00@the-village.bc.nu>
 <01012416081105.19999@nessie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:03 24/01/01, Timur Tabi wrote:
>** Reply to message from Anton Altaparmakov <aia21@cam.ac.uk> on Wed, 24 Jan
>2001 16:54:36 +0000
>
> > >Is read access safe ?
> >
> > Of course read-only is safe. As long as you mount the partition READ-ONLY
> > nothing can happen to it in any way, your NTFS data is at least safe.
>
>Isn't it still theoretcially possible for the driver to send commands to the
>disk controller that cause data to become overwritten, even when it's just
>supposed to read that data?

Theoretically it is also possible that all quantums in my body decide to 
tunnel through space-time at exactly the same time and with the exactly 
same direction and speed vector for exactly the same duration of time and 
that I am suddenly effectively teleported to the surface of the moon. (-:

But that doesn't mean it's going to happen...

Seriously, it is a theoretical possibility but a practical impossibility in 
my opinion and to the best of my knowledge of the current driver it will 
not communicate with any hardware directly in any way. In fact it only 
performs writes by dirtying buffer cache buffers which get written back by 
the kernel proper. ll_rw_block() never gets called directly and neither 
does generic_make_request() and block_write_full_page() isn't at the moment 
either. (Anything I missed?) Also, when you compile the driver without the 
write support enabled, you are almost 100% sure even a major bug in the 
driver will not cause any writes.

And no, the driver is not a virus nor a trojan nor does it have any 
intelligence to suddenly decide to write things when it isn't asked to...

NOTE: Please don't take my comments personally / too seriously but I 
couldn't resist... Follow-ups to alt.silly.* please...

Regards,

         Anton


-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
