Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUD3VEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUD3VEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUD3VEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:04:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60128 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261262AbUD3U5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:57:31 -0400
Date: Fri, 30 Apr 2004 15:57:01 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>, linux-kernel@vger.kernel.org,
       anton@samba.org, dheger@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance changes.
Message-ID: <20040430205701.GG14271@rx8.ibm.com>
References: <20040430191539.GC14271@rx8.ibm.com> <20040430131832.45be6956.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040430131832.45be6956.akpm@osdl.org> (from akpm@osdl.org on Fri, Apr 30, 2004 at 15:18:32 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/04 15:18:32, Andrew Morton wrote:
> "Jose R. Santos" <jrsantos@austin.ibm.com> wrote:
> >
> > diff -Nru a/fs/inode.c b/fs/inode.c
> > --- a/fs/inode.c	Fri Apr 30 12:14:23 2004
> > +++ b/fs/inode.c	Fri Apr 30 12:14:23 2004
> > @@ -671,8 +671,9 @@
> >  
> >  static inline unsigned long hash(struct super_block *sb, unsigned long hashval)
> >  {
> > -	unsigned long tmp = hashval + ((unsigned long) sb / L1_CACHE_BYTES);
> > -	tmp = tmp + (tmp >> I_HASHBITS);
> > +	unsigned long tmp = (hashval + ((unsigned long) sb) ^ (GOLDEN_RATIO_PRIME + hashval)
> > +			/ L1_CACHE_BYTES);
> > +	tmp = tmp + ((tmp ^ GOLDEN_RATIO_PRIME) >> I_HASHBITS);
> >  	return tmp & I_HASHMASK;
> >  }
> >  
> 
> Are you sure about this?  It's doing:
> 
> 	tmp = hashval + sb ^ ((GOLDEN_RATIO_PRIME + hashval) / L1_CACHE_BYTES)
> 
> should it not be:
> 
> 	tmp = hashval + (sb ^ (GOLDEN_RATIO_PRIME + hashval)) / L1_CACHE_BYTES
> 
> ?

err... Wrote the patch to fast.  It should read

	tmp = (hashval * sb) ^ (GOLDEN_RATIO_PRIME + hashval) / L1_CACHE_BYTES

I screw up... I'll send a fixed patch in a while.

-JRS


