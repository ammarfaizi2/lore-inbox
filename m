Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVEGADP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVEGADP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 20:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVEGADP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 20:03:15 -0400
Received: from mail.dif.dk ([193.138.115.101]:51666 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261313AbVEGAC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 20:02:56 -0400
Date: Sat, 7 May 2005 02:06:39 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Dave Jones <davej@redhat.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Ken Pizzini <ken@halcyon.com>, Ron Jeppesen <ronj.an@site007.saic.com>,
       Corey Minyard <minyard@wf-rch.cirr.com>, akpm@osdl.org
Subject: Re: [PATCH] remove pointless NULL check before kfree in sony535.c
In-Reply-To: <20050506235722.GB825@redhat.com>
Message-ID: <Pine.LNX.4.62.0505070205180.2384@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505070114160.2384@dragon.hyggekrogen.localhost>
 <20050506235722.GB825@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2005, Dave Jones wrote:

> On Sat, May 07, 2005 at 01:19:01AM +0200, Jesper Juhl wrote:
>  > --- linux-2.6.12-rc3-mm3-orig/drivers/cdrom/sonycd535.c	2005-03-02 08:38:37.000000000 +0100
>  > +++ linux-2.6.12-rc3-mm3/drivers/cdrom/sonycd535.c	2005-05-07 01:13:30.000000000 +0200
>  > @@ -1605,7 +1605,6 @@ out7:
>  >  	put_disk(cdu_disk);
>  >  out6:
>  >  	for (i = 0; i < sony_buffer_sectors; i++)
>  > -		if (sony_buffer[i]) 
>  >  			kfree(sony_buffer[i]);
>  >  out5:
> 
> This breaks the indentation.
> 

Right you are. Sorry about that. Fixed patch below.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc3-mm3-orig/drivers/cdrom/sonycd535.c	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/cdrom/sonycd535.c	2005-05-07 02:04:45.000000000 +0200
@@ -1605,8 +1605,7 @@ out7:
 	put_disk(cdu_disk);
 out6:
 	for (i = 0; i < sony_buffer_sectors; i++)
-		if (sony_buffer[i]) 
-			kfree(sony_buffer[i]);
+		kfree(sony_buffer[i]);
 out5:
 	kfree(sony_buffer);
 out4:



