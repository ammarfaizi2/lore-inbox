Return-Path: <linux-kernel-owner+w=401wt.eu-S1161170AbXAMCMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbXAMCMz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 21:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbXAMCMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 21:12:55 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:37277 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1161195AbXAMCMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 21:12:54 -0500
Message-ID: <368654358.17532@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 13 Jan 2007 10:13:20 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
Message-ID: <20070113021320.GA6055@mail.ustc.edu.cn>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <17828.33075.145986.404400@notabene.brown> <368438638.13038@ustc.edu.cn> <20070110141756.GA5572@mail.ustc.edu.cn> <17829.46603.14554.981639@notabene.brown> <368527150.02925@ustc.edu.cn> <20070111145309.GA6226@mail.ustc.edu.cn> <17830.46175.410277.466742@notabene.brown> <368569131.07190@ustc.edu.cn> <20070112023251.GA6136@mail.ustc.edu.cn> <17831.58571.460279.128732@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17831.58571.460279.128732@notabene.brown>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 06:43:07AM +1100, Neil Brown wrote:
> 
> Ok, thanks.  I must have missed something else wrong in the code......
> 
> Probably this 'break' in the wrong place...
> 
> Could you try this patch instead please - or just move the 'break' to
> where it should be.

Now it worked :)

Thanks,
Wu

> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/nfsd/nfssvc.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
> --- .prev/fs/nfsd/nfssvc.c	2007-01-11 14:55:38.000000000 +1100
> +++ ./fs/nfsd/nfssvc.c	2007-01-13 06:40:12.000000000 +1100
> @@ -72,7 +72,7 @@ static struct svc_program	nfsd_acl_progr
>  	.pg_prog		= NFS_ACL_PROGRAM,
>  	.pg_nvers		= NFSD_ACL_NRVERS,
>  	.pg_vers		= nfsd_acl_versions,
> -	.pg_name		= "nfsd",
> +	.pg_name		= "nfsacl",
>  	.pg_class		= "nfsd",
>  	.pg_stats		= &nfsd_acl_svcstats,
>  	.pg_authenticate	= &svc_set_client,
> @@ -118,16 +118,16 @@ int nfsd_vers(int vers, enum vers_op cha
>  	switch(change) {
>  	case NFSD_SET:
>  		nfsd_versions[vers] = nfsd_version[vers];
> -		break;
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  		if (vers < NFSD_ACL_NRVERS)
> -			nfsd_acl_version[vers] = nfsd_acl_version[vers];
> +			nfsd_acl_versions[vers] = nfsd_acl_version[vers];
>  #endif
> +		break;
>  	case NFSD_CLEAR:
>  		nfsd_versions[vers] = NULL;
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  		if (vers < NFSD_ACL_NRVERS)
> -			nfsd_acl_version[vers] = NULL;
> +			nfsd_acl_versions[vers] = NULL;
>  #endif
>  		break;
>  	case NFSD_TEST:
