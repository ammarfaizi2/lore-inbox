Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTEQMYD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 08:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTEQMYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 08:24:03 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:20144 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261428AbTEQMYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 08:24:02 -0400
Subject: Re: 2.5.69-mm6: pccard oops while booting: round 2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: c-d.hailfinger.kernel.2003@gmx.net, rmk@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <20030517043946.421c8f4a.akpm@digeo.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>
	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>
	 <20030516132908.62e54266.akpm@digeo.com>
	 <1053121346.569.1.camel@teapot.felipe-alfaro.com>
	 <3EC56173.1000306@gmx.net>
	 <1053166275.586.9.camel@teapot.felipe-alfaro.com>
	 <20030517031840.486683fc.akpm@digeo.com>
	 <1053169552.613.1.camel@teapot.felipe-alfaro.com>
	 <20030517043946.421c8f4a.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1053174997.695.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 17 May 2003 14:36:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-17 at 13:39, Andrew Morton wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > Unable to handle kernel paging request at virtual address fceec0d7
> >  printing eip:
> > c016954f
> > *pde = 00000000
> > Oops: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[<c016954f>]     Not tainted VLI
> > EFLAGS: 00010246
> > EIP is at sys_create_link+0xcf/0x130
> 
> bah.   That's totally different :(
> 
> But there seems to be a bug in there.
> 
> --- 25/fs/sysfs/symlink.c~sysfs_create_link-fix	2003-05-17 04:34:50.000000000 -0700
> +++ 25-akpm/fs/sysfs/symlink.c	2003-05-17 04:34:56.000000000 -0700
> @@ -80,7 +80,7 @@ int sysfs_create_link(struct kobject * k
>  	char * s;
>  
>  	depth = object_depth(kobj);
> -	size = object_path_length(target) + depth * 3 - 1;
> +	size = object_path_length(target) + depth * 3 + 1;
>  	if (size > PATH_MAX)
>  		return -ENAMETOOLONG;
>  	pr_debug("%s: depth = %d, size = %d\n",__FUNCTION__,depth,size);
> 
> That probably won't fix it though.

I'm sorry to say the above patch doesn't fix the problem :-(


