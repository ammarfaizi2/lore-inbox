Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318220AbSHIKGb>; Fri, 9 Aug 2002 06:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSHIKGb>; Fri, 9 Aug 2002 06:06:31 -0400
Received: from smtp-in.sc5.paypal.com ([216.136.155.8]:20453 "EHLO
	smtp-in.sc5.paypal.com") by vger.kernel.org with ESMTP
	id <S318220AbSHIKGa>; Fri, 9 Aug 2002 06:06:30 -0400
Date: Fri, 9 Aug 2002 03:10:04 -0700
From: Brad Heilbrun <bheilbrun@paypal.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask_t
Message-ID: <20020809101004.GA10135@paypal.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20020808.073630.37512884.davem@redhat.com> <20020809080517.E4BE5443C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020809080517.E4BE5443C@lists.samba.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 04:04:12PM +1000, Rusty Russell wrote:
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/fs/partitions/check.c .28255-2.5.30-cpumask/fs/partitions/check.c
> --- .28255-2.5.30-cpumask.pre/fs/partitions/check.c	2002-08-02 11:15:09.000000000 +1000
> +++ .28255-2.5.30-cpumask/fs/partitions/check.c	2002-08-09 15:54:25.000000000 +1000
> @@ -467,7 +467,7 @@ void devfs_register_partitions (struct g
>  	for (part = 1; part < max_p; part++) {
>  		if ( unregister || (p[part].nr_sects < 1) ) {
>  			devfs_unregister(p[part].de);
> -			dev->part[p].de = NULL;
> +			dev->part[part].de = NULL;
>  			continue;
>  		}
>  		devfs_register_partition (dev, minor, part);


The above seems unrelated to cpumask_t. Also the current BK tree
lists the fix as:

--- a/fs/partitions/check.c	Thu Aug  1 13:38:40 2002
+++ b/fs/partitions/check.c	Sat Aug  3 10:11:58 2002
@@ -467,7 +467,7 @@
 	for (part = 1; part < max_p; part++) {
 		if ( unregister || (p[part].nr_sects < 1) ) {
 			devfs_unregister(p[part].de);
-			dev->part[p].de = NULL;
+			p[part].de = NULL;
 			continue;
 		}
 		devfs_register_partition (dev, minor, part);


-- 
Brad Heilbrun
