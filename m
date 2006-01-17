Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWAQRbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWAQRbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWAQRbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:31:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:54753 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932223AbWAQRbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:31:44 -0500
Subject: Re: [PATCH] zonelists gfp_zone() is really gfp_zonelist()
From: Dave Hansen <haveblue@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060117155010.GA16135@shadowen.org>
References: <20060117155010.GA16135@shadowen.org>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 09:31:39 -0800
Message-Id: <1137519100.5526.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 15:50 +0000, Andy Whitcroft wrote:
> +/*
> + * Extract the gfp modifier space index from the flags word.  Note that
> + * this is not a zone number.
> + */
> +static inline int gfp_zonelist(gfp_t gfp)
>  {
> -       int zone = GFP_ZONEMASK & (__force int) gfp;
> -       BUG_ON(zone >= GFP_ZONETYPES);
> -       return zone;
> +       int zonelist = GFP_ZONEMASK & (__force int) gfp;
> +       BUG_ON(zonelist >= GFP_ZONETYPES);
> +       return zonelist;
>  } 

Hmm, but it's not really a zonelist, either.  It's an index into an
array of zonelists that gets you a zonelist.  How about
gfp_to_zonelist_nr()?

-- Dave

