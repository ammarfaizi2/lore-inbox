Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264319AbRFOKIk>; Fri, 15 Jun 2001 06:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264320AbRFOKIa>; Fri, 15 Jun 2001 06:08:30 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:55052 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S264319AbRFOKIN>;
	Fri, 15 Jun 2001 06:08:13 -0400
Date: Fri, 15 Jun 2001 11:07:56 +0100 (IST)
From: Stephen Shirley <diamond@skynet.ie>
X-X-Sender: <diamond@skynet>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Some error checking on kmalloc()'s in ide-probe.c
In-Reply-To: <E15AakR-0004xE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.32.0106151100120.15645-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, Alan Cox wrote:

> These are already fixed in the -ac tree
>
> Please people - check the -ac tree before wasting time on these
>

Hmm - I did indeed forget to check the -ac tree, I have done so now, and
there is no difference between the vanilla kernel and the -ac one in
those places that i can see. The second fix is not needed after closer
inspection (mea culpa), but the first is still valid AFAICS.

Steve
Ps. Apologise if I've fumbled it again.


--- ide-probe.c.orig    Thu Jun 14 14:05:31 2001
+++ ide-probe.c Fri Jun 15 11:03:17 2001
@@ -58,6 +58,11 @@
        struct hd_driveid *id;

        id = drive->id = kmalloc (SECTOR_WORDS*4, GFP_ATOMIC);  /* called with interrupts disabled! */
+       if(id == NULL)
+       {
+               printk(KERN_ERR "ide-probe: Failed to allocate memory for hd_driveid struct, aborting\n");
+               return;
+       }
        ide_input_data(drive, id, SECTOR_WORDS);                /* read 512 bytes of id info */
        ide__sti();     /* local CPU only */
        ide_fix_driveid(id);


-- 
"My mom had Windows at work and it hurt her eyes real bad"

