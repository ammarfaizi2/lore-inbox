Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTJGLti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTJGLti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:49:38 -0400
Received: from intra.cyclades.com ([64.186.161.6]:49806 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262280AbTJGLth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:49:37 -0400
Date: Tue, 7 Oct 2003 08:47:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Jaroslav Kysela <perex@suse.cz>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <andrea@suse.com>,
       <riel@redhat.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] memory counting fix
In-Reply-To: <Pine.LNX.4.53.0309301318540.1362@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.44.0310070844030.1494-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I dont see why reserved pages shouldnt be counted in the processes RSS.

What I'm missing here, Jaroslav?

On Tue, 30 Sep 2003, Jaroslav Kysela wrote:

> Hi,
> 
> 	this fixes rss pages counting for drivers which returns a reserved
> page from the nopage callback (like ALSA). Thank you for applying to the
> 2.4 tree.
> 
> ===== memory.c 1.56 vs edited =====
> --- 1.56/mm/memory.c	Fri Apr  5 20:06:57 2002
> +++ edited/memory.c	Tue Sep 30 13:10:20 2003
> @@ -1287,7 +1287,8 @@
>  	 */
>  	/* Only go through if we didn't race with anybody else... */
>  	if (pte_none(*page_table)) {
> -		++mm->rss;
> +		if (!PageReserved(new_page))
> +			++mm->rss;
>  		flush_page_to_ram(new_page);
>  		flush_icache_page(vma, new_page);
>  		entry = mk_pte(new_page, vma->vm_page_prot);

I dont see why 

