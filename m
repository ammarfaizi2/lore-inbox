Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVCIX5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVCIX5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVCIX43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:56:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:8365 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262334AbVCIXwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:52:07 -0500
Subject: Re: [PATCH 2/2] readahead: improve sequential read detection
From: Ram <linuxram@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <42260F30.BE15B4DA@tv-sign.ru>
References: <42260F30.BE15B4DA@tv-sign.ru>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1110412324.4816.89.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Mar 2005 15:52:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 11:08, Oleg Nesterov wrote:


..snip...

> @@ -527,7 +527,7 @@ page_cache_readahead(struct address_spac
>  	}
>  
>  out:
> -	return newsize;
> +	return ra->prev_page + 1;

This change introduces one key behavioural change in
page_cache_readahead(). Instead of returning the number-of-pages
successfully read, it now returns the next-page-index which is yet to be
read. Was this essential? 

At least, a comment towards this effect at the top of the function is
worth adding.

RP

