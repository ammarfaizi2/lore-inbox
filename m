Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271600AbRIGHin>; Fri, 7 Sep 2001 03:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271598AbRIGHid>; Fri, 7 Sep 2001 03:38:33 -0400
Received: from [195.211.46.202] ([195.211.46.202]:15222 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S271607AbRIGHiY>;
	Fri, 7 Sep 2001 03:38:24 -0400
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Fri, 7 Sep 2001 08:51:18 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dagb@fast.no>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Irda-List <linux-irda@pasta.cs.UiT.No>
Subject: [PATCH] Re: [CHECKER] security errors for 2.4.9 and 2.4.9-ac7
In-Reply-To: <Pine.GSO.4.31.0109041405210.15852-100000@saga18.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0109070843340.2937-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, Alan, Dag, LKML, IrDA!

Please apply, the patch was sent to Dag and Jean, Jean gave his OK, Dag
didn't reply. The patch is obvious correct.

--- linux-2.4.7/net/irda/af_irda.c~	Thu Jul 12 14:21:06 2001
+++ linux-2.4.7/net/irda/af_irda.c	Sat Jul 14 12:36:07 2001
@@ -2035,7 +2035,7 @@
 	if (get_user(len, optlen))
 		return -EFAULT;

-	if(optlen < 0)
+	if(len < 0)
 		return -EINVAL;

 	switch (optname) {



On Tue, 4 Sep 2001, Kenneth Michael Ashcraft wrote:

> I've extended the security checker (makes sure that user lengths are
> bounds checked) quite a bit since my last report on July 13.  The checker
> makes sure that bounds checks are present before a user length is:
...
> 1	|	/home/kash/linux/2.4.9/net/irda/af_irda.c/
...
> ---------------------------------------------------------
> [BUG] looks like it
> /home/kash/linux/2.4.9/net/irda/af_irda.c:2064:irda_getsockopt: ERROR:RANGE:2063:2064: Using user length "(null)" as argument to "copy_to_user" [type=LOCAL] [state = tainted] set by 'get_user':2064 [linkages -> 2063:len:start] [distance=3]
> 			sizeof(struct irda_device_info);
>
> 		/* Copy the list itself */
> 		total = offset + (list.len * sizeof(struct irda_device_info));
> 		if (total > len)
> Start --->
> 			total = len;
> Error --->
> 		if (copy_to_user(optval+offset, discoveries, total - offset))
> 			err = -EFAULT;
>
> 		/* Write total number of bytes used back to client */
> ---------------------------------------------------------

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

