Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310232AbSCAACu>; Thu, 28 Feb 2002 19:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310225AbSCAABH>; Thu, 28 Feb 2002 19:01:07 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:43180 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S310234AbSB1X5c>; Thu, 28 Feb 2002 18:57:32 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Fri, 1 Mar 2002 10:57:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15486.50159.606621.827886@notabene.cse.unsw.edu.au>
Cc: nfs-devel@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5: compile error in fs/filesystems.c
In-Reply-To: message from Olaf Dietsche on Friday March 1
In-Reply-To: <87vgchi2v8.fsf@tigram.bogus.local>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 1, olaf.dietsche--list.linux-kernel@exmail.de wrote:
> Hi Neil,
> 
> here is a patch to fix fs/filesystems.c, if you configure neither NFSD
> nor NFSD_MODULE, but CONFIG_MODULES.

Thanks.
2.5.6-pre2 already has a patch for this.

NeilBrown

> 
> Regards, Olaf.
> 
> --- v2.5.5/fs/filesystems.c	Thu Feb 28 22:41:18 2002
> +++ linux/fs/filesystems.c	Fri Mar  1 00:16:29 2002
> @@ -15,14 +15,17 @@
>  #include <linux/linkage.h>
>  
>  #if ! defined(CONFIG_NFSD)
> +#if defined(CONFIG_NFSD_MODULES)
>  struct nfsd_linkage *nfsd_linkage;
> +EXPORT_SYMBOL(nfsd_linkage);
> +#endif
>  
>  long
>  asmlinkage sys_nfsservctl(int cmd, void *argp, void *resp)
>  {
>  	int ret = -ENOSYS;
>  	
> -#if defined(CONFIG_MODULES)
> +#if defined(CONFIG_NFSD_MODULES)
>  	lock_kernel();
>  
>  	if (nfsd_linkage ||
> @@ -36,6 +39,5 @@
>  #endif
>  	return ret;
>  }
> -EXPORT_SYMBOL(nfsd_linkage);
>  
>  #endif /* CONFIG_NFSD */
