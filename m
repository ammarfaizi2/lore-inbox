Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVCVP3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVCVP3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVCVP3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:29:23 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:49076 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261377AbVCVP1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:27:38 -0500
Subject: Re: [patch 1/4 with proper signed-off]
	security/selinux/ss/policydb.c: fix sparse warnings
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Domen Puncer <domen@coderock.org>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, adobriyan@mail.ru
In-Reply-To: <20050320115916.GT14273@nd47.coderock.org>
References: <20050319131938.E04781ECA8@trashy.coderock.org>
	 <20050320115916.GT14273@nd47.coderock.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 22 Mar 2005 10:19:35 -0500
Message-Id: <1111504775.15346.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-20 at 12:59 +0100, Domen Puncer wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
> 
> 
>  kj-domen/security/selinux/ss/policydb.c |   35 ++++++++++++++++++--------------
>  1 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff -puN security/selinux/ss/policydb.c~sparse-security_selinux_ss_policydb security/selinux/ss/policydb.c
> --- kj/security/selinux/ss/policydb.c~sparse-security_selinux_ss_policydb	2005-03-20 12:11:25.000000000 +0100
> +++ kj-domen/security/selinux/ss/policydb.c	2005-03-20 12:11:25.000000000 +0100
> @@ -1494,9 +1497,11 @@ int policydb_read(struct policydb *p, vo
>  		goto bad;
>  	}
>  
> -	if (buf[2] != info->sym_num || buf[3] != info->ocon_num) {
> +	if (le32_to_cpu(buf[2]) != info->sym_num ||
> +	    le32_to_cpu(buf[3]) != info->ocon_num) {
>  		printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
> -		       "not match mine (%d,%d)\n", buf[2], buf[3],
> +		       "not match mine (%d,%d)\n",
> +		       le32_to_cpu(buf[2]), le32_to_cpu(buf[3]),
>  		       info->sym_num, info->ocon_num);
>  		goto bad;
>  	}
> _

You didn't remove the loop that already converted these values to little
endian already (no that isn't the same as the earlier loop that you did
remove), so now you are converting them twice.  And why is this new code
better even if you fix this omission?  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

