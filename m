Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVF1Mxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVF1Mxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVF1Mxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:53:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:28587 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261437AbVF1Mxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:53:41 -0400
Date: Tue, 28 Jun 2005 14:40:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@lst.de>
Cc: cotte@de.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xip cleanups
Message-ID: <20050628124029.GB7460@wohnheim.fh-wedel.de>
References: <20050628120159.GA1745@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628120159.GA1745@lst.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 June 2005 14:01:59 +0200, Christoph Hellwig wrote:
> 
> adjust to kernel style and remove some unneeded NULL checks

Cool!

>  	rc = __inode_direct_access(inode, sector, &data);
> -	if (rc)
> -		return rc;
> -	clear_page((void*)data);
> -	return 0;
> +	if (!rc)
> +		clear_page(data);
> +	return rc;

I personally prefer the original code.  As a general rule, error
handling code is indented further than regular good-case code.  That
makes reading a *lot* faster and the compiler should be smart enough
to generate identical code.

What are your arguments for the change?

> -		(mapping->host,tmp.b_blocknr*(PAGE_SIZE/512) ,&data);
> +		(mapping->host,tmp.b_blocknr * (PAGE_SIZE/512), &data);
                               ^
You missed one.

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
