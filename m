Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTB1LIb>; Fri, 28 Feb 2003 06:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTB1LIb>; Fri, 28 Feb 2003 06:08:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:65156 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267623AbTB1LIa>; Fri, 28 Feb 2003 06:08:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Roland Dreier <roland@topspin.com>,
       "Joe Thornber" <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH 3/8] dm: prevent possible buffer overflow in ioctl interface
Date: Thu, 27 Feb 2003 10:34:54 -0600
X-Mailer: KMail [version 1.2]
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
References: <200302262104.h1QL4aiC001941@eeyore.valparaiso.cl> <03022708365304.05199@boiler> <52y941pu6i.fsf@topspin.com>
In-Reply-To: <52y941pu6i.fsf@topspin.com>
MIME-Version: 1.0
Message-Id: <03022710345405.05199@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 February 2003 10:25, Roland Dreier wrote:
>    > +	char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1);
>    > +	if (!name) {
>    > +		return -ENOMEM;
>    > +	}
>
> Also, kmalloc() needs a second "GFP_xxx" parameter (I guess GFP_KERNEL
> in this case, although I don't know the context this function is
> called from).
>
>  - Roland

Dammit! I'm not having a good morning. :(

Unfortunately, Linus seems to have committed that patch already. So here is a 
patch to fix just that line.

Thanks for catching that.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/

--- a/drivers/md/dm-ioctl.c	2003/02/27 16:29:58
+++ b/drivers/md/dm-ioctl.c	2003/02/27 16:30:03
@@ -174,7 +174,7 @@
 static int register_with_devfs(struct hash_cell *hc)
 {
 	struct gendisk *disk = dm_disk(hc->md);
-	char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1);
+	char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1, GFP_KERNEL);
 	if (!name) {
 		return -ENOMEM;
 	}
