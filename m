Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273304AbTG3TLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273298AbTG3TLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:11:40 -0400
Received: from 3eea282f.cable.wanadoo.nl ([62.234.40.47]:19218 "EHLO
	diana.kozmix.org") by vger.kernel.org with ESMTP id S273304AbTG3TLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:11:33 -0400
Date: Wed, 30 Jul 2003 21:11:15 +0200
From: Sander van Malssen <svm@kozmix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: yoh@onerussian.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-ID: <20030730191115.GA733@kozmix.org>
Mail-Followup-To: Sander van Malssen <svm@kozmix.org>,
	Andrew Morton <akpm@osdl.org>, yoh@onerussian.com,
	linux-kernel@vger.kernel.org
References: <20030729153114.GA30071@washoe.rutgers.edu> <20030729135025.335de3a0.akpm@osdl.org> <20030730170432.GA692@kozmix.org> <20030730120002.29c13b0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730120002.29c13b0c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 30 July 2003 at 12:00:02 -0700, Andrew Morton wrote:

> OK, looks like the new readahead stuff confused the error reporting.
> 
> Does this make the error messages go away?
> 
> 
> diff -puN mm/readahead.c~a mm/readahead.c
> --- 25/mm/readahead.c~a	2003-07-30 11:58:07.000000000 -0700
> +++ 25-akpm/mm/readahead.c	2003-07-30 11:58:20.000000000 -0700
> @@ -96,7 +96,7 @@ static int read_pages(struct address_spa
>  	struct pagevec lru_pvec;
>  	int ret = 0;
>  
> -	current->flags |= PF_READAHEAD;
> +//	current->flags |= PF_READAHEAD;
>  
>  	if (mapping->a_ops->readpages) {
>  		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);

That seems to have fixed it!


Cheers,
Sander

-- 
     Sander van Malssen -- svm@kozmix.org -- http://www.kozmix.org/
      http://www.peteandtommysdayout.com/ -- http://www.1-2-5.net/
