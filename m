Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUHaMs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUHaMs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUHaMqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:46:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2503 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268215AbUHaMmQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:42:16 -0400
Date: Tue, 31 Aug 2004 07:56:19 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] - Fixes bug in fs/ext3/super.c.
Message-ID: <20040831105619.GA4615@logos.cnet>
References: <20040830124724.5f9b2f8e.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830124724.5f9b2f8e.lcapitulino@conectiva.com.br>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 12:47:24PM -0300, Luiz Fernando N. Capitulino wrote:
> 
>  Hi Marcelo,
> 
>   Some time ago I fixed this bug in 2.6.
> 
>   There is a `return NULL' missing in ext3_get_journal() if the
>  call to journal_init_inode() fail. Note that if the error happens,
>  `journal' will be NULL and used.
> 
> (agains't 2.4.28-pre2).
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>
> 
> 
> diff -Nparu a/fs/ext3/super.c a~/fs/ext3/super.c
> --- a/fs/ext3/super.c	2004-08-07 20:26:05.000000000 -0300
> +++ a~/fs/ext3/super.c	2004-08-15 22:18:18.000000000 -0300
> @@ -1302,6 +1302,7 @@ static journal_t *ext3_get_journal(struc
>  	if (!journal) {
>  		printk(KERN_ERR "EXT3-fs: Could not load journal inode\n");
>  		iput(journal_inode);
> +		return NULL;
>  	}
>  	ext3_init_journal_params(EXT3_SB(sb), journal);
>  	return journal;

Applied, 

thanks.
