Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031430AbWKUVAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031430AbWKUVAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031368AbWKUVAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:00:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56585 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031430AbWKUVAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:00:30 -0500
Date: Tue, 21 Nov 2006 22:00:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: d binderman <dcb314@hotmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 msr: remove unused variable
Message-ID: <20061121210029.GO5200@stusta.de>
References: <BAY107-F28B649DE13B7A3C02F1B459CEC0@phx.gbl> <Pine.LNX.4.64N.0611211225300.25455@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0611211225300.25455@attu4.cs.washington.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 12:27:22PM -0800, David Rientjes wrote:
> Remove unused variable in msr_write().
> 
> Reported by D Binderman <dcb314@hotmail.com>.
> 
> Cc: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
> ---
>  arch/i386/kernel/msr.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
> index d535cdb..331bd59 100644
> --- a/arch/i386/kernel/msr.c
> +++ b/arch/i386/kernel/msr.c
> @@ -195,7 +195,6 @@ static ssize_t msr_write(struct file *fi
>  {
>  	const u32 __user *tmp = (const u32 __user *)buf;
>  	u32 data[2];
> -	size_t rv;
>  	u32 reg = *ppos;
>  	int cpu = iminor(file->f_dentry->d_inode);
>  	int err;
> @@ -203,7 +202,7 @@ static ssize_t msr_write(struct file *fi
>  	if (count % 8)
>  		return -EINVAL;	/* Invalid chunk size */
>  
> -	for (rv = 0; count; count -= 8) {
> +	for (; count; count -= 8) {
>...

What about changing this to a while() loop?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

