Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUDISpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUDISpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:45:22 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15808 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261602AbUDISpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:45:16 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1496342704.1081488562@[10.10.2.4]>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de> <1081374061.9061.26.camel@arrakis>
	 <20040407234525.4f775c16.ak@suse.de> <1081472946.12673.310.camel@arrakis>
	 <1496342704.1081488562@[10.10.2.4]>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1081536299.21205.1.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 09 Apr 2004 11:44:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds good to me.  I named it page_to_nodenum() to match
page_to_zonenum() which I named to differentiate it from page_zone().  I
have no attachment to the names whatsoever, though.

-Matt

On Thu, 2004-04-08 at 22:29, Martin J. Bligh wrote:
> > Instead of looking up a page's node number by
> > page_zone(p)->zone_pgdat->node_id, you can get the same information much
> > more efficiently by doing some bit-twidling on page->flags.  Use
> > page_nodenum(struct page *) from include/linux/mm.h.
> 
> Never noticed that before - I'd prefer we renamed this to page_to_nid 
> before anyone starts using it ... fits with the naming convention of 
> everything else (pfn_to_nid, etc). Nobody uses it right now - I grepped 
> the whole tree.
> 
> M.
> 
> diff -aurpN -X /home/fletch/.diff.exclude virgin/include/linux/mm.h name_nids/include/linux/mm.h
> --- virgin/include/linux/mm.h	Wed Mar 17 07:33:09 2004
> +++ name_nids/include/linux/mm.h	Thu Apr  8 22:27:24 2004
> @@ -340,7 +340,7 @@ static inline unsigned long page_zonenum
>  {
>  	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
>  }
> -static inline unsigned long page_nodenum(struct page *page)
> +static inline unsigned long page_to_nid(struct page *page)
>  {
>  	return (page->flags >> (NODEZONE_SHIFT + ZONES_SHIFT));
>  }
> 
> 
> 
> 
> 
> 

