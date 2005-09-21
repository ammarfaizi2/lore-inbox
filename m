Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVIUTU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVIUTU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVIUTU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:20:57 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:5135 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751385AbVIUTU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:20:56 -0400
Message-ID: <4331B231.1040405@tmr.com>
Date: Wed, 21 Sep 2005 15:19:13 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
CC: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] uml: Fix GFP_ flags usage
References: <200509211923.21861.blaisorblade@yahoo.it> <20050921172920.10219.29856.stgit@zion.home.lan>
In-Reply-To: <20050921172920.10219.29856.stgit@zion.home.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> GFP_ATOMIC | GFP_KERNEL is meaningless and won't work. Actually it never worked,
> even in 2.4.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  arch/um/kernel/process_kern.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
> --- a/arch/um/kernel/process_kern.c
> +++ b/arch/um/kernel/process_kern.c
> @@ -82,7 +82,8 @@ unsigned long alloc_stack(int order, int
>  	unsigned long page;
>  	int flags = GFP_KERNEL;
>  
> -	if(atomic) flags |= GFP_ATOMIC;
> +	if (atomic)
> +		flags = GFP_ATOMIC;
>  	page = __get_free_pages(flags, order);
>  	if(page == 0)
>  		return(0);
> 

int flags = (atomic ? GFP_ATOMIC : GFP_KERNEL);

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

