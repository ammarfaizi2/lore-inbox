Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUEQWQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUEQWQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUEQWQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:16:53 -0400
Received: from nacho.zianet.com ([216.234.192.105]:3078 "HELO nacho.zianet.com")
	by vger.kernel.org with SMTP id S262538AbUEQWQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:16:26 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Mon, 17 May 2004 16:15:51 -0600
User-Agent: KMail/1.6.1
Cc: mason@suse.com, torvalds@osdl.org, lm@bitmover.com, wli@holomorphy.com,
       hugh@veritas.com, adi@bitmover.com, support@bitmover.com,
       linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <1084828124.26340.22.camel@spc0.esa.lanl.gov> <20040517142946.571a3e91.akpm@osdl.org>
In-Reply-To: <20040517142946.571a3e91.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405171615.51513.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 03:29 pm, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > 1) Apply your patch to 2.6.6-current, build with PREEMPT
> > 2) Test bk pull via ppp on reiserfs until and if it breaks.
> > 3) Test bk pull via ppp on ext3 and take a look at the s.ChangeSet file
> > if/when the failure occurs.
> > 4) Apply akpm's patch here:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=108478018304305&w=2
> > 5) Repeat 2,3
> 
> Nope.  Please just see if this makes the problem go away:
> 
> --- 25/fs/buffer.c~a	Mon May 17 14:28:51 2004
> +++ 25-akpm/fs/buffer.c	Mon May 17 14:29:02 2004
> @@ -2723,7 +2723,6 @@ int block_write_full_page(struct page *p
>  	 * writes to that region are not written out to the file."
>  	 */
>  	kaddr = kmap_atomic(page, KM_USER0);
> -	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
>  	flush_dcache_page(page);
>  	kunmap_atomic(kaddr, KM_USER0);
>  	return __block_write_full_page(inode, page, get_block, wbc);
> 
> _
> 
> If this patch is confirmed to fix things up, then and only then should you
> bother testing the vmtruncate patch.
> 
> Thanks.
> 
> 

Thank you very much Andrew.  Building now.

Steven
