Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWEZPYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWEZPYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWEZPYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:24:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12814 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750898AbWEZPYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:24:02 -0400
Date: Fri, 26 May 2006 17:24:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mike Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mike@halcrow.us>
Subject: Re: [PATCH 1/10] Convert ASSERT to BUG_ON
Message-ID: <20060526152401.GF17337@stusta.de>
References: <20060526142117.GA2764@us.ibm.com> <E1FjdCG-000335-IS@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FjdCG-000335-IS@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 09:21:48AM -0500, Mike Halcrow wrote:

> Use the kernel BUG_ON() macro rather than the eCryptfs ASSERT(). Note
> that this temporarily renders the CONFIG_ECRYPT_DEBUG build option
> unused. We certainly plan on using it in the future; for now, is it
> okay to leave it in fs/Kconfig, or would you like to remove it?
>...

Remove it as long as it deos nothing - re-adding it when it's actually 
used will be trivial.

> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -506,7 +506,7 @@ static int decrypt_session_key(struct ec
>  	       auth_tok->session_key.encrypted_key_size);
>  	src_sg[0].page = virt_to_page(encrypted_session_key);
>  	src_sg[0].offset = 0;
> -	ASSERT(auth_tok->session_key.encrypted_key_size < PAGE_CACHE_SIZE);
> +	BUG_ON(auth_tok->session_key.encrypted_key_size > PAGE_CACHE_SIZE);
>...

What's with (auth_tok->session_key.encrypted_key_size == PAGE_CACHE_SIZE) ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

