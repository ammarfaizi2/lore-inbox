Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267688AbTBYT5M>; Tue, 25 Feb 2003 14:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267845AbTBYT5M>; Tue, 25 Feb 2003 14:57:12 -0500
Received: from teranet244-12-200.monarch.net ([24.244.12.200]:28173 "EHLO
	teranet244-12-200.monarch.net") by vger.kernel.org with ESMTP
	id <S267688AbTBYT5L>; Tue, 25 Feb 2003 14:57:11 -0500
Date: Tue, 25 Feb 2003 13:06:51 -0700
From: Peter Braam <braam@clusterfs.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       david+cert@blue-labs.org, chyang@clusterfs.com
Subject: Re: [OOPS] 2.5.62, bootup, do_add_mount
Message-ID: <20030225200651.GK18243@peter.cfs>
References: <3E5700EA.9070905@blue-labs.org> <20030225080350.GD1109@in.ibm.com> <20030225000448.6f5e0d22.akpm@digeo.com> <20030225094711.GE1109@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225094711.GE1109@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This looks good to me. Chen Yang, can you make sure this makes it into
our CVS also? 

- Peter -

On Tue, Feb 25, 2003 at 03:17:11PM +0530, Maneesh Soni wrote:
> On Tue, Feb 25, 2003 at 12:04:48AM -0800, Andrew Morton wrote:
> > Maneesh Soni <maneesh@in.ibm.com> wrote:
> > >
> > > 
> > > Hi Peter,
> > > 
> > > presto_get_sb() is returning error resulting in the following NULL 
> > > pointer reference in do_kern_mount(). The following patch corrects
> > > it.
> > > 
> > 
> > It should be returning some ERR_PTR value.  Seems that presto_get_sb() isn't
> > very careful in tracking the reason for the failed mount, so
> > 
> > 	return ERR_PTR(-EINVAL);
> > 
> > should suffice.
> 
> Actually previous fix I posted is not correct also. Returning -EINVAL seems
> logical.
> 
> 
> diff -urN linux-2.5.63-base/fs/intermezzo/super.c linux-2.5.63-presto_get_sb/fs/intermezzo/super.c
> --- linux-2.5.63-base/fs/intermezzo/super.c	2003-02-25 00:36:01.000000000 +0530
> +++ linux-2.5.63-presto_get_sb/fs/intermezzo/super.c	2003-02-25 15:14:09.000000000 +0530
> @@ -318,7 +318,7 @@
>  
>          CDEBUG(D_MALLOC, "mount error exit: kmem %ld, vmem %ld\n",
>                 presto_kmemory, presto_vmemory);
> -        return NULL;
> +        return ERR_PTR(-EINVAL);
>  }
>  
>  
> Regards,
> Maneesh
> 
> -- 
> Maneesh Soni
> IBM Linux Technology Center, 
> IBM India Software Lab, Bangalore.
> Phone: +91-80-5044999 email: maneesh@in.ibm.com
> http://lse.sourceforge.net/
- Peter -
