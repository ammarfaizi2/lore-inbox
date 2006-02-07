Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWBGRtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWBGRtc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWBGRtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:49:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932129AbWBGRtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:49:31 -0500
Date: Tue, 7 Feb 2006 09:48:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: dada1@cosmosbay.com, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       James.Bottomley@steeleye.com, mingo@elte.hu, axboe@suse.de,
       anton@samba.org, wli@holomorphy.com, ak@muc.de
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
In-Reply-To: <20060207093458.176ac271.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602070946190.3854@g5.osdl.org>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
 <20060207151541.GA32139@osiris.boeblingen.de.ibm.com> <43E8CA10.5070501@cosmosbay.com>
 <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org> <20060207093458.176ac271.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Feb 2006, Andrew Morton wrote:
> 
> This one:
> 
> --- devel/fs/file.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-04 23:27:17.000000000 -0800
> +++ devel-akpm/fs/file.c	2006-02-04 23:27:17.000000000 -0800
> @@ -379,7 +379,6 @@ static void __devinit fdtable_defer_list
>  void __init files_defer_init(void)
>  {
>  	int i;
> -	/* Really early - can't use for_each_cpu */
> -	for (i = 0; i < NR_CPUS; i++)
> +	for_each_cpu(i)
>  		fdtable_defer_list_init(i);
>  }
> 
> And yes, me too - when I saw that comment disappear I checked and decided
> that the comment was both wrong and undesirable.

Ahh, yes. The comment is totally incorrect, we must have done the CPU 
setup much too later a long long time ago ;)

		Linus
