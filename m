Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSIJRa3>; Tue, 10 Sep 2002 13:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSIJRa3>; Tue, 10 Sep 2002 13:30:29 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:54517 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S317829AbSIJRa3>; Tue, 10 Sep 2002 13:30:29 -0400
Message-Id: <200209101746.g8AHkFJ3001210@pool-141-150-242-242.delv.east.verizon.net>
Date: Tue, 10 Sep 2002 13:46:11 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.34 ufs/super.c
References: <200209092047.g89KldtA000217@pool-141-150-242-242.delv.east.verizon.net> <Pine.LNX.4.44.0209101941370.1100-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209101941370.1100-100000@linux-box.realnet.co.sz>; from zwane@mwaikambo.name on Tue, Sep 10, 2002 at 07:43:20PM +0200
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop018.verizon.net from [141.150.242.242] using ID <vze2j9fk@verizon.net> at Tue, 10 Sep 2002 12:35:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Mon, 9 Sep 2002, Skip Ford wrote:
> 
> > I've needed this patch since 2.5.32 to successfully mount a UFS
> > partition.
> > 
> > --- linux/fs/ufs/super.c~	Mon Sep  9 16:39:52 2002
> > +++ linux/fs/ufs/super.c	Mon Sep  9 16:39:57 2002
> > @@ -605,7 +605,7 @@
> >  	}
> >  	
> >  again:	
> > -	if (sb_set_blocksize(sb, block_size)) {
> > +	if (!sb_set_blocksize(sb, block_size)) {
> >  		printk(KERN_ERR "UFS: failed to set blocksize\n");
> >  		goto failed;
> >  	}
> 
> Good heavens! I introduced that bug when fixing another bug a while ago, i 
> was pretty certain it got fixed (it got fixed in 2.4 and -dj(?))

Here's the snippet from patch-2.5.32 that did it.  This just went in a
week or two ago.

-	sb_set_blocksize(sb, block_size);
+	if (sb_set_blocksize(sb, block_size)) {
+		printk(KERN_ERR "UFS: failed to set blocksize\n");
+		goto failed;
+	}

-- 
Skip
