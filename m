Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290798AbSAYTIH>; Fri, 25 Jan 2002 14:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290802AbSAYTHu>; Fri, 25 Jan 2002 14:07:50 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:3858 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S290798AbSAYTHm>;
	Fri, 25 Jan 2002 14:07:42 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Fri, 25 Jan 2002 11:07:40 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Matt Domsch <Matt_Domsch@Dell.com>
Subject: [PATCH][RESEND] BLKGETSIZE64 (bytes not sectors)
Message-ID: <20020125110740.A31654@vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Myself and Matt and previously others (searching the archive shows Eric
Sandeen complaining for quite a while) have noticed the following bug in
blkpg.c.  You can see the most recent thread at:
	http://groups.google.com/groups?hl=en&threadm=fa.fo6abnv.1shuppi%40ifi.uio.no&rnum=5&prev=/groups%3Fhl%3Den%26q%3DBLKGETSIZE64%26btnG%3DGoogle%2BSearch%26meta%3Dgroup%253Dfa.linux.kernel

Has this patch just missed inclusion or do you have a reason to leave
it out?

Tim

----- Forwarded message from Matt Domsch <Matt_Domsch@Dell.com> -----

From:	Matt Domsch <Matt_Domsch@Dell.com>
To:	<linux-kernel@vger.kernel.org>
Subject: BLKGETSIZE64 (bytes or sectors?)
Date:	Thu, 17 Jan 2002 14:28:52 -0600 (CST)
X-Mailing-List:	linux-kernel@vger.kernel.org

Is the BLKGETSIZE64 ioctl supposed to return the size of the device in 
bytes (as the comment says, and is implemented in all places *except* 
blkpg.c), or in sectors (as is implemented in blkpg.c since 2.4.15)?

It would seem that blkpg.c gets it wrong, that it should be in bytes.  
Assuming that's the case, here's the patch to fix it against 2.4.18-pre4.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.2% (IDC Dec 2001)


--- linux-2.4.18-pre4/drivers/block/blkpg.c.orig	Thu Jan 17 14:24:24 2002
+++ linux-2.4.18-pre4/drivers/block/blkpg.c	Thu Jan 17 14:26:43 2002
@@ -247,7 +247,7 @@ int blk_ioctl(kdev_t dev, unsigned int c
 			if (cmd == BLKGETSIZE)
 				return put_user((unsigned long)ullval, (unsigned long *)arg);
 			else
-				return put_user(ullval, (u64 *)arg);
+				return put_user((u64)ullval << 9 , (u64 *)arg);
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
