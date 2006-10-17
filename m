Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWJQSg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWJQSg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWJQSg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:36:27 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:34275 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751416AbWJQSg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:36:26 -0400
Date: Tue, 17 Oct 2006 11:29:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>,
       Carsten Otte <cotte@freenet.de>
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061017112931.80ce9ca4.akpm@osdl.org>
In-Reply-To: <4534FA99.2080009@fr.ibm.com>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<4534FA99.2080009@fr.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 17:45:29 +0200
Cedric Le Goater <clg@fr.ibm.com> wrote:

> > +mm-fix-pagecache-write-deadlocks.patch
> 
> filemap_xip.c needs a fix also.
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> ---
>  mm/filemap_xip.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: 2.6.19-rc2-mm1/mm/filemap_xip.c
> ===================================================================
> --- 2.6.19-rc2-mm1.orig/mm/filemap_xip.c
> +++ 2.6.19-rc2-mm1/mm/filemap_xip.c
> @@ -317,7 +317,7 @@ __xip_file_write(struct file *filp, cons
>  			break;
>  		}
>  
> -		copied = filemap_copy_from_user(page, offset, buf, bytes);
> +		copied = filemap_copy_from_user_atomic(page, offset, buf, bytes);
>  		flush_dcache_page(page);
>  		if (likely(copied > 0)) {
>  			status = copied;

<looks>

I think it might actually be that simple.  I expected a lot more fuss than
that.

